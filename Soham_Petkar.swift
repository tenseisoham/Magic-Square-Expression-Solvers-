import Foundation

func parser(_ expr: String) -> [[Any]] {
    var expr = expr.replacingOccurrences(of: "^", with: "")
    expr = expr.replacingOccurrences(of: " ", with: "")

    let regex = try ! NSRegularExpression(pattern: "([+-]?\\d*)([a-z]+\\d*[a-z]?\\d*)?")
    let matches = regex.matches(in : expr, range: NSRange(expr.startIndex..., in : expr))

    var parsedTerms: [[Any]] = []

    for match in matches {
        let coefficientRange = Range(match.range(at: 1), in: expr)!
        let variableRange = Range(match.range(at: 2), in: expr)

        let coefficientStr = String(expr[coefficientRange]).trimmingCharacters( in : .whitespaces)
        var coefficient = Int(coefficientStr) ?? 1

        if coefficientStr == "+" | | coefficientStr == "-" {
            coefficient *= 1
        }

        let startIndex = expr.index(expr.startIndex, offsetBy: coefficientRange.lowerBound.utf16Offset( in : expr))

        if startIndex > expr.startIndex & & expr[expr.index(before: startIndex)] == "-" {
            coefficient *= -1
        }

        let variable = variableRange.map {String(expr[$0])}

        parsedTerms.append([coefficient, variable as Any])
    }

    parsedTerms.removeLast()
    return parsedTerms
}

func addPolynomials(_ polynomials: [String]) -> [(Int, String)] {
    var combinedTerms: [String: Int] = [:]

    for polynomial in polynomials {
        let terms = parser(polynomial)
        for term in terms {
            if let coefficient = term[0] as ? Int, let variable = term[1] as ? String {
                if let existingCoefficient = combinedTerms[variable] {
                    combinedTerms[variable] = existingCoefficient + coefficient
                } else {
                    combinedTerms[variable] = coefficient
                }
            }
        }
    }

    let result = combinedTerms.map {(variable, coefficient) in
                                    return (coefficient, variable)
                                    }

    return result
}

func extractColumns(_ matrix: [[String]]) -> [[String]] {
    var columns: [[String]] = []

    for j in 0.. < matrix[0].count {
        var column: [String] = []

        for i in 0.. < matrix.count {
            column.append(matrix[i][j])
        }

        columns.append(column)
    }

    return columns
}

func extractRows(_ matrix: [[String]]) -> [[String]] {
    return matrix
}

func extractDiagonals(_ matrix: [[String]]) -> [[String]] {
    var diagonals: [[String]] = []
    var diagonal: [String] = []

    // Extract main diagonal
    for i in 0.. < matrix.count {
        diagonal.append(matrix[i][i])
    }
    diagonals.append(diagonal)

    diagonal = []

    // Extract secondary diagonal
    for i in 0.. < matrix.count {
        diagonal.append(matrix[i][matrix.count - i - 1])
    }
    diagonals.append(diagonal)

    return diagonals
}

func extractAll(_ matrix: [[String]]) -> [[String]] {
    let allItems = extractColumns(matrix) + extractRows(matrix) + extractDiagonals(matrix)
    return allItems
}


let arr = [["8", "1", "6"], ["3", "5", "7"], ["4", "9", "2"]]
let inputMatrixTrue: [[String]] = [["x^2+2", "x^2+5x+7", "x^2+4x+6"],
                                   ["x^2+7x+9", "x^2+3x+5", "x^2-x+1"],
                                   ["x^2+2x+4", "x^2+x+3", "x^2+6x+8"]]


// Print the result
for item in result {
    print(item)
}


func magic(result: [[String]]) -> Bool {
    // Extract magic square
    let globalsum = addPolynomials(result[0])

    for item in result {
        let temp = addPolynomials(item)

        if !areEqualSets(temp, globalsum) {
            print(false)
            return false
        } else {
            continue
        }
    }

    print(true)
    return true
}

func areEqualSets(_ set1: [(Int, String)], _ set2: [(Int, String)]) -> Bool {
    guard set1.count == set2.count else {
        return false
    }

    let variableSet1 = Set(set1.map {$0.1})
    let variableSet2 = Set(set2.map {$0.1})

    return variableSet1 == variableSet2
}
let result = extractAll(inputMatrixTrue)
magic(result: result)



func parsefile() {
    let fileURL = URL(fileURLWithPath: "./input.txt")
    var matrix: [[String]] = []
    if let fileContent = try? String(contentsOf: fileURL, encoding: .utf8) {
        let lines = fileContent.components(separatedBy: "\n")
        for line in lines {
            let sanitizedLine = line.replacingOccurrences(of: "*", with: "")
            if !sanitizedLine.isEmpty { // Not an empty line
                let values = sanitizedLine.components(separatedBy: " ").map { $0.trimmingCharacters(in: .whitespaces) }
                matrix.append(values)
            } else {
                if !matrix.isEmpty {
                    print("The output is:", isMagicSquare(matrix: matrix))
                    matrix = []
                }
            }
        }
        if !matrix.isEmpty {
            print(isMagicSquare(matrix: matrix))
        }
    }
}

//parsefile()

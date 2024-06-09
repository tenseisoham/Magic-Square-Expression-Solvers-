# using StrRegex

function parser(expr)
    expr = replace(expr, "^" => "")
    expr = replace(expr, " " => "")
    # terms = matchall(r"([+-]?\d*)([a-z]+\d*[a-z]?\d*)?", expr)
    terms = collect(eachmatch(r"([+-]?\d*)([a-z]+\d*[a-z]?\d*)?", expr))
    #println(terms)
    parsed_terms = []

    for term in terms
        #println(term)
        a, b = term
        #println(a)
        #println(b)
        coefficient_str = a
        if coefficient_str == "+"
            coefficient_str = "1"
        elseif coefficient_str == "-"
            coefficient_str = "-1"
        end

        if (isempty(coefficient_str))
            continue
        end
        coefficient = parse(Int, coefficient_str)
        #println(coefficient)
        variable = term[2]
        if isnothing(variable)
            variable = "const"
        end
        push!(parsed_terms, [coefficient, variable])
    end
    return parsed_terms
end

# Example usage
#expr = "4xy^2 + x^2y - 5x^2y^3 + 3"
#result = parser(expr)
#for i in result
#println(i)
#end

function add_polynomials(polynomials)
    combined_terms = Dict{String,Int}()
    for polynomial in polynomials
        terms = parser(polynomial)
        #println(terms)
        for term in terms
            coefficient, variable = term
            if haskey(combined_terms, variable)
                combined_terms[variable] += coefficient
            else
                combined_terms[variable] = coefficient
            end
        end
    end

    result = [(coefficient, variable)
              for (variable, coefficient) in pairs(combined_terms)]
    return result
end

# Example usage
polynomials = ["4xy^2 + x^2y - 5x^2y^3 +3", "2xy + 3x^2 - xy^2"]
result = add_polynomials(polynomials)
println(result)


# Example usage
function extract_columns(matrix)
    n = length(matrix)
    m = length(matrix[1])
    columns = Vector{Vector{AbstractString}}(undef, m)
    for j in 1:m
        column = Vector{AbstractString}(undef, n)
        for i in 1:n
            println(matrix[i][j])
            column[i] = matrix[i][j]
        end
        columns[j] = column
    end
    return columns
end

function extract_rows(matrix)
    rows = copy(matrix)
    return rows
end

function extract_diagonals(matrix)
    n = length(matrix)
    diagonals = Vector{Vector{AbstractString}}(undef, 2)
    diagonal = Vector{AbstractString}(undef, n)

    # Extract main diagonal
    for i in 1:n
        diagonal[i] = matrix[i][i]
    end
    push!(diagonals, diagonal)

    diagonal = Vector{AbstractString}(undef, n)
    # Extract secondary diagonal
    for i in 1:n
        diagonal[i] = matrix[i][n-i+1]
    end
    push!(diagonals, diagonal)

    return diagonals[3:end]
end


function extract_all(matrix)
    all_items = vcat(extract_columns(matrix), extract_rows(matrix), extract_diagonals(matrix))
    return all_items
end

# Example usage
##result = extract_all(matrix)
#println(result)

function magic(result)
    globalsum = add_polynomials(result[1])
    for item in result
        temp = add_polynomials(item)
        if Set(temp) != Set(globalsum)
            println(false)
            return false
        else
            continue
        end
    end
    println(true)
    return true
end

function file_parser()
    sq_matrix = []
    open("input.txt") do file
        for line in eachline(file)
            line = replace(line, r"\*" => "")

            if strip(line) != ""
                lst = split(strip(line))
                lst = [lstrip(value) for value in lst]
                push!(sq_matrix, lst)
            else
                if (length(sq_matrix) == 0)
                    continue
                end
                converted_square = extract_all(sq_matrix)
                result = magic(converted_square)
                if (result)
                    println("Magic square = True")
                else
                    println("Not a magic square = False")
                end
                sq_matrix = []
            end
        end
    end
end

file_parser()






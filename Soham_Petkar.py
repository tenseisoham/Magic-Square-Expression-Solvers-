import re


def parser(expr):
    expr = expr.replace('^', '')
    expr = expr.replace(' ', '')
    terms = re.findall(r'([+-]?\d*)([a-z]+\d*[a-z]?\d*)?', expr)
    parsed_terms = []
    for term in terms:
        coefficient_str = term[0].strip().replace(" ", "")
        if coefficient_str == "+" or coefficient_str == "-":
            coefficient_str += "1"
        coefficient = int(coefficient_str) if coefficient_str else 1
        if expr.index(term[0]) > 0 and expr[expr.index(term[0])-1] == '-':
            coefficient *= -1
        variable = term[1]
        parsed_terms.append([coefficient, variable])
    del parsed_terms[-1]
    return parsed_terms


def add_polynomials(polynomials):
    combined_terms = {}

    for polynomial in polynomials:
        terms = parser(polynomial)
        for term in terms:
            coefficient, variable = term
            if variable in combined_terms:
                combined_terms[variable] += coefficient
            else:
                combined_terms[variable] = coefficient

    result = [(coefficient, variable)
              for variable, coefficient in combined_terms.items()]
    return result


def extract_columns(matrix):
    columns = []
    for j in range(len(matrix[0])):
        column = []
        for i in range(len(matrix)):
            column.append(matrix[i][j])
        columns.append(column)
    return columns


def extract_rows(matrix):
    rows = []
    for i in range(len(matrix)):
        rows.append(matrix[i])
    return rows


def extract_diagonals(matrix):
    diagonals = []
    diagonal = []
    # Extract main diagonal
    for i in range(len(matrix)):
        diagonal.append(matrix[i][i])
    diagonals.append(diagonal)
    diagonal = []
    # Extract secondary diagonal
    for i in range(len(matrix)):
        diagonal.append(matrix[i][len(matrix) - i - 1])
    diagonals.append(diagonal)
    return diagonals


def extract_all(matrix):
    all_items = extract_columns(
        matrix) + extract_rows(matrix) + extract_diagonals(matrix)
    return all_items


def magic(result):
    # Extract magic square
    globalsum = add_polynomials(result[0])
    for item in result:
        temp = add_polynomials(item)
        if (set(temp) != set(globalsum)):
            print(False)
            return False

        else:
            continue
    print(True)
    return True


def parse_file1(filename):
    matrices = []
    current_matrix = []

    with open(filename, 'r') as file:
        for line in file:
            line = line.strip().replace('*', '')

            if line:
                matrix_row = line.split(' ')
                current_matrix.append(matrix_row)
            else:
                if current_matrix:
                    matrices.append(current_matrix)
                current_matrix = []

        if current_matrix:
            matrices.append(current_matrix)

    return matrices


ex = parse_file1('input.txt')
for i in ex:
    print(i)
    magic(extract_all(i))

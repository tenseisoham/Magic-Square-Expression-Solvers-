#  README

This repository contains code for performing polynomial operations and checking for a magic square using Julia, Python, and Swift with the Regex package.

## Parser

The `parser` function is responsible for parsing a given polynomial expression. It takes a string expression as input and returns a list of parsed terms. The terms are represented as pairs of coefficients and variables. The parser follows the lexicographic order for variables and exponents.

## Adding Polynomials

The `add_polynomials` function allows you to add multiple polynomials together. It takes a list of polynomials as input and returns the combined polynomial as a list of terms. The function utilizes the `parser` function to parse each polynomial expression and then combines the terms with matching variables.

## Extracting Columns, Rows, and Diagonals

The repository also includes functions for extracting columns, rows, and diagonals from a given matrix. The `extract_columns`, `extract_rows`, and `extract_diagonals` functions enable you to extract these elements from a matrix and store them as separate lists.

## Extracting All Elements

The `extract_all` function provides a convenient way to extract all the columns, rows, and diagonals from a matrix. It combines the results of `extract_columns`, `extract_rows`, and `extract_diagonals` into a single list.

## Magic Square Check

The `magic` function is designed to check if a given matrix forms a magic square. It takes a matrix as input and checks if the sum of all the extracted elements (columns, rows, and diagonals) is equal. The function uses the `add_polynomials` function to calculate the sum of the elements.

## Usage Examples

To use the provided code, you can follow the example usage mentioned in the comments within the script. These examples demonstrate how to parse polynomials, add them together, extract columns, rows, and diagonals from a matrix, and check for a magic square.

Feel free to modify the code and adapt it to suit your specific requirements. Enjoy polynomial operations and exploring magic squares!
```python
# Polynomial Magic Square
This Python program demonstrates the concept of a magic square using polynomials.
It allows you to input a matrix of polynomials and checks whether the matrix is
a magic square based on certain polynomial operations.
## Prerequisites
- Python 3.x
## Usage
Readme File 2
1. Open the `magic_square.py` file in a Python IDE or text editor.
2. Modify the `arr` variable to define your input matrix. Each element in the matrix
should be a polynomial expression represented as a string.
3. Run the program. It will perform the following steps:
- Extract all columns, rows, and diagonals from the matrix.
- Apply polynomial operations to combine the terms in each row, column, and diagonal.
- Check whether the combined terms are equal across all rows, columns, and diagonals.
4. The program will print the extracted matrix and the result of the magic square
check (`True` or `False`).
## Examples
- Example 1:
Input Matrix:
```
[['8', '1', '6'],
['3', '5', '7'],
['4', '9', '2']]
```
Output:
```
[(['8', '3', '4'], ['1', '5', '9'], ['6', '7', '2'])]
True
```
- Example 2:
Input Matrix:
```
[['x^2+2', 'x^2+5x+7', 'x^2+4x+6'],
['x^2+7x+9', 'x^2+3x+5', 'x^2-x+1'],
['x^2+2x+4', 'x^2+x+3', 'x^2+6x+8']]
```
Output:
```
[(['x^2+2', 'x^2+7x+9', 'x^2+2x+4'],
['x^2+5x+7', 'x^2+3x+5', 'x^2+x+3'],
['x^2+4x+6', 'x^2-x+1', 'x^2+6x+8'])]
True
```
## Notes
-I have done the file parsers in Python and Julia, for swift you need to use the
function inside
-Put the matrix name inside EXTRACT_ALL FUNCTION for swift
- The program uses regular expressions to parse and extract polynomial terms from the
input expressions.
- The polynomial expressions should follow a specific format: coefficient followed
by variables and exponents, separated by arithmetic operators (`+` or `-`).
-FOLLOW A STRICT FORMAT, EX. IF USING XY, USE THAT THROUGHOUT, DONT USE YX IN BETWEEN
-To ensure consistent representation, please follow a format that adheres to lexicographic
order for variables and exponents. For example, use `xy`, and `x^2y`, rather than `yx^2`.
- Make sure to provide valid polynomial expressions as input to ensure correct results

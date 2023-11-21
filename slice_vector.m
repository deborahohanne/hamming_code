function X = slice_vector(vector)

% Número desejado de colunas na matriz
number_columns = 4;

% Calcula o número de linhas necessário
number_rows = numel(vector) / number_columns;

% Use a função reshape para transformar o vetor em uma matriz
matrix = reshape(vector, number_columns, number_rows)';

% Exibe a matriz resultante
X = matrix;

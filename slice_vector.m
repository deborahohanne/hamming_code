function X = slice_vector(vector, m)

% Número desejado de colunas na matriz
number_columns = m

% Calcula o número de linhas necessário
number_rows = ceil(numel(vector) / number_columns)
resto = mod(numel(vector),m)
% Se o resto da divisão do tamanho do vetor pelo tamanho de linhas for 0 
if resto == 0
    % Use a função reshape para transformar o vetor em uma matriz
    matrix = reshape(vector, number_columns, number_rows)';
%resto da divisão diferente de 0   
else
    % cria um vetor auxiliar de 1 linha com zeros para completar o
    % necessário para a matriz ao final.
    aux = zeros(1,m - resto);
    %concatena o vetor existente com o vetor auxiliar.
    vector = [vector aux];
    % Use a função reshape para transformar o vetor auterado em uma matriz
    matrix = reshape(vector, number_columns, number_rows)';
end
% Exibe a matriz resultante
X = matrix;

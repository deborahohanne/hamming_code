function X = matrix2vector(matrix, k, y)
    % Obtém o número total de linhas e colunas da matriz
    [num_rows, num_cols] = size(matrix);
    
    % Verifica se k e y estão dentro dos limites
    assert(k <= num_cols, 'k deve ser menor ou igual que o número total de colunas.');
    assert(y <= k, 'y deve ser menor ou igual a k.');
    
    % Inicializa a matriz_without_last_row
    vector_matrix_without_last_row = [];
    %disp(['k: ' num2str(k) ' y: ' num2str(y) ' Size Matrix: ' num2str(size(matrix)) ' Size  matrix_without_last_row: ' num2str(size(vector_matrix_without_last_row))])

    % Exclui a última linha da matriz e concatena as linhas restantes
    for row = 1:num_rows-1
        % Obtém a linha atual excluindo as últimas colunas -k
        current_row = matrix(row, 1:k);
        % Concatena a linha atual à matriz_without_last_row
        vector_matrix_without_last_row = [vector_matrix_without_last_row current_row];
    end
    
    % Obtém a última linha da matriz, considerando apenas as primeiras y colunas
    last_row = matrix(end, 1:y);

    % Concatena a última linha ao vetor coluna
    X = [vector_matrix_without_last_row, last_row];
    % disp(['Size X: ' num2str(size(X))])
end

function X = full_matrix2vector(matrix)
    % Obtém o número total de linhas e colunas da matriz
    [num_rows, num_cols] = size(matrix);
    vector =[];
    
   for row = 1:num_rows
        % Obtém a linha atual excluindo as últimas colunas -k
        current_row = matrix(row, :);
        % Concatena a linha atual à matriz_without_last_row
        vector = [vector current_row];
    end
    
   
    X = [vector];
    disp(['Size X full: ' num2str(size(X))])
end

function [X, num_colunas, mini] = binarization(vetor)
    mini = min(vetor) * -1;
    disp(['Min: ' num2str(mini)])
    % Definindo o valor a ser adicionado ao vetor
    x = mini;
    
    % Adicionando x a todos os elementos do vetor
    vetor_modificado = vetor + x;

    % Convertendo cada elemento do vetor modificado para binário
    aux = dec2bin(vetor_modificado);
    %disp(['aux: ', num2str(size(aux))]);

    % Concatenando os resultados em um único vetor de caracteres
    vetor_binario_concatenado = '';
    [num_linhas, num_colunas] = size(aux);
    for linha = 1:num_linhas
        for coluna = 1:num_colunas
            vetor_binario_concatenado = [vetor_binario_concatenado, aux(linha, coluna)];
        end
    end

    % Convertendo o vetor de strings binárias para vetor de números
    % Lidando com possíveis erros de conversão
    X = zeros(1, length(vetor_binario_concatenado));
    for i = 1:length(vetor_binario_concatenado)
        if vetor_binario_concatenado(i) == '0'
            X(i) = 0;
        elseif vetor_binario_concatenado(i) == '1'
            X(i) = 1;
        else
            disp('errro em ' + i + 'com o valor de: ' + X(i) );
        end
    end
end

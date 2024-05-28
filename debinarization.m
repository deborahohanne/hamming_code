function X = debinarization(vetor, tam, minimo)
    % Calculando o número de blocos de tam elementos
    num_blocos = numel(vetor) / tam;
    X =[];
    % Percorrendo cada bloco de tam elementos
    for i = 1:num_blocos
        % Índices do bloco atual
        inicio = (i - 1) * tam + 1;
        fim = i * tam;
        
        % Convertendo o bloco de números binários para uma única string
        binario_str =(char('0' + vetor(inicio:fim)));
        %disp(['binario_str: ' num2str(binario_str)]);
        
        % Convertendo a representação binária de volta para um número decimal
        X = [X bin2dec(binario_str)];
    end
X = X - minimo;
end


function decoded_message  = decode_hamming(encoded_message, H)

% Supondo que H seja a matriz de paridade
[nk, n] = size(H);

% Conta o número de bits de paridade (linhas não nulas)
num_bits_paridade = nk;

% Calcula k (número de bits de dados)
k = n - num_bits_paridade;
decoded_message = decode(encoded_message,n,k, 'hamming/binary');
end

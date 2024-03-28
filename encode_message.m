function matrix_encoded_message = encode_message(message, G)

G_Sizes = size(G);
sizes = size(message);
rows = sizes(1);
columns = sizes(2);
matrix = zeros(rows,G_Sizes(2));
for i = 1:size(message)
    aux = (message(i,:));
    encoded_message = rem(aux*G, 2);
    matrix(i,:) = encoded_message;

end
test = encode(message, G_Sizes(2), G_Sizes(1), 'hamming/binary');
matrix_encoded_message = matrix;
disp(matrix_encoded_message(1,:))
disp(test(1,:))


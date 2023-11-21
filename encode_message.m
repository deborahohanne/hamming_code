function matrix_encoded_message = encode_message(message, G, number_columns)
number_rows = size(message);
matrix = zeros(number_rows(1), number_columns);
for i = 1:size(message)
    aux = (message(i,:));
    encoded_message = rem(aux*G, 2);
    matrix(i,:) = encoded_message;

end
test = encode(message, 7, 4, 'hamming/binary');
matrix_encoded_message = matrix;
disp(matrix_encoded_message(1,:))
disp(test(1,:))


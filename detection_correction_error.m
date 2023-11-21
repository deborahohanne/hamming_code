function matrix_corrected_message  = detection_correction_error(encoded_message, H)

tsindrome = syndtable(H);
%disp(tsindrome);
matrix_size = size(encoded_message)
matrix_corrected_message = zeros(matrix_size(1), matrix_size(2))
for i = 1:matrix_size(1)
    sindrome = rem(encoded_message(i,:)*H',2);
    %disp(sindrome);
    %transformar em decimal
    sdec = bi2de(sindrome, 'left-msb');
    %disp(sdec);
    % corrigir erro
    vector_corrected = tsindrome(1+sdec,:);
    %disp('Vector_correted')
    %disp(vector_corrected)
    corrected_message = rem(encoded_message(i,:) + vector_corrected, 2);
    %disp('Correted_message')
    %disp(corrected_message)
    %dirvegencia entre dois vetores
    %disp(biterr(encoded_message(1,:), corrected_message));
    matrix_corrected_message(i,:) = corrected_message;
end
disp(biterr(encoded_message, matrix_corrected_message));

end

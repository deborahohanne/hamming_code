function TCC()

file_path = 'C:/Users/rafae/OneDrive/Documentos/MATLAB/sinais/lista_de_arquivos.txt';

fid = fopen(file_path, 'r');

if fid == -1
    error('Unable to open the file %s.', file_path);
end

file_list = {};


while ~feof(fid)
    line = fgetl(fid); % Read a line from the file
    file_list = [file_list, line]; % Add the line to the cell array
end

fclose(fid);

% Define o nome da pasta pai
parent_folder = 'TCC';

% Cria a pasta pai se ela não existir
if ~exist(parent_folder, 'dir')
    mkdir(parent_folder);
end
try
    %diary(fullfile(parent_folder, 'logfile.txt'));
noises =[0.2 0.1 0.05 0.03 0.01 0.001 0.0001 0.00001];
% Now you can iterate over the file list with a for loop
for i = 1:length(file_list)
    disp(['Arquivo: ' file_list{i}])
    dados = read_datas(['sinais/' file_list{i}]);
    [dados_bin, tam, minimo] = binarization(dados);
    % disp(['Tam: ' num2str(tam) ]);


    % if tam == 16
        % Define o nome da subpasta usando o nome do arquivo original
        subfolder = fullfile(parent_folder, file_list{i});
        
        % Cria a subpasta se ela não existir
        if ~exist(subfolder, 'dir')
            mkdir(subfolder);
        end


        plot(abs(fft(dados)));
        title('Sinal Original');
        xlabel('Frequência');
        ylabel('Amplitude');
        file_name = fullfile(subfolder, 'Sinal_Original.png');
        saveas(gcf, file_name);

        % file_name_original_vector= fullfile(subfolder, 'Original_vector.csv');
        % writematrix(dados_bin,file_name_original_vector, 'delimiter', ';');

        for order = 3:10
            disp(['  Inicio Ordem: ' num2str(order)]);
            [H G n k] = create_matrixes(order);
            [x, y] = slice_vector(dados_bin,k);
            %disp(['k: ' num2str(k) ', n: ' num2str(n) ', y: ' num2str(y) ', order: ' num2str(order)]);

            encoded = encode_message(x,G);
                
            
            subsubfolder = fullfile(subfolder, num2str(order));
            if ~exist(subsubfolder, 'dir')
                mkdir(subsubfolder);
            end
            % file_name_matrix_encoded = [fullfile(subsubfolder,'Encoded_matrix.csv')];
            % file_name_original_vector= fullfile(subfolder, 'Original_matrix.csv');
            % writematrix(x,file_name_original_vector, 'delimiter', ';');
            % writematrix(encoded,file_name_matrix_encoded, 'delimiter', ';');
            
            
            % disp(['Size dados_bin: ' num2str(size(dados_bin))]);
            vector_SNR_before = [];
            vector_SNR_after = [];
            for noise = 1:length(noises)

                subtitle_text = ['Ordem de ' num2str(order) ' e Ruído de ' num2str(noises(noise)*100) '%'];
                [noised, coords] = criar_ruido(encoded, noises(noise));
                sn1 = matrix2vector(noised,k,y);
                rs1 = debinarization(sn1,tam,minimo);
                % disp(['Min rs1: ' num2str(min(rs1)) ' Min original: ' num2str(min(dados))]);
                % disp(['PosMin rs1: '  num2str(find(rs1 == min(rs1)))])
                % disp(['PosMin dados: '  num2str(find(dados == min(dados)))])
                % disp(['Max rs1: ' num2str(max(rs1)) ' Max original: ' num2str(max(dados))]);
                % disp(['PosMax rs1: ' num2str(find(rs1 == max(rs1)))])
                % disp(['PosMax dados: ' num2str(find(dados == max(dados)))])
                
                plot(abs(fft(rs1)));
                title('Espectro do Sinal com Ruído');
                subtitle(subtitle_text);
                xlabel('Frequência');
                ylabel('Amplitude');
                noised_signal = ['Sinal_ruidoso_' num2str(noises(noise)) '.png'];
                file_name1 = fullfile(subsubfolder, noised_signal);
                saveas(gcf, file_name1);

               
                s1=SNR(dados_bin,sn1);
                vector_SNR_before = [vector_SNR_before s1];
                
                
                
                
                m = detection_correction_error(noised,H);
                decoded = decode_hamming(m,H);
                v1 = matrix2vector(decoded,k,y);
                %v2 = full_matrix2vector(decoded);
                rs2 = debinarization(v1,tam,minimo);
                % disp(['Min rs2: ' num2str(min(rs2)) ' Min original: ' num2str(min(dados))]);
                % disp(['Max rs2: ' num2str(max(rs2)) ' Max original: ' num2str(max(dados))]);

                s2=SNR(dados_bin,v1);
                vector_SNR_after = [vector_SNR_after s2];
               
                plot(abs(fft(rs2)));
                title('Espectro do sinal recuperado');
                subtitle(subtitle_text);
                xlabel('Frequência');
                ylabel('Amplitude');
                recovered_signal = ['Sinal_recuperado_' num2str(noises(noise)) '.png'];
                file_name2 = fullfile(subsubfolder, recovered_signal);
                
                saveas(gcf, file_name2);
            end
            
            %PLOT
            txTitle= ['Relação Ruido vs SNR'];
            txSubtitle1= ['Ordem de ' num2str(order) ' Antes de recuperar'];
            txSubtitle2= ['Ordem de ' num2str(order) ' Depois de recuperar'];
           
            plot(noises, vector_SNR_before);
            title(txTitle);
            subtitle(txSubtitle1);
            ylabel('SNR');
            xlabel('Ruído');
            noised_relation = ['Plot_Relacao_SNR_Ruido_pre_3.png'];
            file_name2 = fullfile(subsubfolder, noised_relation);
            saveas(gcf, file_name2);
            
            
            plot(noises, vector_SNR_after);
            title(txTitle);
            subtitle(txSubtitle2);
            ylabel('SNR');
            xlabel('Ruído');
            noised_relation = ['Plot_Relacao_SNR_Ruido_pos_3.png'];
            file_name2 = fullfile(subsubfolder, noised_relation);
            saveas(gcf, file_name2);
            
           
            stem(noises, vector_SNR_before);
            title(txTitle);
            subtitle(txSubtitle1);
            ylabel('SNR');
            xlabel('Ruído');
            noised_relation = ['Stem_Relacao_SNR_Ruido_pre_3.png'];
            file_name2 = fullfile(subsubfolder, noised_relation);
            saveas(gcf, file_name2);
            
           
            
            stem(noises, vector_SNR_after);
            title(txTitle);
            subtitle(txSubtitle2);
            ylabel('SNR');
            xlabel('Ruído');
            noised_relation = ['Stem_Relacao_SNR_Ruido_pos_3.png'];
            file_name2 = fullfile(subsubfolder, noised_relation);
            saveas(gcf, file_name2);
            
           

            disp([' fim da ordem: ' num2str(order)]);
        end
        disp(['Fim do arquivo: ' file_list{i}]);
        disp(' ')
    end
    
      % end

    % diary off
    %disp(getReport(exception));
end
end

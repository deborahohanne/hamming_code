function X = SNR(x_orig, x_ruid)
    %disp(['Size x_orig: ' num2str(size(x_orig)) ' Size x_ruid: ' num2str(size(x_ruid))]);
    SNR = sum(x_orig.^2)/sum((x_orig-x_ruid).^2);
    SNRdB = 10*log10(SNR);
    X = SNRdB;
end
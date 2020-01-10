function res = conv_fft(data1, data2)
    len_fft = length(data1)+length(data2)-1;
    dft1 = fft([data1], len_fft);
    dft2 = fft([data2], len_fft);
    dft_ans = dft1 .* dft2;
    res = ifft(dft_ans);
end
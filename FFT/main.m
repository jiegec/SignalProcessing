data1 = [1,2,3,4];
data2 = [5,6,7,8];

expected = conv(data1, data2);

ans_dir = direct(data1, data2);

len_fft = length(data1)+length(data2)-1;
dft1 = fft([data1], len_fft);
dft2 = fft([data2], len_fft);
dft_ans = dft1 .* dft2;
ans_fft = round(ifft(dft_ans));

ans_oa = overlap_add(data1, data2, 2);
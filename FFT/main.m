data1 = [1,2,3,4,5,6];
data2 = [5,6,7,8];

expected = conv(data1, data2);

ans_dir = direct(data1, data2);


ans_fft = conv_fft(data1, data2);
ans_oa = overlap_add(data1, data2, 2);
ans_os = overlap_save(data1, data2, 4);
n = 10240;
L = 16;
N = 20480;
data1 = (1:n);
data2 = (1:n);

ans1 = direct(data1, data2);
ans2 = conv_fft(data1, data2);
ans3 = overlap_add(data1, data2, L);
ans4 = overlap_save(data1, data2, N);

assert(mean(ans1-ans2) < 1e-4);
assert(mean(ans1-ans3) < 1e-4);
assert(mean(ans1-ans4) < 1e-4);

f1 = @() direct(data1, data2);
timeit(f1)

f2 = @() conv_fft(data1, data2);
timeit(f2)

f3 = @() overlap_add(data1, data2, L);
timeit(f3)

f4 = @() overlap_save(data1, data2, N);
timeit(f4)
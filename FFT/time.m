n = 4096;
m = 4096;
data1 = (1:n);
data2 = (1:m);

ans1 = direct(data1, data2);
ans2 = conv_fft(data1, data2);
% Overlap Add with differnt L
ans3 = overlap_add(data1, data2, n);
ans4 = overlap_add(data1, data2, n/16);
ans5 = overlap_add(data1, data2, n/256);
ans6 = overlap_add(data1, data2, n/4096);
% Overlap Save with different N
ans7 = overlap_save(data1, data2, m);
ans8 = overlap_save(data1, data2, m*2);
ans9 = overlap_save(data1, data2, m*3);
ans10 = overlap_save(data1, data2, m*4);

% Correctness
assert(norm(ans1-ans2) < 0.01);
assert(norm(ans1-ans3) < 0.01);
assert(norm(ans1-ans4) < 0.01);
assert(norm(ans1-ans5) < 0.01);
assert(norm(ans1-ans6) < 0.01);
assert(norm(ans1-ans7) < 0.01);
assert(norm(ans1-ans8) < 0.01);
assert(norm(ans1-ans9) < 0.01);
assert(norm(ans1-ans10) < 0.01);

f1 = @() direct(data1, data2);
timeit(f1)

f2 = @() conv_fft(data1, data2);
timeit(f2)

f3 = @() overlap_add(data1, data2, n);
timeit(f3)

f4 = @() overlap_add(data1, data2, n/16);
timeit(f4)

f5 = @() overlap_add(data1, data2, n/256);
timeit(f5)

f6 = @() overlap_add(data1, data2, n/4096);
timeit(f6)

f7 = @() overlap_save(data1, data2, m);
timeit(f7)

f8 = @() overlap_save(data1, data2, m*2);
timeit(f8)

f9 = @() overlap_save(data1, data2, m*3);
timeit(f9)

f10 = @() overlap_save(data1, data2, m*4);
timeit(f10)

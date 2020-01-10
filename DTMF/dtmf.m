[sound, Fs] = audioread('dtmf-1.wav');
y = transpose(sound(:, 1)); % left


len = length(y);
freq = fft(y);
t = Fs*(0:len-1)/len;
% plot(t, abs(freq));

f = [697, 770, 852, 941, 1209, 1336, 1477, 1633];
res = [];
for i = 1:length(f)
    val = my_goertzel(y, Fs, f(i));
    res = [res; [val, f(i)]];
end

res = sortrows(res, 1, 'descend');
ans_go1 = res(1,2)
ans_go2 = res(2,2)

res2 = [];
for i = 1:length(f)
    val = freq(round(f(i)/Fs*len));
    res2 = [res2; [val, f(i)]];
end
res2 = sortrows(res2, 1, 'descend');
ans_fft1 = res2(1,2)
ans_fft2 = res2(2,2)
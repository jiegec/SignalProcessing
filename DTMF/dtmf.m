[sound, Fs] = audioread('dtmf-1.wav');
y = transpose(sound(:, 1)); % left


len = length(y);
freq = fft(y);
t = Fs*(0:len-1)/len;
% plot(t, abs(freq));

f = [697, 770, 852, 941, 1209, 1336, 1477, 1633];
res = [[0,0]];
for i = 1:length(f)
    val = my_goertzel(y, Fs, f(i));
    res = [res; [val, f(i)]];
end

res = sortrows(res, 1, 'descend');
ans1 = res(1,2)
ans2 = res(2,2)
[sound, Fs] = audioread('dtmf-0.wav');
y = transpose(sound(:, 1)); % left

len = size(y);
len = len(2);
freq = fft(y);
t = Fs*(0:len-1)/len;
plot(t, abs(freq));
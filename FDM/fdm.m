[y1, Fs1] = audioread('../DTMF/dtmf-0.wav');
[y2, Fs2] = audioread('../DTMF/dtmf-1.wav');
[y3, Fs3] = audioread('../DTMF/dtmf-2.wav');
[y4, Fs4] = audioread('../DTMF/dtmf-3.wav');

y1 = transpose(y1(:, 1)); % left
y2 = transpose(y2(:, 1)); % left
y3 = transpose(y3(:, 1)); % left
y4 = transpose(y4(:, 1)); % left

assert(Fs1 == Fs2 && Fs2 == Fs3 && Fs3 == Fs4);
Fs = Fs1;

L = 4;
up_Fs = Fs * L;

up1 = upsample(y1, L);
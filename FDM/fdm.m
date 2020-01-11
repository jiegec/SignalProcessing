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
filter1 = fir1(length(up1), 0.25);
up_f1 = conv(up1, filter1);

up2 = upsample(y2, L);
filter2 = fir1(length(up2), [0.25 0.5]);
up_f2 = conv(up2, filter2);

up3 = upsample(y3, L);
filter3 = fir1(length(up3), [0.5 0.75]);
up_f3 = conv(up3, filter3);

up4 = upsample(y4, L);
filter4 = fir1(length(up4), 0.75, 'high');
up_f4 = conv(up4, filter4);

res = up_f1 + up_f2 + up_f3 + up_f4;
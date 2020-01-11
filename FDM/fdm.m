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
order = 3000;

up1 = upsample(y1, L);
filter1 = fir1(order, 0.25);
up_f1 = filter(filter1, 1, up1);

up2 = upsample(y2, L);
filter2 = fir1(order, [0.25 0.5]);
up_f2 = filter(filter2, 1, up2);

up3 = upsample(y3, L);
filter3 = fir1(order, [0.5 0.75]);
up_f3 = filter(filter3, 1, up3);

up4 = upsample(y4, L);
filter4 = fir1(order, 0.75, 'high');
up_f4 = filter(filter4, 1, up4);

res = up_f1 + up_f2 + up_f3 + up_f4;

rec1 = filter(filter1, 1, res);
rec1_down = downsample(rec1, L)*4;

rec2 = filter(filter2, 1, res);
rec2_down = downsample(rec2, L)*4;

rec3 = filter(filter3, 1, res);
rec3_down = downsample(rec3, L)*4;

rec4 = filter(filter4, 1, res);
rec4_down = downsample(rec4, L)*4;

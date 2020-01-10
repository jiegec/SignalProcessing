function res = my_goertzel(data, Fs, freq)
    omega = freq / Fs * 2 * pi;
    vk2 = 0;
    vk1 = 0;
    vk = 0;
    y = 0;
    len = length(data);
    for i = 1:len
        vk = data(i) + 2 * cos(omega) * vk1 - vk2;
        vk2 = vk1;
        vk1 = vk;
        y = vk-vk1*exp(-1i*omega);
    end
    res = abs(exp(1i*omega)*vk-vk1);
end
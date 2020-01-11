function [] = plot_freq(data, Fs)
    len = length(data);
    freq = fft(data);
    t = Fs*(0:len-1)/len;
    plot(t, abs(freq));
end
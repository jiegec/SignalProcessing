function res = overlap_save(data1, data2, N)
    M = length(data2);
    overlap = M - 1;
    step = N - overlap;
    fft_h = fft(data2, N);
    res = zeros(1, length(data1) + M - 1);
    pos = 0;
    temp_data1 = [zeros(1, M-1), data1, zeros(1, M-1)];
    while pos <= length(data1) + M - 1
        to = min(length(temp_data1), N + pos);
        yt = ifft(fft(temp_data1(1 + pos:to), N) .* fft_h, N);
        res_to = min(step + pos, length(data1) + M -1);
        yt_to = min(N, M + res_to - pos - 1);
        res(1 + pos:res_to) = yt(M : yt_to);
        pos = pos + step;
    end
end
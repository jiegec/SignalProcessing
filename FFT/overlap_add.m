function res = overlap_add(x, h, L)
    M = length(h);
    Nx = length(x);
    N = length(h)+L-1;
    res = zeros(1, M + Nx - 1);
    i = 1;
    fft_h = fft(h, N);
    while i <= Nx
        to = min(i + L - 1, Nx);
        part = ifft(fft(x(i:to), N) .* fft_h);
        to = min(i + N - 1, M + Nx - 1);
        res(i:to) = res(i:to) + part(1:to - i + 1);
        i = i + L;
    end
end
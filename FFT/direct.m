function res = direct(data1, data2)
    res = zeros(1, length(data1)+length(data2)-1);
    
    for i = 1:length(data1)
        for j = 1:length(data2)
            res(i+j-1) = res(i+j-1) + data1(i) * data2(j);
        end
    end
end
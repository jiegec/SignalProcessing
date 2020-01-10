# 信号处理原理

## 双音频按键识别

### 实验目标

使用 MATLAB 实现 Goertzel 算法，对 DTMF 进行识别。

使用的 DTMF 音源来自 https://www.mediacollege.com/audio/tone/files/dtmf.zip ，用 ffmpeg 转换为 wav 后用于 MATLAB 程序使用。

### 实验过程

首先参考 MATLAB 上的文档对 “0” 这个音进行了 FFT：

```matlab
[sound, Fs] = audioread('dtmf-0.wav');
y = transpose(sound(:, 1)); % left

len = size(y);
len = len(2);
freq = fft(y);
t = Fs*(0:len-1)/len;
plot(t, abs(freq));
```

它的功能就是读出音频文件中的数据，得到两个声道的声音和采样频率，简单期间直接取了左声道。进行 FFT 后，把数字频率转换回模拟频率进行画图，得到了以下的图片：

![](2020-01-10-23-31-27.png)

可以看到，在九百多和一千三百多有两个峰，与理论上的 941Hz 和 1336 Hz 是吻合的。

接着，参考了[维基百科](https://en.wikipedia.org/wiki/Goertzel_algorithm)上进行实现，主要的公式如下：

![](2020-01-11-00-21-07.png)

![](2020-01-11-00-21-19.png)

与课件 PPT 上基本是一致的，然后我基本按照算法直接翻译为了 MATLAB 代码（见 my_goertzel.m）：

```matlab
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
end⏎
```

其中 vk，vk1，vk2, y 分别对应课件中对应的表示，只有最后的 res 赋值是按照维基百科的写法。

接着，简单地对所有可能的频率都调用一次 my_goertzel 函数，然后排序得到最大的两个频率就是结果了：

```matlab
f = [697, 770, 852, 941, 1209, 1336, 1477, 1633];
res = [];
for i = 1:length(f)
    val = my_goertzel(y, Fs, f(i));
    res = [res; [val, f(i)]];
end

res = sortrows(res, 1, 'descend');
ans1 = res(1,2)
ans2 = res(2,2)
```

结果截图（在 dtmf-1.wav 上运行）：

![](2020-01-11-00-25-04.png)

和理论是符合的。其他数字的声音也验证过，没有出现问题。

另一种方法是直接用内置的 FFT，然后取模拟频率对应的点上 DFT 的值，然后找到最大两个值对应的模拟频率就是我们要找的。也是用类似的方法，取出数据然后排序，得到结果：

```matlab
res2 = [];
for i = 1:length(f)
    val = freq(round(f(i)/Fs*len));
    res2 = [res2; [val, f(i)]];
end
res2 = sortrows(res2, 1, 'descend');
ans_fft1 = res2(1,2)
ans_fft2 = res2(2,2)
```

还是对 dtmf-1.wav 计算，可以看到两种方法得到的结果是一样的：

![](2020-01-11-00-32-16.png)

接下来对上面的代码进行计时，分别运行 100 次，得到总时间（cpu time）：

![](2020-01-11-00-36-51.png)

可见自己写的代码还是没有自带的 fft 快。MATLAB 有自带的 goertzel 算法的实现，肯定比自己写的更快，所以没有做更多的测试。

## 卷积计算性能比较

### 复杂度分析

1. 直接按公式计算，显然是 O(nm)
2. FFT 圆卷积计算，两次 FFT，一次 IFFT，和一次点乘，复杂度是 O((n+m)log(n+m))
3. Overlap Add，按块 FFT，块大小为 L，一共 n/L 块，所以复杂度是 O(n/L*(L+m)log(L+m))=O((n+m/L)log(L+m))
4. Overlap Save，按块 FFT，块大小为 N，一共 (n-m)/(N-m) 块，复杂度是 O((n-m)/(N-m)*(N+m)log(N+m))

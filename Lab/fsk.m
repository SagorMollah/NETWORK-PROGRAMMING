clc;
clear all;
close all;

% Binary information to be transmitted
x = [1 1 0 1 0 1];

bp = 0.000001; % Bit period

disp('Binary information at transmitter');
disp(x);

% Representation of transmitting binary information as a digital signal
bit = [];
for n = 1:length(x)
    if x(n) == 1
        se = ones(1, 100);
    else
        se = zeros(1, 100);
    end
    bit = [bit se];
end

tl = bp/100 : bp/100 : 100 * length(x) * (bp/100);

subplot(3, 1, 1);
grid on;
plot(tl, bit, 'linewidth', 2.5);
A = 5;
axis([0 bp * length(x) -0.5 1.5]);
ylabel('Amplitude (volt)');
xlabel('Time (sec)');
title('Transmitting information as a digital signal');

% Binary FSK Modulation
br = 1 / bp;
fl = br * 8;
f2 = br * 2;
t2 = bp / 99 : bp / 99 : bp;
ss = length(t2);
m = [];

for i = 1:length(x)
    if x(i) == 1
        y = A * cos(2 * pi * fl * t2);
    else
        y = A * cos(2 * pi * f2 * t2);
    end
    m = [m y];
end

t3 = bp / 99 : bp / 99 : bp * length(x);

subplot(3, 1, 2);
plot(t3, m);
xlabel('Time (sec)');
ylabel('Amplitude (volt)');
title('Waveform for binary FSK modulation corresponding to binary information');

% Binary FSK Demodulation
mn = [];
for n = ss : ss : length(m)
    t = bp / 99 : bp / 99 : bp;
    yl = cos(2 * pi * fl * t);
    y2 = cos(2 * pi * f2 * t);
    mn = [mn yl .* m((n - (ss - 1)) : n)];
    mn = [mn y2 .* m((n - (ss - 1)) : n)];
    t4 = bp / 99 : bp / 99 : bp;
    z1 = trapz(t4, mn(1:ss));
    z2 = trapz(t4, mn(ss + 1 : end));
    zz1 = round(2 * z1 / bp);
    zz2 = round(2 * z2 / bp);
    if zz1 > A / 2
        bit = [bit 1];
    elseif zz2 > A / 2
        bit = [bit 0];
    end
    mn = [];
end

disp('Binary information at Receiver');
disp(bit);

% Representation of binary information as a digital signal
bit_received = [];
for n = 1:length(bit)
    if bit(n) == 1
        se = ones(1, 100);
    else
        se = zeros(1, 100);
    end
    bit_received = [bit_received se];
end

t4 = bp / 100 : bp / 100 : 100 * length(bit) * (bp / 100);

subplot(3, 1, 3);
plot(t4, bit_received, 'Linewidth', 2.5);
grid on;
axis([0 bp * length(bit) -0.5 1.5]);
ylabel('Amplitude (volt)');
xlabel('Time (sec)');
title('Received information as a digital signal after binary FSK demodulation');

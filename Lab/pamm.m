% PAM Waveform Generation
clc;
clear all;
close all;

% Parameters
symbolRate = 1000; % Symbol rate in Hz
bitRate = symbolRate; % Bit rate in Hz
numBits = 1000; % Number of bits to transmit
t = 0:1/bitRate:numBits-1/bitRate; % Time vector

% Generate random bits
inputBits = randi([0 1], 1, numBits);

% PAM modulation (using binary amplitude levels)
pamSignal = 2*inputBits - 1;

% Plotting
subplot(2, 1, 1);
stem(0:10, inputBits(1:11), 'r', 'Marker', 'none');
title('Input Bits');
xlabel('Bit Index');
ylabel('Bit Value');
axis([0 11 -0.5 1.5]);

subplot(2, 1, 2);
plot(t, pamSignal);
title('PAM Modulated Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

% Adjust plot for better visibility
subplot(2, 1, 1);
axis tight;
subplot(2, 1, 2);
axis tight;

% Ensure both subplots share the same x-axis
linkaxes(findall(gcf, 'type', 'axes'), 'x');

% Zoom-in on a portion of the waveform
xlim([0 5*numBits/bitRate]);

%Split Phase-Manchester Coding
clc;          % Clear the command window
clear all;    % Clear all variables from the workspace
close all;    % Close all open figures

N = 10;       % Number of bits
n = randi([0, 1], 1, N);  % Generate a random sequence of N bits (0s and 1s)

%Binary to Manchester Conversion
nnn = [];     % Initialize an empty array to store Manchester-encoded signal

for m = 1:N
    if n(m) == 1
        nn = [1 -1];  % Manchester encoding for bit 1
    else
        nn = [-1 1];  % Manchester encoding for bit 0
    end
    nnn = [nnn nn];  % Concatenate the Manchester-encoded bits to the nnn array
end
nnn           % Display the Manchester-encoded signal

%Manchester Coding Pulse Shaping
i = 1;          % Initialize a variable to track the position in the Manchester-encoded signal
l = 0.5;        % Initialize the time threshold for the first half-cycle
t = 0:0.01:length(n);  % Generate time values from 0 to the length of the Manchester-encoded signal

y = zeros(size(t));  % Initialize an array to store the shaped Manchester-coded signal

for j = 1:length(t)
    if t(j) <= l  % If the current time value is less than or equal to the threshold
    y(j) = nnn(i);  % Assign the value from the Manchester-encoded signal
    else
        y(j) = nnn(i);
        i = i + 1;       % Move to the next value in the Manchester-encoded signal
        l = l + 0.5;     % Update the time threshold for the next half-cycle
    end
end

% Plotting
plot(t, y, 'LineWidth', 2);  % Plot the shaped Manchester-coded signal with line width 2
axis([0, N, -1.5, 1.5]);     % Set the x-axis limits to [0, N] and y-axis limits to [-1.5, 1.5]
grid on;                     % Show grid lines on the plot
title('Manchester Coding');   % Set the title of the plot

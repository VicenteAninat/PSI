clearvars % Limpia variables
close all % Cierra figuras
clc % Limpia consola

% 1)
[y, Fs] = audioread("sinehz_1.wav");
Fs
n = linspace(0, 48001, 48001)
plot(n, y)
xlim([0, 100])

% 2)
N = length(y)
T = 1/Fs
t = (0:N - 1) * T
[peaks, time] = findpeaks(y, t);
period = max(diff(time))
period
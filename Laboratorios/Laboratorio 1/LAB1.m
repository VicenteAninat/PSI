clearvars % Limpia variables
close all % Cierra figuras
clc % Limpia consola

% 1)
[y, ~] = audioread("xn.wav");
figure
stem(y)
% 2)
[x, fs] = audioread("sine.wav");
mediaCuadratica = rms(x);
dBFs = 10 * log(mediaCuadratica);
% 3)
w = linspace(-50, 50, 50);
H = 1./(1 + 0.6 * 1i * w);
figure
plot(abs(H))
figure
plot(angle(H))
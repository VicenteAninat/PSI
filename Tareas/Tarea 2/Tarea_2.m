clearvars
close all
clc

%% 1. Lectura de datos
% ----------------------------------------------------------------------
datos = readmatrix("co2_daily_spo.txt");
anio = datos(:,1);
co2 = datos(:, 4);
% ----------------------------------------------------------------------

%% 2. Calculo de x1 y N1
% ----------------------------------------------------------------------
filtro = (anio == 2016) | (anio == 2017);
x1 = co2(filtro);
N1 = length(x1);
% ----------------------------------------------------------------------

%% 3. Calculo de la tendencia lineal y señal de residuos
% ----------------------------------------------------------------------
[a, ~, mu] = polyfit((0:N1-1)', x1, 1);
l1 = polyval(a, (0:N1-1)', [], mu);

xr = x1 - l1;
% ----------------------------------------------------------------------

%% 4. Grafico de x1 y l1
% ----------------------------------------------------------------------
figure;
plot(0:N1-1, x1, "y", "LineWidth", 1.5); 
hold on;
plot(0:N1-1, l1, "r-", "LineWidth", 2);
hold off;

title("Tendencia lineal de la concentración de CO2 entre 2016 y 2017");
xlabel("Año");
ylabel("CO2 (ppm)");
legend("Señal x1", "Tendencia lineal l1", "Location", "northwest");
grid on;
xticks([0, 366]);
xticklabels({'2016', '2017',});
xlim([0,731]);
% ----------------------------------------------------------------------

%% 5. Grafico de xr
% ----------------------------------------------------------------------
figure;
plot(0:N1-1, xr, "y", "LineWidth", 1.5);
title("Residuos de la predicción lineal");
xlabel("Año");
ylabel("Residuos (ppm)");
legend("Residuos", "Location", "northwest");
grid on;
xticks([0, 366, 731]);
xticklabels({'2016', '2017', '2018'});
xlim([0,731])
% ----------------------------------------------------------------------

%% 6. Calculo de x2 y N2
% ----------------------------------------------------------------------
filtro = and(anio >= 2016, anio <= 2024);
x2 = co2(filtro);
N2 = length(x2);
% ----------------------------------------------------------------------

%% 7. Calculo de la tendencia lineal
% ----------------------------------------------------------------------
l2 = polyval(a, (0:N2-1)', [], mu);
% ----------------------------------------------------------------------

%% 8. Calculo de la transformada de Fourier y la aproximación
% ----------------------------------------------------------------------
Xr = fft(xr);
nh = 10;

Xr_trunc = zeros(size(Xr));
Xr_trunc(1:nh+1) = Xr(1:nh+1);
Xr_trunc(end-nh+1:end) = Xr(end-nh+1:end);

xr_approx = ifft(Xr_trunc);

n_reps = ceil(N2/N1);
xr_extended = repmat(xr_approx, n_reps, 1);
xr_extended = xr_extended(1:N2);

xp = l2 + xr_extended;
% ----------------------------------------------------------------------

%% 9. Grafico de x2, l2 y xp
% ----------------------------------------------------------------------
figure;
plot(0:N2-1, x2, "y-", "LineWidth", 1);
hold on;
plot(0:N2-1, l2, "r-", "LineWidth", 1);
hold on;
plot(0:N2-1, xp, "b-", "LineWidth", 1);
hold off;
title("Gráfico de los datos reales junto a su predicción.");
xlabel("Año");
ylabel("CO2 (ppm)");
legend("Señal real x2", "Tendencia lineal l2", ...
    "Predicción de la señal", "Location", "northwest");
grid on;
xticks([0, 366, 731, 1096, 1461, 1826, 2191, 2556, 2921, 3288]);
xticklabels({'2016', '2017', '2018', '2019', '2020', '2021', ...
    '2022', '2023', '2024', '2025'});
xlim([0, N2]);
% ----------------------------------------------------------------------

%% 10. Calculo del MAPE
% ----------------------------------------------------------------------
error = mape(x2, xp);
disp(["Error de la predicción para nh = " + num2str(nh) + ": " + num2str(error) + "%"]);
% ----------------------------------------------------------------------

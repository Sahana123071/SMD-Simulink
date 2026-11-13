% smd_analysis.m
% Analytical verification of the spring-mass-damper Simulink model (smd.slx)
clear; clc; close all;

m = 2;   % mass (kg)
c = 3;   % damping coefficient (N*s/m)
k = 3;   % spring constant (N/m)

sys = tf(1, [m c k]);          % X(s)/F(s) = 1/(m s^2 + c s + k)

wn   = sqrt(k/m);              % natural frequency
zeta = c/(2*sqrt(k*m));        % damping ratio
wd   = wn*sqrt(1 - zeta^2);    % damped frequency

fprintf('Natural frequency  wn   = %.3f rad/s\n', wn);
fprintf('Damping ratio      zeta = %.3f\n', zeta);
fprintf('Damped frequency   wd   = %.3f rad/s\n', wd);
disp('Poles:'); disp(pole(sys));

info = stepinfo(sys);
fprintf('Overshoot     = %.2f %%\n', info.Overshoot);
fprintf('Peak time     = %.2f s\n',  info.PeakTime);
fprintf('Settling time = %.2f s\n',  info.SettlingTime);
fprintf('Steady state  = %.3f\n',    dcgain(sys));

figure;
step(sys, 10); grid on;
title('Spring-Mass-Damper Step Response');
xlabel('Time (s)'); ylabel('Position x (m)');

% Optional: compare with the Simulink model
% out = sim('smd', 10);

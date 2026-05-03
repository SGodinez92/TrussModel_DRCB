clc; clear all;

dir  = 'Results.1.0.0.done';
stress_strain = load([dir '/CB_strain1_6.txt']);

figure
hold on
grid on
plot(stress_strain(:,4),stress_strain(:,3))
clear all;
close all;
figure;
x = 0:0.1:5*pi;
y1 = sin(x)*50;
plot(x*500, y1);
xlabel('Period (days)');
ylabel('Radial velocity (m/s)');
title('Radial velocity of fictional star with single planet');
figure;
y2 = sin(x)*50 + sin(x*20)*6;
plot(x*500, y2);
xlabel('Period (days)');
ylabel('Radial velocity (m/s)');
title('Radial velocity of fictional star with two planets');
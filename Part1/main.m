%% Question 1
sampling_freq = 200;
timeSamples = generate_samples(-5, 5, sampling_freq);
syms t;
y_func = exp(abs(t) / -5) * (heaviside(t + 1) - heaviside(t - 3));

y = subs(y_func, timeSamples); % y(t)
y1 = subs(y_func, 3 * timeSamples); % y(3t)
y2 = subs(y_func, timeSamples + 2); % y(t + 2)
y3 = subs(y_func, 4 - 2 * timeSamples); % y(4 - 2t)

figure('Name', 'Question 1', 'NumberTitle', 'off');
subplot(2, 2, 1);
plot(timeSamples, y);
xlabel('t');
ylabel('y(t)');
subplot(2, 2, 2);
plot(timeSamples, y1);
xlabel('t');
ylabel('y(3t)');
subplot(2, 2, 3);
plot(timeSamples, y2);
xlabel('t');
ylabel('y(t + 2)');
subplot(2, 2, 4);
plot(timeSamples, y3);
xlabel('t');
ylabel('y(4 - 2t)');

%% Question 2
% This will take sometime to run (a few minutes on my machine).
sampling_freq = 2000; % It must be much higher to satisfy nyquist criterion, but it hangs on my machine.
timeSamples = generate_samples(-10000, 10000, sampling_freq);
m = sinc(0.001 * timeSamples) .^ 2;
M = fftshift(fft(m));
F = linspace(-sampling_freq / 2, sampling_freq / 2, length(timeSamples));
figure('Name', 'Question 2 - a - F.T. of (sinc(10^-3 * t))^2', 'NumberTitle', 'off');
plot(F, abs(M));
xlim([-0.004 0.004]);
title('Magnitude graph for fourier tranform of r');

r = m .* cos(2 * pi * 100000 * timeSamples);
figure('Name', 'Question 2 - b', 'NumberTitle', 'off');
subplot(2, 1, 1);
plot(timeSamples, r);
title('r(t)');
R = fftshift(fft(r));
subplot(2, 1, 2);
plot(F, abs(R));
xlim([-0.004 0.004]);
title('Magnitude graph');

%% Question 3
%%% a
syms t n;
Fn = (1 / pi) * int(exp(-t) * exp(-1i * n * 2 * pi * (1 / pi) * t), t, 0, pi);
n = -10:10;
coefficients = eval(subs(Fn, n));

%%% b
figure('Name', 'Question 3', 'NumberTitle', 'off');
subplot(2, 1, 1);
stem(n, abs(coefficients));
title('Magnitude of Fourier Series coefficients');
subplot(2, 1, 2);
stem(n, angle(coefficients));
title('Phase of Fourier Series coefficients');
% Question 1

sampling_freq = 100;
t = generate_samples(-5, 5, sampling_freq);
y_func = @(t) exp(abs(t) / -5) .* (unit_step(t + 1) - unit_step(t - 3));

y = y_func(t);
y1 = y_func(3 * t);
y2 = y_func(t + 2);
y3 = y_func(4 - 2 * t);

subplot(2, 2, 1);
plot(t, y);
subplot(2, 2, 2);
plot(t, y1);
subplot(2, 2, 3);
plot(t, y2);
subplot(2, 2, 4);
plot(t, y3);
figure;

% Question 2
t_min = -500;
t_max = 500;
t = generate_samples(t_min, t_max, sampling_freq);
m = sinc(0.01 * t) .* sinc(0.01 * t);
T = fftshift(fft(t));
F = linspace(-sampling_freq /2, sampling_freq /2, (t_max - t_min) * sampling_freq);
plot(t, m);
figure;
plot(F, abs(T));
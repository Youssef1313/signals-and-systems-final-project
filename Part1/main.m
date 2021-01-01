% Question 1

sampling_freq = 1000;
t = generate_samples(-5, 5, sampling_freq);
y_func = @(t) exp(abs(t) / -5) .* (unit_step(t + 1) - unit_step(t - 3));

y = y_func(t);
y1 = y_func(3 * t);
y2 = y_func(t + 2);
y3 = y_func(4 - 2 * t);

figure('Name','Question 1','NumberTitle','off');
subplot(2, 2, 1);
plot(t, y);
xlabel('t');
ylabel('y(t)');
subplot(2, 2, 2);
plot(t, y1);
xlabel('t');
ylabel('y(3t)');
subplot(2, 2, 3);
plot(t, y2);
xlabel('t');
ylabel('y(t + 2)');
subplot(2, 2, 4);
plot(t, y3);
xlabel('t');
ylabel('y(4 - 2t)');


% Question 2
t_min = -2000;
t_max = 2000;
t = generate_samples(t_min, t_max, sampling_freq);
m = sinc(0.001 * t) .* sinc(0.001 * t);
M = fftshift(fft(m));
F = linspace(-sampling_freq /2, sampling_freq /2, (t_max - t_min) * sampling_freq);
magnitude = abs(M);
phase = angle(M);
figure('Name','Question 2 - a - F.T. of (sinc(10^-3 * t))^2','NumberTitle','off');
subplot(3, 1, 1);
plot(F, magnitude);
title('Magnitude graph');
subplot(3, 1, 2);
middle_index = length(F) / 2;
plot(F(middle_index-10:middle_index+10), magnitude(middle_index-10:middle_index+10));
title('Magnitude graph - zoomed in');
subplot(3, 1, 3);
plot(F, phase);
title('Phase graph');
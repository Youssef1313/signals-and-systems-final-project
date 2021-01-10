% Question 1

sampling_freq = 1000;
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


% Question 2
timeSamples = generate_samples(-2000, 2000, sampling_freq);
m = sinc(0.001 * timeSamples) .^ 2;
M = fftshift(fft(m));
F = linspace(-sampling_freq /2, sampling_freq /2, length(timeSamples));
magnitude = abs(M);
phase = angle(M);
figure('Name', 'Question 2 - a - F.T. of (sinc(10^-3 * t))^2', 'NumberTitle', 'off');
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
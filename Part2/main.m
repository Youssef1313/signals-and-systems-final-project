% Anonymous functions.
is_positive = @(x) x > 0;
is_non_negative = @(x) x >= 0;

sampling_freq = get_number('Enter sampling frequency (must be a positive number): ', is_positive);
t_min = input('Enter the start of time scale: ');
t_max = get_number('Enter the end of time scale: ', @(x) x > t_min);

breakpoints_count = get_number('Enter the number of breakpoints (must be a non-negative number): ', is_non_negative);

breakpoints = zeros(1, breakpoints_count);
for i = 1 : breakpoints_count
    breakpoints(i) = get_number(['Enter the position of breakpoint ' num2str(i)  ': '],  @(x) x > t_min && x < t_max);
end

% TODO: Sort breakpoints vs. allowing only increasing order.
breakpoints = [t_min breakpoints t_max];

t = []; % Fix high memory allocation and speed.
y = []; % Fix high memory allocation and speed.

for i = 1 : length(breakpoints) - 1
    region_min = breakpoints(i);
    region_max = breakpoints(i + 1);
    for_region_string = ['For region ' num2str(region_min) ' to ' num2str(region_max)];
    % TODO: Drop-down list https://www.mathworks.com/help/matlab/ref/uidropdown.html
    % TODO: Or, listbox (listdlg)
    % TODO: Remove hard-coded numbers (and names if possible) from the
    % following string.
    signal_type = get_number([for_region_string ', enter a number corresponding to the signal type:\n1: DC\n2: RAMP\n3: POLYNOMIAL\n4: EXPONENTIAL\n5: SINUSOIDAL\n'], @(x) SignalType.is_valid_signal_type(x));
    current_t = generate_samples(region_min, region_max, sampling_freq);
    t = [t current_t];
    switch signal_type
        case SignalType.DC
            amplitude = input('Enter amplitude for DC signal: ');
            y = [y SignalType.generate(current_t, SignalType.get_dc_predicate(amplitude))];
        case SignalType.RAMP
            slope = input('Enter slope for ramp signal: ');
            intercept = input('Enter intercept for ramp signal: ');
            y = [y SignalType.generate(current_t, SignalType.get_ramp_predicate(slope, intercept))];
        case SignalType.POLYNOMIAL
            amplitude = input('Enter amplitude for polynomial signal: ');
            power = input('Enter power for polynomial signal: ');
            intercept = input('Enter intercept for polynomial signal: ');
            y = [y SignalType.generate(current_t, SignalType.get_polynomial_predicate(amplitude, power, intercept))];
        case SignalType.EXPONENTIAL
            amplitude = input('Enter amplitude for exponential signal: ');
            exponent = input('Enter exponent for exponential signal: ');
            y = [y SignalType.generate(current_t, SignalType.get_exponential_predicate(amplitude, exponent))];
        case SignalType.SINUSOIDAL
            amplitude = input('Enter amplitude for sinusoidal signal: ');
            frequency = input('Enter frequency for sinusoidal signal: ');
            phase = input('Enter phase for sinusoidal signal: ');
            y = [y SignalType.generate(current_t, SignalType.get_sinusoidal_predicate(amplitude, frequency, phase))];
    end
end

plot(t, y);

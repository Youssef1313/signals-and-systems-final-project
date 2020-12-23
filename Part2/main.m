sampling_freq = get_number('Enter sampling frequency (must be a positive number): ', @(x) x > 0);
t_min = input('Enter the start of time scale: ');
t_max = get_number('Enter the end of time scale: ', @(x) x > t_min);

breakpoints_count = get_number('Enter the number of breakpoints (must be a non-negative number): ', @(x) x >= 0);

breakpoints = zeros(1, breakpoints_count);
for i = 1 : breakpoints_count
    breakpoints(i) = get_number(['Enter the position of breakpoint ' num2str(i)  ': '],  @(x) x > t_min && x < t_max);
end

breakpoints = [t_min sort(breakpoints) t_max];

t = []; % Fix high memory allocation and speed.
y = []; % Fix high memory allocation and speed.

for i = 1 : length(breakpoints) - 1
    region_min = breakpoints(i);
    region_max = breakpoints(i + 1);
    for_region_string = ['For region ' num2str(region_min) ' to ' num2str(region_max)];
    % TODO: Drop-down list https://www.mathworks.com/help/matlab/ref/uidropdown.html
    % TODO: Or, listbox (listdlg)
    signal_type = get_number([for_region_string ', enter a number corresponding to the signal type:\n' SignalType.get_types_message()], @(x) SignalType.is_valid_signal_type(x));
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
            max_power = get_number('Enter the order (max power) of the polynomial: ', @(x) x > 0);
            coefficients = get_polynomial_coefficients(max_power);
            y = [y SignalType.generate(current_t, SignalType.get_polynomial_predicate(coefficients))];
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

signal_operation = get_number(['Enter a number corresponding to the signal operation you want:\n' SignalOperation.get_operations_message()], @(x) SignalOperation.is_valid_signal_operation(x));
switch signal_operation
    case SignalOperation.TIME_SCALING
        scaling_factor = input('Enter scaling factor: ');
        t = t * scaling_factor;
        figure;
        plot(t, y);
    case SignalOperation.AMPLITUDE_SCALING
        scaling_factor = input('Enter scaling factor: ');
        y = y * scaling_factor;
        figure;
        plot(t, y);
    case SignalOperation.TIME_SHIFTING
        shifting_value = input('Enter shifting value (positive shifts to left, negative to right): ');
        t = t - shifting_value;
        figure;
        plot(t, y);
end
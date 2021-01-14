%% MATLAB final project - part 2
% <include>generate_samples.m</include>
%%
% <include>get_number.m</include>
%%
% <include>get_polynomial_coefficients.m</include>
%%
% <include>SignalOperation.m</include>
%%
% <include>SignalType.m</include>

sampling_freq = get_number('Enter sampling frequency (must be a positive number): ', @(x) x > 0);
t_min = get_number('Enter the start of time scale: ', @(x) true);
t_max = get_number('Enter the end of time scale: ', @(x) x > t_min);

breakpoints_count = get_number('Enter the number of breakpoints (must be a non-negative integer): ', @(x) x >= 0 && mod(x, 1) == 0);

breakpoints = zeros(1, breakpoints_count);
for i = 1 : breakpoints_count
    breakpoints(i) = get_number(['Enter the position of breakpoint ' num2str(i)  ': '],  @(x) x > t_min && x < t_max);
end
breakpoints = [t_min sort(breakpoints) t_max];

t = cell(1, length(breakpoints) - 1);
y = cell(1, length(breakpoints) - 1);

for i = 1 : length(breakpoints) - 1
    region_min = breakpoints(i);
    region_max = breakpoints(i + 1);
    for_region_string = ['For region ' num2str(region_min) ' to ' num2str(region_max)];
    % TODO: Drop-down list https://www.mathworks.com/help/matlab/ref/uidropdown.html
    % TODO: Or, listbox (listdlg)
    signal_type = get_number([for_region_string ', enter a number corresponding to the signal type:\n' SignalType.get_types_message()], @(x) SignalType.is_valid_signal_type(x));
    current_t = generate_samples(region_min, region_max, sampling_freq);
    t(i)= {current_t};
    switch signal_type
        case SignalType.DC
            amplitude = get_number('Enter amplitude for DC signal: ', @(x) true);
            y(i) = {SignalType.generate(current_t, SignalType.get_dc_function(amplitude))};
        case SignalType.RAMP
            slope = get_number('Enter slope for ramp signal: ', @(x) true);
            intercept = get_number('Enter intercept for ramp signal: ', @(x) true);
            y(i) = {SignalType.generate(current_t, SignalType.get_ramp_function(slope, intercept))};
        case SignalType.POLYNOMIAL
            max_power = get_number('Enter the order (max power) of the polynomial: ', @(x) x > 0);
            coefficients = get_polynomial_coefficients(max_power);
            y(i) = {SignalType.generate(current_t, SignalType.get_polynomial_function(coefficients))};
        case SignalType.EXPONENTIAL
            amplitude = get_number('Enter amplitude for exponential signal: ', @(x) true);
            exponent = get_number('Enter exponent for exponential signal: ', @(x) true);
            y(i) = {SignalType.generate(current_t, SignalType.get_exponential_function(amplitude, exponent))};
        case SignalType.SINUSOIDAL
            amplitude = get_number('Enter amplitude for sinusoidal signal: ', @(x) true);
            frequency = get_number('Enter frequency for sinusoidal signal: ', @(x) true);
            phase = get_number('Enter phase for sinusoidal signal: ', @(x) true);
            y(i) = {SignalType.generate(current_t, SignalType.get_sinusoidal_function(amplitude, frequency, phase))};
    end
end

plot(t{:}, y{:});
datacursormode on;

signal_operation = get_number(['Enter a number corresponding to the signal operation you want:\n' SignalOperation.get_operations_message()], @(x) SignalOperation.is_valid_signal_operation(x));
switch signal_operation
    case SignalOperation.TIME_SCALING
        scaling_factor = get_number('Enter scaling factor: ', @(x) true);
        t = {t{:} * scaling_factor};
    case SignalOperation.AMPLITUDE_SCALING
        scaling_factor = get_number('Enter scaling factor: ', @(x) true);
        y = {y{:} * scaling_factor};
    case SignalOperation.TIME_SHIFTING
        shifting_value = get_number('Enter shifting value (positive shifts to left, negative to right): ', @(x) true);
        t = {t{:} - shifting_value};
end

hold on;
plot(t{:}, y{:});
datacursormode on;
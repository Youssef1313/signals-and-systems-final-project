 classdef SignalType
    properties(Constant = true)
         DC = 1
         RAMP = 2
         POLYNOMIAL = 3
         EXPONENTIAL = 4
         SINUSOIDAL = 5
    end
    
    methods(Static)
        function f = get_types_message()
            f = [num2str(SignalType.DC) ': DC\n'...
                 num2str(SignalType.RAMP) ': Ramp\n'...
                 num2str(SignalType.POLYNOMIAL) ': General order polynomial\n'...
                 num2str(SignalType.EXPONENTIAL) ': Exponential\n'...
                 num2str(SignalType.SINUSOIDAL) ': Sinusoidal\n'];
        end

        function f = is_valid_signal_type(signal_type)
            f = signal_type == SignalType.DC ||...
                signal_type == SignalType.RAMP ||...
                signal_type == SignalType.POLYNOMIAL ||...
                signal_type == SignalType.EXPONENTIAL ||...
                signal_type == SignalType.SINUSOIDAL;
        end

        function f = generate(t, predicate)
            f = arrayfun(predicate, t);
        end
        
        function f = get_dc_predicate(amplitude)
            f = @(x) amplitude;
        end

        function f = get_ramp_predicate(slope, intercept)
            f = @(x) slope * x + intercept;
        end

        function f = get_polynomial_predicate(coefficients)
            f = @(x) polyval(coefficients, x);
        end

        function f = get_exponential_predicate(amplitude, exponent)
            f = @(x) amplitude * exp(x * exponent);
        end

        function f = get_sinusoidal_predicate(amplitude, frequency, phase)
            f = @(x) amplitude * sin(2 * pi * frequency * x + phase);
        end
    end
 end

 classdef SignalOperation
    properties(Constant = true)
        NONE = 0
        TIME_SCALING = 1 % Compression / Expansion / Time Reversal
        AMPLITUDE_SCALING = 2
        TIME_SHIFTING = 3
    end

    methods(Static)
        function f = get_operations_message()
            f = [num2str(SignalOperation.NONE) ': None\n'...
                 num2str(SignalOperation.TIME_SCALING) ': Time scaling (compression, expansion, or time reversal)\n'...
                 num2str(SignalOperation.AMPLITUDE_SCALING) ': Amplitude scaling\n'...
                 num2str(SignalOperation.TIME_SHIFTING) ': Time shifting\n'];
        end

        function f = is_valid_signal_operation(signal_operation)
            f = signal_operation == SignalOperation.NONE ||...
                signal_operation == SignalOperation.TIME_SCALING ||...
                signal_operation == SignalOperation.AMPLITUDE_SCALING ||...
                signal_operation == SignalOperation.TIME_SHIFTING;
        end
    end
 end

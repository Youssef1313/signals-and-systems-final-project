%% generate_samples helper function
% Generates a sample between min an max inputs with the specified
% frequency. The length of the output vector is (max - min) * frequency.
function f = generate_samples(min, max, frequency)
    if min >= max
        throw(MException('"max" must be greater than "min"'));
    end
    if frequency <= 0
        throw(MException('"frequency" must be positive'));
    end
    f = linspace(min, max, (max - min) * frequency);
end
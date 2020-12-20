function f = generate_samples(min, max, frequency)
    if min >= max
        throw(MException('"max" must be greater than "min"'));
    end
    if frequency <= 0
        throw(MException('"frequency" must be positive'));
    end
    f = linspace(min, max, (max - min) * frequency);
end
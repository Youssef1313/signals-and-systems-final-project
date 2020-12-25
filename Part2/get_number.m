function f = get_number(prompt, predicate)
    while 1
        n = str2double(input(prompt, 's'));
        if length(n) == 1 && isreal(n) && predicate(n)
            f = n;
            break;
        end
    end
end
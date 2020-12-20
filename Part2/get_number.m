function f = get_number(prompt, predicate)
    while 1
        n = input(prompt);
        if predicate(n)
            f = n;
            break;
        end
    end
end
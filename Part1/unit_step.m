function f = unit_step(t)
    f = arrayfun(@(x) unit_step_internal(x), t);
end

function f = unit_step_internal(t)
    if t < 0
        f = 0;
    else
        f = 1;
    end
end
%% get_polynomial_coefficients helper function
% takes a max_power and keep asks the user for the coefficient of a
% polynomial equation with the specified max_power
function f = get_polynomial_coefficients(max_power)
    % For example, third order polynomial has 4 coefficients (a, b, c, d).
    % aX^3 + bX^2 + cX^1 + d
    coefficients = zeros(1, max_power + 1);
    for i = 1 : max_power + 1
        coefficients(i) = get_number(['Enter coefficient of X^' num2str(max_power - i + 1) ': '], @(x) true);
    end
    f = coefficients;
end

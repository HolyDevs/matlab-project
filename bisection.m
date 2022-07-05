function [x_vals, y_vals] = bisection(a, b, func, epsilon, x_vals, y_vals)
    if abs(b - a) <= 2 * epsilon
        x_val = (b + a) / 2.0;
        y_vals = [y_vals, func(x_val)];
        x_vals = [x_vals, x_val];
        return;
    end
    xm = (a + b) / 2.0;
    interval = (b - a) / 4.0;
    x1 = a + interval;
    x2 = b - interval;
    if func(x2) < func(xm)
        a = xm;
    elseif func(x1) < func(xm)
        b = xm;
    else
        a = x1;
        b = x2;
    end
    x_val = (b + a) / 2.0;
    x_vals(end + 1) = x_val;
    y_vals(end + 1) = func(x_val);
    [x_vals, y_vals] = bisection(a, b, func, epsilon, x_vals, y_vals);
end
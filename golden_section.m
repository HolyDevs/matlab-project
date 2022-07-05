function [x_vals, y_vals] = golden_section(a, b, func, epsilon, x_vals, y_vals)                         
    if abs(b - a) <= 2 * epsilon
        x_val = (b + a) / 2.0;
        y_vals = [y_vals, func(x_val)];
        x_vals = [x_vals, x_val];
        return;
    end
    r = (sqrt(5.0) - 1.0) / 2.0;
    interval = b - a;
    x1 = b - r * interval;
    x2 = a + r * interval;
    if func(x1) < func(x2)
           b = x2;
    else 
           a = x1;
    end
    x_val = (b + a) / 2.0;
    x_vals(end + 1) = x_val;
    y_vals(end + 1) = func(x_val);
    [x_vals, y_vals] = golden_section(a, b, func, epsilon, x_vals, y_vals);
end

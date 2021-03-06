set(gcf,'WindowState','maximized');
write_section_values_to_file('golden_section.txt', 'golden section, func=((x^2 + 3)^2) / 8) - 2, eps=10e-6', -15, 20, @golden_section, @f1, 1e-6);
write_section_values_to_file('bisection.txt', 'bisection, func=log(2 * x^2 + 4 * x^3 + 10), eps=10e-6', -2, 3, @bisection, @f2, 1e-6);
draw_golden_section_plot(1, 'golden section, func=((x^2 + 3)^2) / 8) - 2, eps=10e-6', -15, 20, @f1, 1e-6);
draw_bisection_plot(2, 'bisection, func=log(2 * x^2 + 4 * x^3 + 10), eps=10e-6, 0.005*L_1 iternum=', -2, 3, @f2, 1e-6);

function [] = write_section_values_to_file(filename, title, a, b, section_func, func, epsilon)
    fid = fopen(filename,'w');
    fprintf(fid, strcat(title, '\n\n------------------\n'));
    x_vals = section_func(a, b, func, epsilon, [], [], []);
    matlab_val = fminbnd(func, a, b);
    for i = 1 : length(x_vals)
        fprintf(fid, 'Numer iteracji: ');
        fprintf(fid, num2str(i));
        fprintf('\n')
        fprintf(fid, '\nObecne położenie minimum: ');
        fprintf(fid, num2str(x_vals(i)));
        fprintf('\n')
        fprintf(fid, '\nModuł różnicy rozwiązań: ');
        fprintf(fid, num2str(sqrt((x_vals(i) - matlab_val).^2)));
        fprintf(fid, '\n------------------\n\n');
    end
end

function [x_vals, iters, ranges] = bisection_values_for_iterations(a, b, func, epsilon)
    [x_vals, ~, ranges] = bisection(a, b, func, epsilon, [], [], []);
    iters = [];
    for i = 1 : length(x_vals)
        iters(end + 1) = i;
    end
end

function [iter_num] = find_range_iter_number(ranges)
    if length(ranges) == 1
        iter_num = -1;
        return;
    end    
    for i = 2 : length(ranges)
        if ranges(i) <= 0.005 * ranges(1)
            iter_num = i;
            return;
        end
    end
    iter_num = -1;
end

function [] = draw_bisection_plot(plot_index, plot_title, a, b, func, epsilon)
    [x_vals, iters, ranges] = bisection_values_for_iterations(a, b, func, epsilon);
    matlab_val = fminbnd(func, a, b);
    matlab_vals = [];
    for i = 1 : length(x_vals)
        matlab_vals(end + 1) = matlab_val;
    end
    iter_num = find_range_iter_number(ranges);
    subplot(2, 1, plot_index);
    plot(iters, abs(matlab_vals));
    hold on;
    scatter(iters, abs(x_vals), 'filled', 'red');
    legend('Analityczne rozwiązanie','Przybliżone rozwiązanie', 'Location','southeast');
    title(strcat(plot_title, num2str(iter_num)));
    xlabel('Iteracja');
    ylabel('Wartość minimum');
end

function [] = draw_golden_section_plot(plot_index, plot_title, a, b, func, epsilon)
    [x_vals, y_vals] = golden_section(a, b, func, epsilon, [], [], []);
    subplot(2, 1, plot_index);
    scatter(x_vals, y_vals, 'filled', 'green')
    axis([-1 inf -10 inf]);
    title(plot_title);
    xlabel('Wartość minimum');
    ylabel('Wartość funkcji');
end
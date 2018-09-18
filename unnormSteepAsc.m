function Delta_x = unnormSteepAsc(x, g)
    [~,i] = max(abs(g));
    Delta_x = zeros(size(x));
    Delta_x(i) = g(i);
end
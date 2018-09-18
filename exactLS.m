function t = exactLS(Distro, x, Dx)
    s = 0.1:0.01:.99;
    
    ray = repmat(x,size(s'))+(Dx'*s)';

    values = [];
    for i = 1:size(ray,1)
        fx = compCostFn(Distro, x);
        values = [values;fx(1)];
    end    
    
    [~,idx] = max(values);
    t = s(idx);
end
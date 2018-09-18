function Distro = plotCostFunction(Distro)
    minVal = min(Distro.Rn);
    maxVal = max(Distro.Rn);
    minRn = min(minVal);
    maxRn = max(maxVal);
    minOpt = min(Distro.xopt);
    maxOpt = max(Distro.xopt);
    minX0 = min(Distro.x0);
    maxX0 = max(Distro.x0);
    maxQ = max(Distro.q);
    minQ = min(Distro.q);

    f = (min([minX0 minQ minRn minOpt])-2):.6:(max([maxX0 maxQ maxRn maxOpt])+2);
    [x, y] = meshgrid(f);

    for i = 1: length(f),
        parfor w = 1: length(f),
            distribution = compCostFn(Distro, [f(i) f(w)]);
            posteriorSurface(i, w) = distribution(1);
            priorSurface(i, w) = distribution(2);
            likelihoodSurface(i, w) = distribution(3);
        end
    end

    Distro.posteriorSurface = posteriorSurface';
    Distro.priorSurface = priorSurface';
    Distro.likelihoodSurface = likelihoodSurface';
    Distro.surfaceX = x;
    Distro.surfaceY = y;

    clear posteriorSurface priorSurface likelihoodSurface;
end

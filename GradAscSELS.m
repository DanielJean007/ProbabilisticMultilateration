function Distro = GradAscSELS(Distro)
% - This function receives struct Distro formed in the program
% initParameters.
% We use a fixed grid -40 to 40 to test the distributions.
    
    % Starting point
    x0 = -5+(10)*rand(1, Distro.d);

    tol = 1e-8;
    maxiter = 50000;
    g = inf; 
    niter = 0;
    x = x0;
    normGrad = [];
    steps = [];
    normGrad =  Inf;
    
    while(norm(g) >= tol & niter <= maxiter)
        steps = [steps;x];
        result = compCostFn(Distro, x);
        
        g = gdFunction(Distro, x);
        Delta_x = unnormSteepAsc(x, g);
        t = exactLS(Distro, x, g);
        x = x+t*Delta_x;
        niter = niter + 1;
        
        costFnStep(niter) = result(1);
        normGradOld = normGrad;
        normGrad(niter) = norm(g);
        if normGradOld == normGrad(niter)
            disp('No update was made...');
            break;
        end
        if normGrad(niter) > 10000
            disp('Bad starting point or jump...');
            break;
        end
        
    end 
    xopt = x;
    niter = niter - 1;

    Distro.GradErr = pdist2(Distro.q,xopt);
    Distro.xopt = xopt;
    Distro.x0 = x0;
    Distro.niter = niter;
    Distro.normGrad = normGrad;
    Distro.costFnStep = costFnStep;
    
    if niter > 0
        Distro.optVal = compCostFn(Distro, xopt);
    else
        Distro.optVal = -Inf;
    end 
    
% - Plot norm of gradient
    figure;
    plot(normGrad);
    figure;
    plot(costFnStep);
end
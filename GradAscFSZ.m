function Distro = GradAscFSZ(Distro)
% - This function receives struct Distro formed in the program
% initParameters.
% We use a fixed grid -40 to 40 to test the distributions.
    
    % Starting point
    x0 = -20+(40)*rand(1, Distro.d);
    
    tol = 1e-8;
    maxiter = 5000;
    g = inf; 
    niter = 0;
    x = x0;
    steps = [];
    normGrad = [];
    costFnStep = [];
    normGrad(1) =  Inf;
    t = 0.01;
    
    while(norm(g) >= tol & niter <= maxiter)
%         steps = [steps;x];
%         result = compCostFn(Distro, x);
        
        g = gdFunction(Distro, x);
        x = x+t*g;
        niter = niter + 1;     
        
%         costsFnStep(niter) = result(1);
        normGradOld = normGrad;
        normGrad(niter) = norm(g);
        if normGradOld == normGrad(niter)
            disp('No update was made...');
            break;
        end
        if normGrad(niter) > 1000
            disp('Bad starting point or jump...');
            break;
        end
        
    end 
    xopt = x;
    
    Distro.GradErr = pdist2(Distro.q,xopt);
    Distro.xopt = xopt;
    Distro.x0 = x0;
    Distro.niter = niter-1;
    Distro.normGrad = normGrad;
    Distro.costFnStep = costFnStep;
    
    if niter > 0
        Distro.optVal = compCostFn(Distro, xopt);
    else
        Distro.optVal = -Inf;
    end
    
%     - Plot norm of gradient
%     figure;
%     plot(normGrad);
%     figure;
%     plot(costFnStep);
end
function result = compCostFn(Distro, x)
    if strcmp(Distro.type,'rayl')
        if(strcmp(Distro.center, 'mode'))
            par_alpha = pdist2(Distro.Rn, x);
        else %mean
            par_alpha = sqrt(2*pi)*pdist2(Distro.Rn, x);
        end
        logLike = sum(log(raylpdf(Distro.Dn,par_alpha)));
    end
    
    if strcmp(Distro.type,'maxB')
        if(strcmp(Distro.center, 'mode'))
            par_a = pdist2(Distro.Rn, x)/sqrt(2);
        else %mean
            par_a = (1/2)*sqrt(pi/2)*pdist2(Distro.Rn, x);
        end
        
        logLike = sum(log((Distro.Dn.^2*sqrt(2/pi))./(par_a.^3)) ...
            - (Distro.Dn.^2)./(2*par_a.^2));
    end 
    
    if strcmp(Distro.type,'expo')
        % Only mean
        par_lambda = pdist2(Distro.Rn, x).^(-1);
        
        logLike = sum(log(exppdf(Distro.Dn,par_lambda)));
    end 
    
    if strcmp(Distro.type,'gamm')
        if(strcmp(Distro.center, 'mode'))
            par_alpha = (pdist2(Distro.Rn, x).^2)+1;
            par_beta = pdist2(Distro.Rn, x).^-1;
        else %mean
            par_alpha = pdist2(Distro.Rn, x).^2;
            par_beta = pdist2(Distro.Rn, x).^-1;
        end
        
        logLike = sum(log(gampdf(Distro.Dn,par_alpha,par_beta)));
    end
    
    if strcmp(Distro.type,'igam')
        if(strcmp(Distro.center, 'mode'))            
            par_alpha = pdist2(Distro.Rn, x)-1;
            par_beta = pdist2(Distro.Rn, x).^2;
        else %mean
            par_alpha = pdist2(Distro.Rn, x)+1;
            par_beta = pdist2(Distro.Rn, x).^2;
        end
        
        distroValues = zeros(size(Distro.Dn));
        for i=1:size(Distro.Dn, 1)
            distroValues(i) = gampdf(1./Distro.Dn(i),par_alpha(i),1/par_beta(i));
        end
        logLike = sum(log(distroValues./(Distro.Dn.^2)));
    end   

    if strcmp(Distro.type,'unif')
        %Only mean
        par_a = pdist2(Distro.Rn, x)./2;
        par_b = (3.*pdist2(Distro.Rn, x))/2;
        
        logLike = sum(log(unifpdf(Distro.Dn,par_a,par_b)));
    end
    
    logPrior = log(mvnpdf((x-Distro.r_mean),Distro.r_mean,Distro.Sigma));
    logPost = logPrior + logLike;

    result(1) = logPost;
    result(2) = logPrior;
    result(3) = logLike;
end
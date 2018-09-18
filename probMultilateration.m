function FinalRes = probMultilateration(dataset, refPoints, target, prior)
    Distro.Rn = refPoints;
    Distro.q = target;
    
    if(isempty(prior))
        Distro.r_mean = mean(refPoints);
        Distro.prior = Distro.r_mean;
    else
        Distro.r_mean = prior;
        Distro.prior = prior;      
    end
    Distro.Sigma = cov(refPoints);
    Distro.Dn = dataset;      
    Distro.d = size(Distro.Rn,2);
    Distro.k = size(Distro.Dn,1);
    
    
    center = ['mean';'mode'];
    
    %types that contain both mean and mode should come first
    type = ['rayl'; 'maxB'; 'gamm'; 'igam'; 'expo'; 'unif'];
    
    %Number of distributions that have both mean and mode
    numOfBoth = 4;

    Result = [];

    for i=1:size(center,1)
        Distro.center = center(i,:);
        for j=1:size(type,1)
            Distro.type = type(j,:);
            if i*j <= size(center,1)*numOfBoth
                currMax = -Inf;
                for k=1:5
                    TempDistro = GradAscFSZ(Distro);
                    if (TempDistro.optVal(1) > currMax && TempDistro.optVal(1) < Inf)
                        currMax = TempDistro.optVal(1);
                        TempResult = TempDistro;
                    end
                end
                Result = [Result;TempResult];
            end
        end
    end
    
    FinalRes = modelSelection(Result, 1/size(Result, 1));
end
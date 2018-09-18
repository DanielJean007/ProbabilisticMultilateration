function Distro = CompMean(Distro, nSamples)
    numerator = 0;
    denominator = 0;
    
    Distro.meanSample = mvnrnd(Distro.r_mean, Distro.Sigma, nSamples);
    
    Distro.h_qs = mvnpdf(Distro.meanSample, Distro.r_mean, Distro.Sigma);
    
    for i=1:nSamples
        result = compCostFn(Distro, Distro.meanSample(i,:));
        g_qs(i) = vpa(exp(result(1))); %The unnormalized posterior;
        
        numerator = numerator + ((Distro.meanSample(i,:) * g_qs(i))/Distro.h_qs(i));
        denominator = denominator + g_qs(i)/Distro.h_qs(i);
    end
    
    Distro.g_qs = g_qs;
    Distro.distroMean = numerator/denominator;
    
    Distro.meanErr = pdist2(Distro.q, Distro.distroMean);
    
end
function Distro = CompEvidence(Distro, nSamples, plotIt)
%     nSample = Number of points to generate form Gaussian Distro
%     GSample = Sample drawn from the Gaussian
    
    Distro.GSample = mvnrnd(Distro.r_mean, Distro.Sigma, nSamples);
    
    sumParts = 0;
    
    parfor i = 1:size(Distro.GSample, 1)
        likelihood = compCostFn(Distro, Distro.GSample(i,:));
        sumParts = sumParts + vpa(exp(likelihood(3)));
    end
        
    Distro.EvidenceAppx = sumParts/nSamples;
    
    if plotIt == 1
        digits(100);
        Distro.surfaceNorm = double(vpa(exp(Distro.posteriorSurface-log(Distro.EvidenceAppx))));
    
        Distro.surfaceAppxDistro = plotInfoOnFig(Distro, Distro.surfaceNorm);
    end
end
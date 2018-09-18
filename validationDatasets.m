function distSummary = validationDatasets(parameters)
    clc;
    runs = 10;
    totalCont = size(parameters, 1);

    distSummary = zeros(totalCont,6);
    disp('Process has started...');
        
    parfor i = 1:totalCont
%     for i = 1:totalCont
        dataset = parameters(i).Dn;
        refPoints = parameters(i).Rn;
        target = parameters(i).q;
        prior = [];

        q_MAP = zeros(runs,1);
        q_IS = zeros(runs,1);
        q_MH = zeros(runs,1);
        
        for j = 1:runs    
            result = probMultilateration(dataset, refPoints, target, prior);
            
            Mean = CompMean(result, 5*result.k);
%             Mean = CompMean(result, result.k);
            TempResult = Mean;

            Metro_Hast = CompMetro_Hastings(TempResult, 5*TempResult.k);
%             Metro_Hast = CompMetro_Hastings(TempResult, TempResult.k);
            result = Metro_Hast;

            q_MAP(j) = result.GradErr;
            q_IS(j) = result.meanErr;
            q_MH(j) = result.meanMHErr;            
        end
        
        distSummary(i,:) = [mean(q_MAP),std(q_MAP),mean(q_IS),std(q_IS),mean(q_MH),std(q_MH)];   
        
        disp([num2str((i/totalCont)*100), '% done.']);
    end
end
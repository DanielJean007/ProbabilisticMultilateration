function results = validaDistros(parameters)
    clc;
    runs = 10;
    totalCont = size(parameters, 1);

    results = zeros(totalCont,6);
    disp('Process has started...');
    parfor i = 1:totalCont
        q_MAP = zeros(runs,1);
        q_IS = zeros(runs,1);
        q_MH = zeros(runs,1);
        
        for j = 1:runs 
            currMax = -Inf;
            for k=1:5
                TempDistro = GradAscFSZ(parameters(i));
                if (TempDistro.optVal(1) > currMax && TempDistro.optVal(1) < Inf)
                    currMax = TempDistro.optVal(1);
                    TempResult = TempDistro;
                end
            end
            result = TempResult;
            Mean = CompMean(result, 5*result.k);
            TempResult = Mean;

            Metro_Hast = CompMetro_Hastings(TempResult, 5*TempResult.k);
            result = Metro_Hast;

            q_MAP(j) = result.GradErr;
            q_IS(j) = result.meanErr;
            q_MH(j) = result.meanMHErr;            
        end
        
        results(i,:) = [mean(q_MAP),std(q_MAP),mean(q_IS),std(q_IS),mean(q_MH),std(q_MH)] 
        
        disp([num2str((i/totalCont)*100), '% done.']);
    end
end
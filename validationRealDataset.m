function errSummary = validationRealDataset()
    data = load('../Results/realDataset.mat');
    
%% Average method for handling the dataset
    Dist = [mean(data.D1); mean(data.D2); mean(data.D3); mean(data.D4); mean(data.D5)];
    for i=1:5
        parameter(i).Rn = data.Rn;
        parameter(i).q = data.positions(i,:);
        parameter(i).Dn = Dist(i,:)';        
    end
    errSummary.average = validationDatasets(parameter');
%     
% %%  Incremental method for handling the dataset   
%     runs = 10;
%     for k=1:5
%         switch k
%             case 1
%                 actualDn = data.D1;
%             case 2
%                 actualDn = data.D2;
%             case 3
%                 actualDn = data.D3;
%             case 4
%                 actualDn = data.D4;
%             case 5
%                 actualDn = data.D5;
%         end
%         
%         parfor j=1:runs
%             prior = [];
%             for i=1:size(actualDn,1)
%                 PartialRes = probMultilateration(actualDn(i,:)', data.Rn, data.positions(1,:), prior);
%                 prior = PartialRes.xopt;
%             end
%             
%           Mean = CompMean(PartialRes, 10*PartialRes.k);
% %             Mean = CompMean(PartialRes, PartialRes.k);
%             TempResult = Mean;
% 
%         	Metro_Hast = CompMetro_Hastings(TempResult, 40*TempResult.k);
% %             Metro_Hast = CompMetro_Hastings(TempResult, TempResult.k);
%             PartialRes = Metro_Hast;
% 
%             q_MAP(j) = PartialRes.GradErr;
%             q_IS(j) = PartialRes.meanErr;
%             q_MH(j) = PartialRes.meanMHErr;
%         end
%         errSummary.incremental(k,:) = [mean(q_MAP),std(q_MAP),mean(q_IS),std(q_IS),mean(q_MH),std(q_MH)];     
%     end
% 
% %%  Selection method for handling the dataset   
%     sizeSample = round(0.25*size(data.D1,1));
%     datasample(data.D1,sizeSample);    
% 
%     runs = 10;
%     for k=1:5
%         switch k
%             case 1
%                 actualDn = data.D1;
%             case 2
%                 actualDn = data.D2;
%             case 3
%                 actualDn = data.D3;
%             case 4
%                 actualDn = data.D4;
%             case 5
%                 actualDn = data.D5;
%         end
%         
%         for j=1:runs           
%             for i=1:sizeSample
%                 PartialRes = probMultilateration(actualDn(i,:)', data.Rn, data.positions(1,:), []);            
%             
%                 Mean = CompMean(PartialRes, 10*PartialRes.k);
% %                 Mean = CompMean(PartialRes, PartialRes.k);
%                 TempResult = Mean;
% 
%             	Metro_Hast = CompMetro_Hastings(TempResult, 40*TempResult.k);
% %                 Metro_Hast = CompMetro_Hastings(TempResult, TempResult.k);
%                 PartialRes = Metro_Hast;
%                 
%                 partial_q_MAP(i) = PartialRes.GradErr;
%                 partial_q_IS(i) = PartialRes.meanErr;
%                 partial_q_MH(i) = PartialRes.meanMHErr;
%                 
%                 acutal_q_MAP = mean(partial_q_MAP);
%                 acutal_q_IS = mean(partial_q_IS);
%                 acutal_q_MH = mean(partial_q_MH);
%             end
% 
%             q_MAP(j) = acutal_q_MAP;
%             q_IS(j) = acutal_q_IS;
%             q_MH(j) = acutal_q_MH;
%         end
%         errSummary.selection(k,:) = [mean(q_MAP),std(q_MAP),mean(q_IS),std(q_IS),mean(q_MH),std(q_MH)];    
%     end
    
%%  Combination method for handling the dataset   
    D1 = data.D1';
    D2 = data.D2';
    D3 = data.D3';
    D4 = data.D4';
    D5 = data.D5';
    
    D1 = D1(:);
    D2 = D2(:);
    D3 = D3(:);
    D4 = D4(:);
    D5 = D5(:);
   
    for k=1:5
        switch k
            case 1
                actualDn = D1;
                actualRn = repmat(data.Rn, [size(data.D1,1),1]);
            case 2
                actualDn = D2;
                actualRn = repmat(data.Rn, [size(data.D2,1),1]);
            case 3
                actualDn = D3;
                actualRn = repmat(data.Rn, [size(data.D3,1),1]);
            case 4
                actualDn = D4;
                actualRn = repmat(data.Rn, [size(data.D4,1),1]);
            case 5
                actualDn = D5;
                actualRn = repmat(data.Rn, [size(data.D5,1),1]);
        end

        parameter(k).Rn = actualRn;
        parameter(k).q = data.positions(k,:);
        parameter(k).Dn = actualDn;
    end
    
        errSummary.combination = validationDatasets(parameter');
end
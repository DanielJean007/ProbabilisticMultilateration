function bestModel = modelSelection(Distro, p_model)
%% - This routine implements p(M|D, R) ~ p(D|M,R)*p(M)
% This is the probability of the model given the distances and reference
% points is proportional to the probaility of the data given the models and
% reference points times the probability of each model.
% For startes, we will simply assume p(M) to be uniformly distributed, as a
% result p(M|D,R) is just the greatest value amongst all models.
% The output 'bestModel' is the Distro(i) that represents the best model.
% The input 'Distro' is a struct of all models used. For intance, Distro
% might contain results of Rayleigh, Maxwell, Exponential, and so on,
% distributed distances.

% Ideally, this function should be used with the output of the validation.m
% routine.
%%

%%

    ModelsEvidence = [];
    valEvidence = [];
    parfor i=1:size(Distro,1)
        evidence = CompEvidence(Distro(i), 10*Distro(i).k, 0);
        
        ModelsEvidence = [ModelsEvidence;evidence];
        valEvidence = [valEvidence; evidence.EvidenceAppx];
    end
    
    ModelSelPost = [];
    parfor i=1:size(valEvidence,1)
        if valEvidence(i) <= 1
            ModelSelPost = [ModelSelPost; valEvidence(i)*p_model];
        end
    end
    
    [v, i] = max(ModelSelPost);
    
    ModelsEvidence(i).ValueModelSelected = v;
    
    bestModel = ModelsEvidence(i);
end
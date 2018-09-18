function PartialRes = incrementalMultilateration(dataset, posBeacon, target, prior)
%%  - This routine receives the full dataset (for one location of q) 
% and outputs the best solution in an incremental way.
    
    for i=1:size(dataset,1)
        PartialRes = validation(dataset(i,:)', posBeacon, target, prior);
        
        prior = PartialRes.xopt;
    end
end
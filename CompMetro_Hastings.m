function Distro = CompMetro_Hastings(Distro, nSamples)
    %Number of samples that will be discarded before we actually use any
    %sample. We expect to reach the stationary distribution after 200
    %draws.
    burnIn = 500;

    %Addicionar intervalo do subsampling.
    digits(100);
    
    %Just for good practice
    chain = zeros(nSamples,Distro.d);
    wholeChain = zeros(nSamples+burnIn,Distro.d);
    
    %Sigma = Distro.Sigma;
    Sigma = (eye(2,2)+1)*.5;
    %Sigma = eye(2,2);

    %Picking the first state from the proposal distro.
    wholeChain(1,:) = mvnrnd(Distro.r_mean, Sigma, 1);
    
    i=1;
    jump=0;
    countUp = 1;
    while i <= burnIn+nSamples-1
        %Draw from proposal state given last state in the chain
        propState = mvnrnd(wholeChain(i,:), Sigma, 1);
        
        propStateResult = compCostFn(Distro, propState);
        currStateResult = compCostFn(Distro, wholeChain(i,:));
        
        %Values of the unnormalized g(q(.)) for the proposed and current
        %state
        
        probPropState = propStateResult(1);
        probCurrState = currStateResult(1);
        
%         if probCurrState == 0
%             ratio = 1;
%         else
            ratio = vpa(exp(probPropState-probCurrState));
%         end
        
        if rand < min(1,ratio)
            wholeChain(i+1,:) = propState;
        else
            wholeChain(i+1,:) = wholeChain(i,:);
        end
        
        if i > burnIn
            if jump == 0
                countUp = 1;
                jump = round(50+(100)*rand);
                
                if rand < min(1,ratio)
                    chain((i-burnIn),:) = propState;
                    wholeChain(i+1,:) = propState;
                else
                    chain((i-burnIn),:) = wholeChain(i,:);
                    wholeChain(i+1,:) = wholeChain(i,:);
                end
                
            else
                jump = jump - 1;
                countUp = 0;
            end
        end
        
        if countUp == 1
            i = i+1;
        end
    end
    
    Distro.chain = chain;
    Distro.meanMH = sum(chain)/nSamples;
    Distro.meanMHErr = pdist2(Distro.q, Distro.meanMH);
    
end
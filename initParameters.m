function Distro = initParameters(type, center, d, k, q, Rn)
    if isempty(Rn)
        Rn = -40+(80)*rand(k, d);
    end
    if isempty(q)
        q = -40+(80)*rand(1, d);
    end
    Sigma = cov(Rn);
    r_mean = mean(Rn);
    
        if strcmp(type,'rayl')
            if strcmp(center,'mode')
                Dn = random('rayl', pdist2(Rn, q));
            else %mean
                Dn = random('rayl', sqrt(2*pi).*pdist2(Rn, q));
            end
        end
        
        if strcmp(type,'maxB')
            Dn = zeros(k,1);
            for i=1:k 
                if strcmp(center,'mode')
                    Dn(i) = randraw('maxwell', pdist2(Rn(i,:), q)/sqrt(2), 1);
                else %mean
                    Dn(i) = randraw('maxwell', (1/2)*sqrt(pi/2)*pdist2(Rn(i,:), q), 1);
                end
            end
        end
        
        if strcmp(type,'expo') % only mean
            if ~strcmp(center,'mean')
                disp('Only mean is implemented for Exponential');
                return;
            else
                Dn = random('exponential', (pdist2(Rn, q)).^(-1));
            end
        end

        if strcmp(type,'gamm')            
            if strcmp(center,'mode')
                alpha = (pdist2(Rn, q).^2)+1;
                beta = pdist2(Rn, q).^-1;
                
                Dn = random('gamma', alpha, beta);
            else %mean
                alpha = pdist2(Rn, q).^2;
                beta = pdist2(Rn, q).^-1;
                
                Dn = random('gamma', alpha, beta);
            end
            
        end

        if strcmp(type,'igam')
            if strcmp(center,'mode')
                alpha = (pdist2(Rn, q)) - 1;
                beta = pdist2(Rn, q).^2;
                
                tmp = random('gamma', alpha, 1./beta);
                Dn = 1./tmp;
            else %mean
                alpha = (pdist2(Rn, q)) + 1;
                beta = pdist2(Rn, q).^2;
                
                tmp = random('gamma', alpha, 1./beta);
                Dn = 1./tmp;
            end
        end

        if strcmp(type,'unif') % Only mean
            if ~strcmp(center,'mean')
                disp('Only mean is implemented for Uniform');
                return;
            else
                Dn = random('uniform', pdist2(Rn, q)./2, 1.5*pdist2(Rn, q));
            end
        end

        if Dn == 0
            return;
        end
        
        Distro.Rn = Rn;
        Distro.q = q;
        Distro.Sigma = Sigma;
        Distro.r_mean = r_mean;
        Distro.Dn = Dn;
        Distro.d = d;
        Distro.k = k;
        Distro.type = type;
        Distro.center = center;
end
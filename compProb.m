function probability = compProb(Distro, x, evidence)
    probs = compCostFn(Distro, x);
    probability = exp(probs(1))/evidence;
end

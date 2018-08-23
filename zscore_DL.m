function [x, mu, sigma] = zscore_DL(x)
    mu=mean(x);	
    sigma=max(std(x),eps);
	x=bsxfun(@minus,x,mu);
	x=bsxfun(@rdivide,x,sigma);
end

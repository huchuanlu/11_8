function template = calculateGuassianTemplate(windowSize,sigma)
%%function template = calculateGuassianTemplate(windowSize,sigma)
%%calculate a 2D guassian template 
%%
%%Dong Wang, IIAU LAB, DUT, China
%%Version 0.1 2010-09-05

template = zeros(size(windowSize));
mu = [(windowSize(1)+1)/2.0 (windowSize(2)+1)/2.0];
for xx = 1:windowSize(1)
    for yy = 1:windowSize(2)
        template(xx,yy) = exp(-(xx-mu(1))^2/(2*sigma(1)^2)-(yy-mu(2))^2/(2*sigma(2)^2));
    end
end
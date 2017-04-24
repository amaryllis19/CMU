plot(data,class./N,'o',data,yfit./N,'.','Linewidth',2);
B = glmfit(data,[class ones(size(class,1),1)],'binomial','link','probit');
yfit = glmval(B,data,'probit','size',ones(size(class,1),1));
plot(data,class./N,'o',data,yfit./N,'.','Linewidth',2);
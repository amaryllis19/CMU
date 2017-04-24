function [] = agglomerative_clustering(k)

tic
powerload = prem;

Dist = zeros(size(powerload,1),size(powerload,1));
for i = 1:size(powerload,1)
    Dist(:,i) = sqrt(sum(((powerload - repmat(powerload(i,:),size(powerload,1),1)).^2),2));
end

Dist_aux = Dist;
Dist_aux(Dist_aux==0) = Inf;

Ind = size(Dist_aux,1)+1;
cluster_nu = [1:size(powerload,1)]';
c_nu = cluster_nu;
final_clusters = [];
cluster_th = [];
minD = 0;

for i=1:size(Dist_aux,1)
    
    [minD,indexD] = min(Dist_aux(:));
    [m,n] = ind2sub(size(Dist_aux),indexD);
    
    Dist_aux(:,min(m,n)) = min(Dist_aux(:,m),Dist_aux(:,n));
    Dist_aux(min(m,n),:) = min(Dist_aux(m,:),Dist_aux(n,:));
    
    Dist_aux(:,max(m,n)) = Inf;
    Dist_aux(max(m,n),:) = Inf;
    Dist_aux(min(m,n),min(m,n)) = Inf;
    c_nu(c_nu(:)==max(m,n)) = min(m,n);
    cluster_nu = [cluster_nu c_nu]; 
    cluster_th = [cluster_th;m n minD];
    
end



toc

end
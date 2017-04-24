%function [] = agglomerative_clustering(prem,k)

tic
%pret(1,:)=[];
%powerload = [tran pret];
powerload = [abs(tran(:,1)) sign(tran(:,1)).*tran(:,2)];
%no. of observed clusters
%k = 15;

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

cluster_th(end,:)=[];
[H,T]=dendrogram(cluster_th);
%gscatter(abs(tran(:,1)),sign(tran(:,1)).*tran(:,2),T);

threshold=0.075*max(cluster_th(:,3));
%threshold2=0.015*max(cluster_th(:,3));

[m,n] = find(cluster_th(:,3)>=threshold);
cluster_index = cluster_nu(:,min(m));

Xtran = powerload;
%Xtran = [abs(tran(:,1)) sign(tran(:,1)).*tran(:,2)]

clustercountz = length(unique(cluster_index));
%clustercountz = 13;
figure;
xlabel('Active Power(P)');
ylabel('Reactive Power(Q)');
hold on;
colors = lines;
j = 0;
for i = unique(cluster_index)' 
    j = j + 1;
    pind = find(cluster_index==i);
    tran(pind,4) = j;
    Xtran(pind,3)= j;
    scatter(Xtran(pind,1), Xtran(pind,2), 'CData', colors(j,:));
end


% threshold for 14 clusters
% threshold=0.1*max(cluster_th(:,3))
centers = [];
k=0;
for i = 1:clustercountz
    [m,n]=find(tran(:,4)==i);
    if(size(m)==1)
        continue;
    end
    k = k+1;
    centers(k,1) = mean(Xtran(m,1));
    centers(k,2) = mean(Xtran(m,2));
end

scatter(centers(:,1), centers(:,2), '+');

% %Again compute a distance matrix of the points having centers in the
% %specific region
% X = find(centers(:,1) < 150);
% Y = find(centers(:,2) < 50);
% Z = find(centers(:,2) > -50);
% 
% Q = intersect(Y,Z);
% P = intersect(X,Q);
% 
% 
% %%
% [m,n] = find(tran(:,4)==P);
% newdata = Xtran(m,1:2);
% tran(m,4)=0;
% Xtran(m,3)=0;
% 
% Dist1 = zeros(size(newdata,1),size(newdata,1));
% for i = 1:size(newdata,1)
%     Dist1(:,i) = sqrt(sum(((newdata - repmat(newdata(i,:),size(newdata,1),1)).^2),2));
% end
% 
% Dist_aux1 = Dist1;
% Dist_aux1(Dist_aux1==0) = Inf;
% 
% Ind1 = size(Dist_aux1,1)+1;
% cluster_nu1 = [1:size(newdata,1)]';
% c_nu1 = cluster_nu1;
% final_clusters1 = [];
% cluster_th1 = [];
% minD1 = 0;
% 
% for i=1:size(Dist_aux1,1)
%     
%     [minD1,indexD1] = min(Dist_aux1(:));
%     [m1,n1] = ind2sub(size(Dist_aux1),indexD1);
%     
%     Dist_aux1(:,min(m1,n1)) = min(Dist_aux1(:,m1),Dist_aux1(:,n1));
%     Dist_aux1(min(m1,n1),:) = min(Dist_aux1(m1,:),Dist_aux1(n1,:));
%     
%     Dist_aux1(:,max(m1,n1)) = Inf;
%     Dist_aux1(max(m1,n1),:) = Inf;
%     Dist_aux1(min(m1,n1),min(m1,n1)) = Inf;
%     c_nu1(c_nu1(:)==max(m1,n1)) = min(m1,n1);
%     cluster_nu1 = [cluster_nu1 c_nu1]; 
%     cluster_th1 = [cluster_th1;m1 n1 minD1];
%     
% end
% 
% cluster_th1(end,:)=[];
% [H1,T1]=dendrogram(cluster_th1);
% %gscatter(abs(tran(:,1)),sign(tran(:,1)).*tran(:,2),T);
% 
% threshold1=0.536*max(cluster_th1(:,3));
% %threshold2=0.015*max(cluster_th(:,3));
% 
% [m1,n1] = find(cluster_th1(:,3)>=threshold1);
% cluster_index1 = cluster_nu1(:,min(m1));
% 
% %Xtran = newdata;
% %Xtran = [abs(tran(:,1)) sign(tran(:,1)).*tran(:,2)]
% 
% clustercountz1 = length(unique(cluster_index1));
% %clustercountz = 13;
% h = j;
% for i = unique(cluster_index1)' 
%     j = j + 1;
%     pind = find(cluster_index1==i);
%     tran(pind,4) = j;
%     Xtran(pind,3)= j;
%     %scatter(Xtran(pind,1), Xtran(pind,2), 'CData', colors(j,:));
% end
% 
% % threshold for 14 clusters
% % threshold=0.1*max(cluster_th(:,3))
% 
% for i = h:h+clustercountz1
%     [m1,n1]=find(tran(:,4)==i);
%     if(size(m1)==1)
%         continue;
%     end
%     k = k+1;
%     centers(k,1) = mean(Xtran(m1,1));
%     centers(k,2) = mean(Xtran(m1,2));
% end
% 
% figure;
% hold on;
% colors = lines;
% nu_cluster = clustercountz+clustercountz1;
% for i=1:nu_cluster
%     [m2,n2]=find(tran(:,4)==i);
%     scatter(Xtran(m2,1), Xtran(m2,2), 'CData', colors(i,:));
% end
% 
% 
% scatter(centers(:,1), centers(:,2), '+');
% 
hold off;
% 
% %%
% % cluster(cluster_th,'maxclust',17);
% % dendrogram(cluster_th);
% %     threshold = cluster_th(Ind-k,3);
% %         %find clustered genes when k=5 or ?
% %         c_unq = unique(cluster_nu(:,Ind-k));
% %         yu = find(repmat(cluster_nu(:,Ind-k),1,size(c_unq,1))==repmat(c_unq',size(cluster_nu,1),1));
% %         [p,q] = ind2sub(size(Dist_aux),yu);
% %         Q = [p,q];
% % 
% %         q_unq = unique(q);
% 
toc
% 
%end
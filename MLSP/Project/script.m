threshold1=0.075*max(cluster_th1(:,3));
%threshold2=0.015*max(cluster_th(:,3));

[m1,n1] = find(cluster_th1(:,3)>=threshold1);
cluster_index1 = cluster_nu1(:,min(m1));

%Xtran = newdata;
%Xtran = [abs(tran(:,1)) sign(tran(:,1)).*tran(:,2)]

clustercountz1 = length(unique(cluster_index1));
%clustercountz = 13;
for i = unique(cluster_index1)' 
    j = j + 1;
    pind = find(cluster_index1==i);
    %tran1(pind,4) = j;
    Xtran(pind,3)= j;
    scatter(Xtran(pind,1), Xtran(pind,2), 'CData', colors(j,:));
end

% threshold for 14 clusters
% threshold=0.1*max(cluster_th(:,3))

for i = 1:clustercountz1
    [m1,n1]=find(tran1(:,4)==i);
    if(size(m1)==1)
        continue;
    end
    j = j+1;
    centers(j,1) = mean(Xtran1(m1,1));
    centers(j,2) = mean(Xtran1(m1,2));
end

scatter(centers(:,1), centers(:,2), '+');

hold off;
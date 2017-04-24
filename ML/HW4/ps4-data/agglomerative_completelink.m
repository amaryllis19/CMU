% Agglomerative Clustering for the small dataset%
clear all
clc

yeast1 = importdata('yeast1.txt');
yeast1_data = yeast1.data;
yeast1_textdata = yeast1.textdata;
yeast2 = importdata('yeast2.txt');
yeast2_data = yeast2.data;
yeast2_textdata = yeast2.textdata;

Dist = zeros(size(yeast1_data,1),size(yeast1_data,1));
for i = 1:size(yeast1_data,1)
    Dist(:,i) = sqrt(sum(((yeast1_data - repmat(yeast1_data(i,:),size(yeast1_data,1),1)).^2),2));
end

Dist_aux = Dist;
Dist_aux(Dist_aux==0) = Inf;

Ind = size(Dist_aux,1)+1;
cluster_nu = [1:size(yeast1_data,1)]';
c_nu = cluster_nu;
final_clusters = [];
cluster_th = [];
minD = 0;

for i=1:size(Dist_aux,1)
    Dist_aux(Dist_aux==0) = Inf;
    
    [minD,indexD] = min(Dist_aux(:));
    [m,n] = ind2sub(size(Dist_aux),indexD);
    
    Dist_aux(Dist_aux==Inf) = 0;
    
    Dist_aux(:,min(m,n)) = max(Dist_aux(:,m),Dist_aux(:,n));
    Dist_aux(min(m,n),:) = max(Dist_aux(m,:),Dist_aux(n,:));
    
    Dist_aux(:,max(m,n)) = Inf;
    Dist_aux(max(m,n),:) = Inf;
    Dist_aux(min(m,n),min(m,n)) = Inf;
    c_nu(c_nu(:)==max(m,n)) = min(m,n);
    cluster_nu = [cluster_nu c_nu]; 
    cluster_th = [cluster_th;i m n minD]
    
end

in_node2 = 0;
in_node3 = 0;
fid = fopen('single1_cl.txt', 'w');
    for i=1:size(cluster_th,1)
        for j=1:i-1
            if(~isempty(find(cluster_th(j,2:3)==cluster_th(i,2))))
                r_ind2 = j;
                in_node2 = 1;
            end
            if(~isempty(find(cluster_th(j,2:3)==cluster_th(i,3))))
                r_ind3 = j;
                in_node3 = 1;
            end
        end

        if((in_node2&&in_node3)==0)
           s2 = yeast1_textdata{cluster_th(i,2),1};
           s1 = yeast1_textdata{cluster_th(i,3),1};
        elseif((~in_node2&&in_node3)==1)
            s2 = yeast1_textdata{cluster_th(i,2),1};
            s1 = num2str(r_ind3);
        elseif((in_node2&&~in_node3)==1)
            s2 = num2str(r_ind2);
            s1 = yeast1_textdata{cluster_th(i,3),1};
        elseif((in_node2&&in_node3)==1)
            s2 = num2str(r_ind2);
            s1 = num2str(r_ind3);
        end

        d = cluster_th(i,4);
        
        if(d==Inf)
            continue;
        end
        
        %write text data to file           
        fprintf(fid, '%s\t%s\t%f\n', s1,s2,d);
        s1 = [];
        s2 = [];
        in_node2 = 0;
        in_node3 = 0;
    end
        
    
    fclose(fid);




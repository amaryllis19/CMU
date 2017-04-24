% Agglomerative Clustering for big dataset%

function [file] = agglomerative_clustering_completelink(filename,k)
    yeast2 = importdata('yeast2.txt');
    yeast2_data = yeast2.data;
    yeast2_textdata = yeast2.textdata;

    Dist = zeros(size(yeast2_data,1),size(yeast2_data,1));
    for i = 1:size(yeast2_data,1)
    %     B = repmat(yeast1_data(i,:),size(yeast1_data,1),1)
    %     A = yeast1_data - B
    %     Dist(:,i) = sqrt(sum((A.^2),2))
        Dist(:,i) = sqrt(sum(((yeast2_data - repmat(yeast2_data(i,:),size(yeast2_data,1),1)).^2),2))
    end

    Dist_aux = Dist;
    Dist_aux(Dist_aux==0) = Inf;

    Ind = size(Dist_aux,1)+1;
    cluster_nu = [1:size(yeast2_data,1)]';
    c_nu = cluster_nu;
    final_clusters = [];
    cluster_th = [];
    minD = 0;

    for i=1:size(Dist_aux,1)
    
        Dist_aux(Dist_aux==0) = Inf;

        [minD,indexD] = min(Dist_aux(:));
        [m,n] = ind2sub(size(Dist_aux),indexD);

        Dist_aux(Dist_aux==Inf) = 0;

        %keyboard
        Dist_aux(:,min(m,n)) = max(Dist_aux(:,m),Dist_aux(:,n));
        Dist_aux(min(m,n),:) = max(Dist_aux(m,:),Dist_aux(n,:));
        %keyboard
        Dist_aux(:,max(m,n)) = Inf;
        Dist_aux(max(m,n),:) = Inf;
        Dist_aux(min(m,n),min(m,n)) = Inf;
        c_nu(c_nu(:)==max(m,n)) = min(m,n);
        cluster_nu = [cluster_nu c_nu]; 
        cluster_th = [cluster_th;i m n minD];

        %keyboard
    end

    threshold = cluster_th(Ind-k,4);
        %find clustered genes when k=5 or ?
        c_unq = unique(cluster_nu(:,Ind-k));
        yu = find(repmat(cluster_nu(:,Ind-k),1,size(c_unq,1))==repmat(c_unq',size(cluster_nu,1),1));
        [p,q] = ind2sub(size(Dist_aux),yu);
        Q = [p,q];

        q_unq = unique(q);
        % open the file with write permission
        fid = fopen(filename, 'w');
        %f_cluster = struct([]);
        for i=q_unq'
            f_cluster = Q(Q(:,2)==i,1)
            %write text data to file
            for j=f_cluster'
                %keyboard
                s1 = yeast2_textdata{j,1};
                s2 = yeast2_textdata{j,2};
                fprintf(fid, '%s\t%s\n', s1,s2);
                s1 = [];
                s2 = [];
            end
            fprintf(fid,'\n');
            %keyboard

        end
        fclose(fid);
        
        file = filename;
end


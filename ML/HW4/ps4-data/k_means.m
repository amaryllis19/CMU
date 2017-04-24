%k-means clustering
function [file] = k_means(filename,k)

%extract data
 yeast1 = importdata('yeast1.txt');
 yeast1_data = yeast1.data;
 yeast1_textdata = yeast1.textdata;
 
 D1 = min(min(yeast1_data));
 D2 = max(max(yeast1_data));
 Dist = zeros(size(yeast1_data,1),size(k_centers,1)); 
   
 m = 1;
 
while(true)
    
    %reinitialize the centers if we find atleast one center without any
    %member data points
   if(m==1)
      k_centers = D1 + (D2-D1)*rand(k,size(yeast1_data,2));
      m = 0;
   end
   
   %calculate euclidean distance between k-centers and the datapoints
   for i = 1:size(k_centers,1)
     Dist(:,i) = sqrt(sum(((yeast1_data - repmat(k_centers(i,:),size(yeast1_data,1),1)).^2),2))
   end

   [C,I] = min(Dist,[],2);
   R = [C I];
   unqI = unique(I);

   %if the number of clusters formed is not equal to the required clusters,
   %reintialize k-random centers
   if(numel(unqI)~=k)
    m = 1;
    continue;
   end
 
   k_centers_j = k_centers;
   
   %extract the datapoints corresponding to a clusters
   for i = unqI'   
    f_cluster = find(R(:,2)==i)
    k_centers(i,:) = mean(yeast1_data(f_cluster',:),1);
   end
 
   %check condition to break out of loop
   if(all(k_centers_j == k_centers,2))
       % open the file with write permission
        fid = fopen(filename, 'w');
        %f_cluster = struct([]);
        for i=unqI'
            f_cl = find(R(:,2)==i)
            %write text data to file
            for j=f_cl'
                %keyboard
                s1 = yeast1_textdata{j,1};
                s2 = yeast1_textdata{j,2};
                fprintf(fid, '%s\t%s\n', s1,s2);
                s1 = [];
                s2 = [];
            end
            fprintf(fid,'\n');
            %keyboard

        end
        fclose(fid);
        file = filename;
      disp('finished');
      break;
   end
      
end
clear all
clc
close all

 season_labels = {'w','sp','su','f'}';
 yesterday_labels = {'dry','rainy'}';
 daybefore_labels = {'dry','rainy'}';
 cloud_labels = {'sunny','cloudy'}';
 umbrella_labels = {'y','n'}';

[season,yesterday,daybefore,cloud,umbrella]=textread('nbayesdata.txt','%s %s %s %s %s','headerlines',1);

for i = 1:size(season,1)

    season_trn = season([1:i-1 1+1:end]);
    season_tst = season(i);
    
    yesterday_trn = yesterday([1:i-1 1+1:end]);
    yesterday_tst = yesterday(i);
    
    daybefore_trn = daybefore([1:i-1 1+1:end]);
    daybefore_tst = daybefore(i);
    
    cloud_trn = cloud([1:i-1 1+1:end]);
    cloud_tst = cloud(i);
    
    umbrella_trn = umbrella([1:i-1 1+1:end]);
    umbrella_tst = umbrella(i);
    
    bool_season = zeros(size(season_trn,1),1);
    bool_yesterday = zeros(size(yesterday_trn,1),1);
    bool_daybefore = zeros(size(daybefore_trn,1),1);
    bool_cloud = zeros(size(cloud_trn,1),1);
    bool_umbrella = zeros(size(umbrella_trn,1),1);

    bool_fseason = [];
    bool_fyest = [];
    bool_fdaybefore = [];
    bool_fcloud = [];
    bool_fumbrella = [];
    
    P_tst_y = 0;
    P_tst_n = 0;

    for i = 1:size(season_labels,1)
        for j = 1:size(season_trn,1)
            if(strcmp(season_labels(i),season_trn(j)))
                bool_season(j) = 1; 
            else
                bool_season(j) = 0;
            end
        end
        bool_fseason = [bool_fseason bool_season];
    end

    for i = 1:size(yesterday_labels,1)
        for j = 1:size(yesterday_trn,1)
            if(strcmp(yesterday_labels(i),yesterday_trn(j)))
                bool_yesterday(j) = 1; 
            else
                bool_yesterday(j) = 0;
            end
        end
        bool_fyest = [bool_fyest bool_yesterday];
    end

    for i = 1:size(daybefore_labels,1)
        for j = 1:size(daybefore_trn,1)
            if(strcmp(daybefore_labels(i),daybefore_trn(j)))
                bool_daybefore(j) = 1; 
            else
                bool_daybefore(j) = 0;
            end
        end
        bool_fdaybefore = [bool_fdaybefore bool_daybefore];
    end

    for i = 1:size(cloud_labels,1)
        for j = 1:size(cloud_trn,1)
            if(strcmp(cloud_labels(i),cloud_trn(j)))
                bool_cloud(j) = 1; 
            else
                bool_cloud(j) = 0;
            end
        end
        bool_fcloud = [bool_fcloud bool_cloud];
    end

    for i = 1:size(umbrella_labels,1)
        for j = 1:size(umbrella_trn,1)
            if(strcmp(umbrella_labels(i),umbrella_trn(j)))
                bool_umbrella(j) = 1; 
            else
                bool_umbrella(j) = 0;
            end
        end
        bool_fumbrella = [bool_fumbrella bool_umbrella];
    end
    
    P_umbrella_y = sum(bool_fumbrella(:,1))/size(umbrella_trn,1)
    P_umbrella_n = sum(bool_fumbrella(:,2))/size(umbrella_trn,1)
        
    P_season_y = zeros(size(season_labels,1),1);
    P_season_n = zeros(size(season_labels,1),1);
    
    P_yesterday_y = zeros(size(yesterday_labels,1),1);
    P_yesterday_n = zeros(size(yesterday_labels,1),1);
    
    P_daybefore_y = zeros(size(daybefore_labels,1),1);
    P_daybefore_n = zeros(size(daybefore_labels,1),1);
    
    P_cloud_y = zeros(size(cloud_labels,1),1);
    P_cloud_n = zeros(size(cloud_labels,1),1);
    
    for i = 1:size(season_labels,1)
        P_season_y(i,1) = sum(bool_fseason(:,i) .* bool_fumbrella(:,1))/sum(bool_fumbrella(:,1));
    end

    for i = 1:size(season_labels,1)
        P_season_n(i,1) = sum(bool_fseason(:,i) .* bool_fumbrella(:,2))/sum(bool_fumbrella(:,2));
    end

    for i = 1:size(yesterday_labels,1)
        P_yesterday_y(i,1) = sum(bool_fyest(:,i) .* bool_fumbrella(:,1))/sum(bool_fumbrella(:,1));
    end

    for i = 1:size(yesterday_labels,1)
        P_yesterday_n(i,1) = sum(bool_fyest(:,i) .* bool_fumbrella(:,2))/sum(bool_fumbrella(:,2));
    end

    for i = 1:size(daybefore_labels,1)
        P_daybefore_y(i,1) = sum(bool_fdaybefore(:,i) .* bool_fumbrella(:,1))/sum(bool_fumbrella(:,1));
    end

    for i = 1:size(daybefore_labels,1)
        P_daybefore_n(i,1) = sum(bool_fdaybefore(:,i) .* bool_fumbrella(:,2))/sum(bool_fumbrella(:,2));
    end

    for i = 1:size(cloud_labels,1)
        P_cloud_y(i,1) = sum(bool_fcloud(:,i) .* bool_fumbrella(:,1))/sum(bool_fumbrella(:,1));
    end

    for i = 1:size(cloud_labels,1)
        P_cloud_n(i,1) = sum(bool_fcloud(:,i) .* bool_fumbrella(:,2))/sum(bool_fumbrella(:,2));
    end
    
    P_season_y 
    P_season_n 
    
    P_yesterday_y
    P_yesterday_n
    
    P_daybefore_y
    P_daybefore_n
    
    P_cloud_y
    P_cloud_n
    
    % apply the bayes classifier on test data 
     I1 = strmatch(season_tst,season_labels)
     P_season_tst_y = P_season_y(I1) 
     P_season_tst_n = P_season_n(I1)
     
     I2 = strmatch(yesterday_tst,yesterday_labels)
     P_yesterday_tst_y = P_yesterday_y(I2) 
     P_yesterday_tst_n = P_yesterday_n(I2) 
     
     I3 = strmatch(daybefore_tst,daybefore_labels)
     P_daybefore_tst_y = P_daybefore_y(I3) 
     P_daybefore_tst_n = P_daybefore_n(I3) 
     
     I4 = strmatch(cloud_tst,cloud_labels)
     P_cloud_tst_y = P_cloud_y(I3) 
     P_cloud_tst_n = P_cloud_n(I3) 
     
     P_tst_y = P_umbrella_y * P_season_tst_y * P_yesterday_tst_y * P_daybefore_tst_y * P_cloud_tst_y
     P_tst_n = P_umbrella_n * P_season_tst_n * P_yesterday_tst_n * P_daybefore_tst_n * P_cloud_tst_n
     
% 
%%%%%%%%%% some problem with this %%%%%%%%%
%          [max index] = max([P_tst_y,P_tst_n])

       if(P_tst_y > P_tst_n)
              result = 'y'
          else
              result = 'n'
      end
            
     file1 = fopen('naivebayesinf.txt','a+');
     fprintf(file1,'%s ',result);
     
     fclose(file1);
end


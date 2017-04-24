clear all
clc
close all

 season_labels = {'w','sp','su','f'}';
 yesterday_labels = {'dry','rainy'}';
 daybefore_labels = {'dry','rainy'}';
 cloud_labels = {'sunny','cloudy'}';
 umbrella_labels = {'y','n'}';

P_season = zeros(size(season_labels,1),1);
P_yesterday = zeros(size(yesterday_labels,1),1);
P_daybefore = zeros(size(daybefore_labels,1),1);
P_cloud = zeros(size(cloud_labels,1),1);
P_umbrella = zeros(size(umbrella_labels,1),1);

[season,yesterday,daybefore,cloud,umbrella]=textread('nbayesdata.txt','%s %s %s %s %s','headerlines',1);

for i = 1:size(yesterday_labels,1)
    I1 = strmatch(yesterday_labels(i),yesterday);
    P_yesterday(i) = size(I1,1)/length(yesterday);
end

for i = 1:size(daybefore_labels,1)
    I1 = strmatch(daybefore_labels(i),daybefore);
    P_daybefore(i) = size(I1,1)/length(daybefore);
end

bool_season = zeros(size(season,1),1);
bool_yesterday = zeros(size(yesterday,1),1);
bool_daybefore = zeros(size(daybefore,1),1);
bool_cloud = zeros(size(cloud,1),1);
bool_umbrella = zeros(size(umbrella,1),1);

bool_fseason = [];
bool_fyest = [];
bool_fdaybefore = [];
bool_fcloud = [];
bool_fumbrella = [];

for i = 1:size(yesterday_labels,1)
    for j = 1:size(yesterday,1)
        if(strcmp(yesterday_labels(i),yesterday(j)))
            bool_yesterday(j) = 1; 
        else
            bool_yesterday(j) = 0;
        end
    end
    bool_fyest = [bool_fyest bool_yesterday];
end

for i = 1:size(daybefore_labels,1)
    for j = 1:size(daybefore,1)
        if(strcmp(daybefore_labels(i),daybefore(j)))
            bool_daybefore(j) = 1; 
        else
            bool_daybefore(j) = 0;
        end
    end
    bool_fdaybefore = [bool_fdaybefore bool_daybefore];
end

for i = 1:size(umbrella_labels,1)
    for j = 1:size(umbrella,1)
        if(strcmp(umbrella_labels(i),umbrella(j)))
            bool_umbrella(j) = 1; 
        else
            bool_umbrella(j) = 0;
        end
    end
    bool_fumbrella = [bool_fumbrella bool_umbrella];
end


for i = 1:size(yesterday_labels,1)
    P_yester_daybefore = sum(bool_fyest(:,i) .* bool_fdaybefore(:,i))/sum(length(bool_fyest))
end

for i = 1:size(daybefore_labels,1)
    P_yest_mult_daybefore = P_yesterday(i) .* P_daybefore(i)
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 for i = 1:size(yesterday_labels,1)
     P_yesterday_y = sum(bool_fyest(:,i) .* bool_fumbrella(:,1))/sum(bool_fumbrella(:,1))
 end
 
 for i = 1:size(yesterday_labels,1)
     P_yesterday_n = sum(bool_fyest(:,i) .* bool_fumbrella(:,2))/sum(bool_fumbrella(:,2))
 end
 
 for i = 1:size(daybefore_labels,1)
     P_daybefore_n = sum(bool_fdaybefore(:,i) .* bool_fumbrella(:,2))/sum(bool_fumbrella(:,2))
 end
 
 for i = 1:size(daybefore_labels,1)
     P_daybefore_y = sum(bool_fdaybefore(:,i) .* bool_fumbrella(:,1))/sum(bool_fumbrella(:,1))
 end
 
 %%%%%%%%%%%%%%%%
 for i = 1:size(yesterday_labels,1)
    P_yester_daybefore_y = sum(bool_fyest(:,i) .* bool_fdaybefore(:,i) .* bool_fumbrella(:,1))/sum(bool_fumbrella(:,1))
    P_yester_daybefore_n = sum(bool_fyest(:,i) .* bool_fdaybefore(:,i) .* bool_fumbrella(:,2))/sum(bool_fumbrella(:,2))
end

for i = 1:size(daybefore_labels,1)
    P_yest_mult_daybefore_y = P_yesterday_y(:,i) .* P_daybefore_y(:,i)
    P_yest_mult_daybefore_n = P_yesterday_n(:,i) .* P_daybefore_n(:,i)
end

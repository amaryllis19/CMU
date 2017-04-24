clear all
clc
close all

 season_labels = {'w','sp','su','f'}';
 yesterday_labels = {'dry','rainy'}';
 daybefore_labels = {'dry','rainy'}';
 cloud_labels = {'sunny','cloudy'}';
 umbrella_labels = {'y','n'}';

[season,yesterday,daybefore,cloud,umbrella]=textread('nbayesdata.txt','%s %s %s %s %s','headerlines',1);

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

for i = 1:size(season_labels,1)
    for j = 1:size(season,1)
        if(strcmp(season_labels(i),season(j)))
            bool_season(j) = 1; 
        else
            bool_season(j) = 0;
        end
    end
    bool_fseason = [bool_fseason bool_season];
end

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

for i = 1:size(cloud_labels,1)
    for j = 1:size(cloud,1)
        if(strcmp(cloud_labels(i),cloud(j)))
            bool_cloud(j) = 1; 
        else
            bool_cloud(j) = 0;
        end
    end
    bool_fcloud = [bool_fcloud bool_cloud];
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

file1 = fopen('naivebayesest.txt','w');

for i = 1:size(season_labels,1)
    P_season_y = sum(bool_fseason(:,i) .* bool_fumbrella(:,1))/sum(bool_fumbrella(:,1));
    fprintf(file1,'season %s %c %0.2f ',season_labels{i},umbrella_labels{1},P_season_y);
end

for i = 1:size(season_labels,1)
    P_season_n = sum(bool_fseason(:,i) .* bool_fumbrella(:,2))/sum(bool_fumbrella(:,2));
    fprintf(file1,'season %s %c %0.2f ',season_labels{i},umbrella_labels{2},P_season_n);
end

for i = 1:size(yesterday_labels,1)
    P_yesterday_y = sum(bool_fyest(:,i) .* bool_fumbrella(:,1))/sum(bool_fumbrella(:,1));
    fprintf(file1,'yesterday %s %c %0.2f ',yesterday_labels{i},umbrella_labels{1},P_yesterday_y);
end

for i = 1:size(yesterday_labels,1)
    P_yesterday_n = sum(bool_fyest(:,i) .* bool_fumbrella(:,2))/sum(bool_fumbrella(:,2));
    fprintf(file1,'yesterday %s %c %0.2f ',yesterday_labels{i},umbrella_labels{2},P_yesterday_n);
end

for i = 1:size(daybefore_labels,1)
    P_daybefore_y = sum(bool_fdaybefore(:,i) .* bool_fumbrella(:,1))/sum(bool_fumbrella(:,1));
    fprintf(file1,'daybefore %s %c %0.2f ',daybefore_labels{i},umbrella_labels{1},P_daybefore_y);
end

for i = 1:size(daybefore_labels,1)
    P_daybefore_n = sum(bool_fdaybefore(:,i) .* bool_fumbrella(:,2))/sum(bool_fumbrella(:,2));
    fprintf(file1,'daybefore %s %c %0.2f ',daybefore_labels{i},umbrella_labels{2},P_daybefore_n);
end

for i = 1:size(cloud_labels,1)
    P_cloud_y = sum(bool_fcloud(:,i) .* bool_fumbrella(:,1))/sum(bool_fumbrella(:,1));
    fprintf(file1,'cloud %s %c %0.2f ',cloud_labels{i},umbrella_labels{1},P_cloud_y);
end

for i = 1:size(cloud_labels,1)
    P_cloud_n = sum(bool_fcloud(:,i) .* bool_fumbrella(:,2))/sum(bool_fumbrella(:,2));
    fprintf(file1,'cloud %s %c %0.2f ',cloud_labels{i},umbrella_labels{2},P_cloud_n);
end

fclose(file1);




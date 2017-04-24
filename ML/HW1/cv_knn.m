clear all; clc; close all;

load('orl_faces.mat');
n_set = 10;
n_class = 40;

cv_s = zeros(n_class,size(Images,2));
trn_s = zeros((size(Images,1)-n_class),size(Images,2));
error = zeros(n_set,1);
cv_class = zeros(n_class,1);
trn_class = zeros(size(Images,1)-n_class,1);
% avg_acc = zeros(10,1);

for i = 1:10

    Images_aux = Images;

    t = i:10:400;
    for j = 1:n_class;
        cv_s(j,:) = Images_aux(t(j),:);
        cv_class(j) = class(t(j),1);
    end

    n=1:400; n(t)=Inf; n=n(n~=Inf);
    
    for m = 1:length(n)
        trn_s(m,:) = Images_aux(n(m),:);
        trn_class(m) = class(n(m));
    end
    %size(trn_s), size(trn_class), size(cv_s)
    for k = 1:10
        cv_c = knn(trn_s,trn_class,cv_s,k);
        % training accuracy
        %cv_trn = knn(trn_s,trn_class,trn_s,k);

        %cv_c, cv_class
        error(k) = error(k)+ sum(cv_c ~= cv_class');
    end
    error
end
% cv_s
% trn_s
acc_k = 400 - error;
avg_acc_k = acc_k/10
[best_k,index_best_k] = max(avg_acc_k)

plot(avg_acc_k);

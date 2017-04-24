% Logistic Regression Regularization %
clear all
clc
close all

load ('communities.mat');

% chose eta = k/t where k = 0.5 and t = j
% chose L = 10
L = [0,1,5,10,25];
n_set = 5;
n_data = 1993;

error_L1 = zeros(n_set,1);
error_L2 = zeros(n_set,1);

% 10-fold cross validation %
for f = 1:10
    Q =(fold==f);
    
    test_data = data(Q,:);
    train_data = data(~Q,:);
    
    test_class = class(Q,:);
    train_class = class(~Q,:);
    
    for i=1:length(L)
        %w = logistic_regression(train_data,train_class,L) %
        [w1,v1] = logistic_regression_L1(train_data,train_class,L(i));
        [w2,v2] = logistic_regression_L2(train_data,train_class,L(i));
        
        new1 = w1' * test_data';
        exp_new1 = exp(v1+new1);
        inv_e1 = exp_new1 ./ (1 + exp_new1);
        prob_y1_L1 = inv_e1;
        
        reg_class1 = prob_y1_L1 > 0.5;
        
        new2 = w2' * test_data';
        exp_new2 = exp(v2+new2);
        inv_e2 = exp_new2 ./ (1 + exp_new2);
        prob_y1_L2 = inv_e2;
        
        reg_class2 = prob_y1_L2 > 0.5;
        
        error_L1(i) = error_L1(i)+sum(reg_class1 ~= test_class');
        error_L2(i) = error_L2(i)+sum(reg_class2 ~= test_class');
        
        sum(abs(w1)<10e-5);
    end
    
end

error_L1
error_L2
    
acc_L_L1 = n_data - error_L1;
acc_L_L2 = n_data - error_L2;
    
avg_L_acc_L1 = acc_L_L1/n_set;
avg_L_acc_L2 = acc_L_L2/n_set;
    
[best_L_L1,index_best_L_L1] = max(avg_L_acc_L1);
[best_L_L2,index_best_L_L2] = max(avg_L_acc_L2);

figure(1);
plot(avg_L_acc_L1);
title('average accuracy for each L with L1 regularization');


figure(2);
plot(avg_L_acc_L2);
title('average accuracy for each L with L2 regularization');

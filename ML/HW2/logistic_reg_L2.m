% Logistic Regression Regularization %
clear all
clc
close all

load ('communities.mat');

% chose eta = k/t where k = 0.5 and t = j
% chose L = 10
K = 0.05;
L = 0;
M = size(attributes,1);
N = size(data,1);

new_data = data'; %M x N
w = ones(M,1);
norm_w = zeros(M,1);
v = 0;

norm_limit = 1;

for q = 1 : 100000
    eta = K/q;
   
    v_prev = v;
    w_prev = w;

    new = w' * new_data;
    inv_e = 1 ./ (1 + exp(v+new));
    Z = class - 1 + inv_e';

    v = v_prev + eta * sum(Z);
    w = w_prev + eta * ((new_data * Z) - (L * w));

    norm_w = w - w_prev;
    norm_v = v - v_prev;

    norm_vector = [norm_v;norm_w];
    norm_limit = norm(norm_vector,2);
        
    if(norm_limit <= 0.001)
        break;
    end
end
%print
v
w
figure(1);
hist(w);
title('No regularization');


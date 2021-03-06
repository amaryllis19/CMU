% AdaBoost Algorithm %
function [Y_f,error] = adaboost_classifier(X,Y) 

N = size(X,1);  % number of data points
F = size(X,2);   % feature space / dimensions
M = 80;         % number of iterations

J_error = zeros(N-1,1);
J = zeros(F,1);
threshold = zeros(F,1);
error = zeros(M,1);
final_f = zeros(M,1);
v = zeros(M,1);
Y_class_f = zeros(N,M);

% Initialize the data weighting coefficients - Wn
W = 1/N * ones(N,1);

% Training M robot agents (i.e. M weak learners)
for m = 1:M
    % fit a classifier to the training data, 
    % one attribute/feature at a time
    for j = 1:F
        X_sort = sort(X(:,j));
        D_stump = (X_sort(1:end-1)+X_sort(2:end))/2;
        
        for k = 1:N-1
            Y_class = (2 * (X(:,j) > D_stump(k))) - 1 ;
            I_class = (Y_class ~= Y);
            J_error(k) = sum(W .* I_class);
        end
        [J(j),index] = min(J_error);
        threshold(j) = D_stump(index);
    end
    [error(m),final_f(m)] = min(J);
    
    % evaluate the quantities
    v(m) = threshold(final_f(m));
    
    Y_classn = (2 * (X(:,final_f(m)) > v(m))) - 1;
    I_classn = (Y_class1 ~= Y);
    
    epsilon = sum(W .* I_class1)/sum(W);
    
    alpha = log10((1-epsilon)/epsilon);
 
    % evaluate data weighting coefficients
    W = W .* exp(alpha .* I_class1);
    
    % calculate the final classifier
    Y_class_f(:,m) = alpha .* Y_class1;
    
    Y_m = sum(Y_class_f,2);

    % final classifier
    Y_f = sign(Y_m);   
end

 
end


    
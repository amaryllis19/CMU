function [w,v] = logistic_regression_L1(data,class,L)
K = .005;
%L = 25;
M = size(data,2);
N = size(data,1);

new_data = data';
w = ones(M,1);
norm_w = zeros(M,1);
v = 0;

num_iter=5000;
for q = 1 : num_iter
    eta = K/q;
   
    v_prev = v;
    w_prev_p = w .* (w>0);
    w_prev_n = w .* (w<=0);
    w_prev = w_prev_p + w_prev_n;

    new = w_prev' * new_data;
    inv_e = 1 ./ (1 + exp(v_prev+new));
    Z = class - 1 + inv_e';

    v = v_prev + eta * sum(Z);
    w_p = w_prev_p + eta * ((new_data * Z) - L);
    w_n = w_prev_n + eta * ((new_data * Z) + L);
    w = w_p + w_n;

    norm_w = w - w_prev;
    norm_v = v - v_prev;

    norm_vector = [norm_v;norm_w];
    norm_limit = norm(norm_vector,2);
 
    if(norm_limit <= 0.001)
        break;
    end
end
v;
w;
norm_limit;
hist(w);

end

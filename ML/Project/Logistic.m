function [output] = Logistic(Input)
    output = 1 ./ (1+exp(-Input));
end
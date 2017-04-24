clear all; clc;
tst = [2 2;3 3;5 5;1 4];
trn = [1 2;5 3;1 1];
trn_class = [4;2;1];
k = 2;
knn(trn,trn_class,tst,k)
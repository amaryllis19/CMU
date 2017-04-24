% Obtaining eigen faces %

function [eig_faces] = compute_eigen_faces(corpus,K)

    X = [];
    
    files = dir(fullfile(corpus,'*.pgm'));
    for i = 1:length(files)
        C = imread([corpus,filesep,files(i).name]);
        D = im2double(C);
        E = histeq(D);
        X = [X E(:)];
    end
    
    MeanX = mean(X,2);
    OnesX = ones(1,size(X,2));
        
    Xcentered = X - MeanX*OnesX;
    [U,S,V] = svds(Xcentered,K);
        
    eig_faces = U';

end
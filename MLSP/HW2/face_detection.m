% face detection %
clear all
clc

% compute eigen faces
corpus = 'C:\Users\amaryllis\Documents\MATLAB\MLSP\HW2\lfw1000';
[eigfaces] = compute_eigen_faces(corpus,10);

% extract the training data - faces
corpus_train_face = 'C:\Users\amaryllis\Documents\MATLAB\MLSP\HW2\BoostingData\train\face';
 %X1 = [];
    
    files1 = dir(fullfile(corpus_train_face,'*.pgm'));
    for i = 1:length(files1)
        C1 = imread([corpus_train_face,filesep,files1(i).name]);
        D1 = imresize(C1, [64 64]);
        E1 = im2double(D1);
        F1 = histeq(E1);
        if(i==1)
            X1 = zeros(length(files1),size(F1,1)*size(F1,2));
        end
        X1(i,1:size(F1,1)*size(F1,2)) = reshape(F1,1,size(F1,1)*size(F1,2));
    end
    
    % compute weights of the images using the 10 eigen faces 
    norm_X1 = repmat(sqrt(sum(power(X1,2),2)),1,size(eigfaces,1));
    W_face_train = (X1 * eigfaces')./norm_X1;
    W_face_error_train = power(sqrt(sum(power((X1 - (X1*eigfaces'*eigfaces)),2),2)),2); % 11th dimension
    W_face_train = [W_face_train W_face_error_train];
    Y1 = ones(size(W_face_train,1),1);
    
    % extract the training data - non faces
corpus_train_nface = 'C:\Users\amaryllis\Documents\MATLAB\MLSP\HW2\BoostingData\train\non-face';
   % X2 = [];
    
    files2 = dir(fullfile(corpus_train_nface,'*.pgm'));
  
    for i = 1:length(files2)
        C2 = imread([corpus_train_nface,filesep,files2(i).name]);
        D2 = imresize(C2, [64 64]);
        E2 = im2double(D2);
        F2 = histeq(E2);
        if(i==1)
            X2 = zeros(length(files2),size(F2,1)*size(F2,2));
        end
        X2(i,1:size(F2,1)*size(F2,2)) = reshape(F2,1,size(F2,1)*size(F2,2));
    end
    
    norm_X2 = repmat(sqrt(sum(power(X2,2),2)),1,size(eigfaces,1));
    W_nface_train = (X2 * eigfaces')./norm_X2;
    W_nface_error_train = power(sqrt(sum(power((X2 - (X2*eigfaces'*eigfaces)),2),2)),2); % 11th dimension
    W_nface_train = [W_nface_train W_nface_error_train];
    
    Y2 = ones(size(W_nface_train,1),1)*(-1);
    
    train_data = [W_face_train;W_nface_train];
    train_class = [Y1;Y2];

    save('train_classifier_data');

    %load('train_classifier_data.mat');
    
    %No. of classifiers%
    T = 100;

    [classifier] = adaboost(train_data,train_class,T);
    
tic

% extract the test data
corpus_test_face = 'C:\Users\amaryllis\Documents\MATLAB\MLSP\HW2\BoostingData\test\face';
    %X1 = [];
    
    files3 = dir(fullfile(corpus_test_face,'*.pgm'));
    for i = 1:length(files3)
        C3 = imread([corpus_test_face,filesep,files3(i).name]);
        D3 = imresize(C3, [64 64]);
        E3 = im2double(D3);
        F3 = histeq(E3);
     if(i==1)
            X3 = zeros(length(files3),size(F3,1)*size(F3,2));
           
            % method to resize the eigen faces for images of different size
            % - not tested!
           % R1 = reshape(eigfaces,64,64);
           % O1 = imresize(RI,[size(F3,1) size(F3,2)]);
           % eigfaces = reshape(O1,1,size(F3,1)*size(F3,2));
     end
        X3(i,1:size(F3,1)*size(F3,2)) = reshape(F3,1,size(F3,1)*size(F3,2));
    end
    
    norm_X3 = repmat(sqrt(sum(power(X3,2),2)),1,size(eigfaces,1));
    W_face_test = (X3 * eigfaces')./norm_X3;
    W_face_error_test = power(sqrt(sum(power((X3 - (X3*eigfaces'*eigfaces)),2),2)),2); % 11th dimension
    W_face_test = [W_face_test W_face_error_test];
    
    Y3 = ones(size(W_face_test,1),1);
 
    time1 = toc

    tic
    
    % extract test images  - non faces
corpus_test_nface = 'C:\Users\amaryllis\Documents\MATLAB\MLSP\HW2\BoostingData\test\non-face';
    %X2 = [];
    
    files4 = dir(fullfile(corpus_test_nface,'*.pgm'));
    for i = 1:length(files4)
        C4 = imread([corpus_test_nface,filesep,files4(i).name]);
        D4 = imresize(C4, [64 64]);
        E4 = im2double(D4);
        F4 = histeq(E4);
        if(i==1)
            X4 = zeros(length(files4),size(F4,1)*size(F4,2));
        end
        X4(i,1:size(F4,1)*size(F4,2)) = reshape(F4,1,size(F4,1)*size(F4,2));
    end

    norm_X4 = repmat(sqrt(sum(power(X4,2),2)),1,size(eigfaces,1));
    W_nface_test = (X4 * eigfaces')./norm_X4;
    W_nface_error_test = power(sqrt(sum(power((X4 - (X4*eigfaces'*eigfaces)),2),2)),2); % 11th dimension
    W_nface_test = [W_nface_test W_nface_error_test];
    
    Y4 = ones(size(W_nface_test,1),1)*(-1);
    
    test_data = [W_face_test;W_nface_test];
    test_class = [Y3;Y4];
    
   save('test_classifier_data');
    time2 = toc
    
%     load('test_classifier_data.mat');
  
    % compute the class labels of test data using the classifiers on each iteration 
    Y_class = ((2*(test_data(:,classifier(:,2)) > repmat(classifier(:,3)',size(test_data,1),1)) - 1) .* (ones(size(test_data,1),1) * (1 - classifier(:,4)'))) + ((2*(test_data(:,classifier(:,2)) < repmat(classifier(:,3)',size(test_data,1),1)) - 1) .* (ones(size(test_data,1),1) * (classifier(:,4)')));
    
    %error of ith weak classifier%
    error = (Y_class ~= repmat(test_class,1,size(Y_class,2)));
    sum_error_face = sum(error(1:size(Y3,1),:),1)/size(Y3,1);
    sum_error_nface = sum(error(size(Y3,1)+1:size(Y4,1),:),1)/size(Y4,1);
    figure(1); plot(sum_error_face,'b'); axis([0,T+1,0,max(sum_error_face)*1.1])
    title('error of ith weak classifier for faces');
   
    xlabel('iterations');
    ylabel('test errors');
    
    figure(2); plot(sum_error_nface,'r'); axis([0,T+1,0,max(sum_error_nface)*1.1])
    title('error of ith weak classifier for non-faces');
    
    xlabel('iterations');
    ylabel('test errors');
    
    %error of strong classifier%
    Y_final = Y_class .* repmat(classifier(:,1)',size(test_data,1),1);
        
    Y_final_sum = [];
    
    % iteratively compute error of i strong classifiers
    for i = 1:T
        Y_sum = sum(Y_final(:,1:i),2);
        Y_final_sum = [Y_final_sum Y_sum];
    end
    Y_final_class = sign(Y_final_sum);
    
    Yf_error = (Y_final_class ~= repmat(test_class,1,size(Y_final_class,2)));
    Yf_sum_error_face = sum(Yf_error(1:size(Y3,1),:),1)/size(Y3,1);
    Yf_sum_error_nface = sum(Yf_error(size(Y3,1)+1:size(Y4,1),:),1)/size(Y4,1);
    figure(3); plot(Yf_sum_error_face,'b'); axis([0,T+1,0,max(Yf_sum_error_face)*1.1])
    title('error of strong classifier for faces');
   
    xlabel('iterations');
    ylabel('test errors');
    
    figure(4); plot(Yf_sum_error_nface,'r'); axis([0,T+1,0,max(Yf_sum_error_nface)*1.1])
   
    title('error of strong classifier for non-faces');
   
    xlabel('iterations');
    ylabel('test errors');
    
% MLSP - Homework 1 - Problem 4
% noise_threshold = a function that finds the average power of each 
% spectral frame in the signal and returns all spectral frames
% that have average power above the threshold

%fft size = 0.06*16000 = 960
%hop size = 0.015*16000 = 240 

function [spectra] = noise_threshold(filename,threshold)

[s_e fs_e] = wavread(filename);
s_e = resample(s_e,16000,fs_e);

% clear all
% clc
% close all

fft_size = 960;
hop_size = 240;

sft_m = stft(s_e',960,240,0,hann(960));
sphase_m = sft_m./abs(sft_m);
smag_m = abs(sft_m);

avg_p = zeros(1,size(smag_m,2));

% find the time domain samples for each spectral frame and compute average
% power of each spectral frame
for i = 0:size(smag_m,2)-1
    X = s_e(1 + (i*hop_size): min(fft_size+(i*hop_size),size(s_e,1)));
    avg_p(1,i+1) = 10*log10(mean(X.^2));
end

plot(avg_p); title('Plotx'); figure;
hist(avg_p,50); title('Histx');
spectra = [];

% spectra = matrix of spectral frames whose average power is above the
% threshold specified
for i = 1:size(smag_m,2)
    if(avg_p(1,i) > threshold)
        spectra = [spectra smag_m(:,i)];
    end
end
sum(avg_p < threshold)
spectra;

end
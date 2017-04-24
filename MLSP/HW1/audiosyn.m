% MLSP - Homework 1 - Problem 1
% Synthesizing audio from the Harmonica notes

clear all
clc
close all

% W = Matrix of the spectrum of harmonica notes
W = [];

% Read the wave file into a signal, and find the fft spectrum of each
% signal
% s_e = signal of the e note
% spectrum_e = fft spectrum of the e note
[s_e fs_e] = wavread('harmonica/e.wav');
s_e = resample(s_e,16000,fs_e);
spectrum_e = mean(abs(stft(s_e',2048,256,0,hann(2048))),2);
W = [W spectrum_e];

[s_f fs_f] = wavread('harmonica/f.wav');
s_f= resample(s_f,16000,fs_f);
spectrum_f = mean(abs(stft(s_f',2048,256,0,hann(2048))),2);
W = [W spectrum_f];

[s_g fs_g] = wavread('harmonica/g.wav');
s_g = resample(s_g,16000,fs_g);
spectrum_g = mean(abs(stft(s_g',2048,256,0,hann(2048))),2);
W = [W spectrum_g];

[s_a fs_a] = wavread('harmonica/a.wav');
s_a = resample(s_a,16000,fs_a);
spectrum_a = mean(abs(stft(s_a',2048,256,0,hann(2048))),2);
W = [W spectrum_a];

[s_b fs_b] = wavread('harmonica/b.wav');
s_b = resample(s_b,16000,fs_b);
spectrum_b = mean(abs(stft(s_b',2048,256,0,hann(2048))),2);
W = [W spectrum_b];

[s_c fs_c] = wavread('harmonica/c.wav');
s_c = resample(s_c,16000,fs_c);
spectrum_c = mean(abs(stft(s_c',2048,256,0,hann(2048))),2);
W = [W spectrum_c];

[s_d fs_d] = wavread('harmonica/d.wav');
s_d = resample(s_d,16000,fs_d);
spectrum_d = mean(abs(stft(s_d',2048,256,0,hann(2048))),2);
W = [W spectrum_d];

[s_e2 fs_e2] = wavread('harmonica/e2.wav');
s_e2 = resample(s_e2,16000,fs_e2);
spectrum_e2 = mean(abs(stft(s_e2',2048,256,0,hann(2048))),2);
W = [W spectrum_e2];

[s_f2 fs_f2] = wavread('harmonica/f2.wav');
s_f2 = resample(s_f2,16000,fs_f2);
spectrum_f2 = mean(abs(stft(s_f2',2048,256,0,hann(2048))),2);
W = [W spectrum_f2];

[s_g2 fs_g2] = wavread('harmonica/g2.wav');
s_g2 = resample(s_g2,16000,fs_g2);
spectrum_g2 = mean(abs(stft(s_g2',2048,256,0,hann(2048))),2);
W = [W spectrum_g2];

[s_a2 fs_a2] = wavread('harmonica/a2.wav');
s_a2 = resample(s_a2,16000,fs_a2);
spectrum_a2 = mean(abs(stft(s_a2',2048,256,0,hann(2048))),2);
W = [W spectrum_a2];

% spectrogram of music signal
[s_m fs_m] = wavread('harmonica/polyushka.wav');
s_m = resample(s_m,16000,fs_m);
sft_m = stft(s_m',2048,256,0,hann(2048));
sphase_m = sft_m./abs(sft_m);
smag_m = abs(sft_m);

Wpinv = pinv(W);
% X = original transcription matrix %
X = Wpinv * smag_m;      

% Xth = thresholded transcription matrix using
% actual weights of the spectral elements above the threshold%
Xth = X.*(X > 0.03);

% Xyna = Music synthesized using the thresholded transcription matrix
Xsyn_smag = W * Xth;
Xsyna = Xsyn_smag .* sphase_m;

% Xsynax = Music synthesized using the original transcription matrix
Xsyn_smagx = W * X;
Xsynax = Xsyn_smagx .* sphase_m;

s_syn = stft(Xsyna,2048,256,0,hann(2048));
s_synx = stft(Xsynax,2048,256,0,hann(2048));

wavwrite(s_syn,'synth_h.wav')
wavwrite(s_synx,'synth_hx.wav')





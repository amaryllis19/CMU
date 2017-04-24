% MLSP - Homework 1 - Problem 3
% Transform harmonica notes to piano notes
% Synthesize music from the original piano notes and the transformed
% harmonica notes

clear all
clc
close all

% spectrogram of music signal
[s_m fs_m] = wavread('harmonica/polyushka.wav');
s_m = resample(s_m,16000,fs_m);
sft_m = stft(s_m',2048,256,0,hann(2048));
sphase_m = sft_m./abs(sft_m);
smag_m = abs(sft_m);

% W = Matrix of the spectrum of harmonica notes
W = [];

% Read the wave file into a signal, and find the fft spectrum of each
% signal
% s_e = signal of the e note
% spectrum_e = fft spectrum of the e note
% Similarly read all the other notes from harmonica
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

H = W;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% V = Matrix of the spectrum of piano notes
V = [];

% Read the wave file into a signal, and find the fft spectrum of each
% signal
% s_a = signal of the e note
% spectrum_a = fft spectrum of the e note
% Similarly read all the other notes from piano
[s_a fs_a] = wavread('piano/a.wav');
s_a = resample(s_a,16000,fs_e);
spectrum_a = mean(abs(stft(s_a',2048,256,0,hann(2048))),2);
V = [V spectrum_a];

[s_e fs_e] = wavread('piano/e.wav');
s_e= resample(s_e,16000,fs_e);
spectrum_e = mean(abs(stft(s_e',2048,256,0,hann(2048))),2);
V = [V spectrum_e];

[s_ee fs_ee] = wavread('piano/ee.wav');
s_ee = resample(s_ee,16000,fs_ee);
spectrum_ee = mean(abs(stft(s_ee',2048,256,0,hann(2048))),2);
V = [V spectrum_ee];

[s_f fs_f] = wavread('piano/f.wav');
s_f = resample(s_f,16000,fs_f);
spectrum_f = mean(abs(stft(s_f',2048,256,0,hann(2048))),2);
V = [V spectrum_f];

[s_h fs_h] = wavread('piano/h.wav');
s_h = resample(s_h,16000,fs_h);
spectrum_h = mean(abs(stft(s_h',2048,256,0,hann(2048))),2);
V = [V spectrum_h];

[s_i fs_i] = wavread('piano/i.wav');
s_i = resample(s_i,16000,fs_i);
spectrum_i = mean(abs(stft(s_i',2048,256,0,hann(2048))),2);
V = [V spectrum_i];

[s_n fs_n] = wavread('piano/n.wav');
s_n = resample(s_n,16000,fs_n);
spectrum_n = mean(abs(stft(s_n',2048,256,0,hann(2048))),2);
V = [V spectrum_n];

[s_nn fs_nn] = wavread('piano/nn.wav');
s_nn = resample(s_nn,16000,fs_nn);
spectrum_nn = mean(abs(stft(s_nn',2048,256,0,hann(2048))),2);
V = [V spectrum_nn];

[s_nnn fs_nnn] = wavread('piano/nnn.wav');
s_nnn = resample(s_nnn,16000,fs_nnn);
spectrum_nnn = mean(abs(stft(s_nnn',2048,256,0,hann(2048))),2);
V = [V spectrum_nnn];

[s_o fs_o] = wavread('piano/o.wav');
s_o = resample(s_o,16000,fs_o);
spectrum_o = mean(abs(stft(s_o',2048,256,0,hann(2048))),2);
V = [V spectrum_o];

[s_oo fs_oo] = wavread('piano/oo.wav');
s_oo = resample(s_oo,16000,fs_oo);
spectrum_oo = mean(abs(stft(s_oo',2048,256,0,hann(2048))),2);
V = [V spectrum_oo];

[s_ooo fs_ooo] = wavread('piano/ooo.wav');
s_ooo = resample(s_ooo,16000,fs_ooo);
spectrum_ooo = mean(abs(stft(s_ooo',2048,256,0,hann(2048))),2);
V = [V spectrum_ooo];

[s_oooo fs_oooo] = wavread('piano/oooo.wav');
s_oooo = resample(s_oooo,16000,fs_a2);
spectrum_oooo = mean(abs(stft(s_oooo',2048,256,0,hann(2048))),2);
V = [V spectrum_oooo];

[s_p fs_p] = wavread('piano/p.wav');
s_p = resample(s_p,16000,fs_p);
spectrum_p = mean(abs(stft(s_p',2048,256,0,hann(2048))),2);
V = [V spectrum_p];

[s_r fs_r] = wavread('piano/r.wav');
s_r = resample(s_r,16000,fs_r);
spectrum_r = mean(abs(stft(s_r',2048,256,0,hann(2048))),2);
V = [V spectrum_r];

[s_s fs_s] = wavread('piano/s.wav');
s_s = resample(s_s,16000,fs_s);
spectrum_s = mean(abs(stft(s_s',2048,256,0,hann(2048))),2);
V = [V spectrum_s];

[s_s fs_s] = wavread('piano/t.wav');
s_s = resample(s_s,16000,fs_s);
spectrum_s = mean(abs(stft(s_s',2048,256,0,hann(2048))),2);
V = [V spectrum_s];

[s_w fs_w] = wavread('piano/w.wav');
s_w = resample(s_w,16000,fs_w);
spectrum_w = mean(abs(stft(s_w',2048,256,0,hann(2048))),2);
V = [V spectrum_w];

% print V %
V;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Corel = correlation matrix of the harmonica notes and piano notes
Corel = zeros(size(H,2),size(V,2));

for i = 1:size(H,2)
    for j = 1:size(V,2)
        Corel(i,j) = (H(:,i)' * V(:,j))/(norm(H(:,i))* norm(V(:,j)));
    end
end
Corel;

P = zeros(size(H,1),size(H,2));
index = zeros(size(H,2),1);

% Form a matrix P having piano notes that best correspond to the harmonica
% notes
for i = 1:size(Corel,1)
    [maxm indexi] = max(Corel(i,:),[],2); %gives column vector with max values
    index(i) = indexi;
    P(:,i) = V(:,indexi);
end

P;
index;

%% M * H = P
% M = Transformation matrix that converts harmonica notes to piano notes
% H = Matrix of spectrum of harmonica notes
% P = Matrix of spectrum of piano notes corresponding to harmonica notes

Hpinv = pinv(H);
M = P * Hpinv;

% Ptransformed = Matrix of harmonica notes transformed to piano notes
Ptransformed = M * H;

Vpinv = pinv(V);

% Y = Original transcription matrix of piano notes
Y = Vpinv * smag_m

% Yth = Thresholded transcription matrix
Yth = Y .* (Y > 0.08);

% Psyna = synthesized piano music spectrum using the original 
% transcription matrix
Psyn_smag = V * Y;
Psyna = Psyn_smag .* sphase_m;
Ps_syn = stft(Psyna,2048,256,0,hann(2048));
wavwrite(Ps_syn,'synth_py.wav');

% Psyna_thy = synthesized piano music spectrum using the thresholded
% transcription matrix
Psyn_thy_smag = V * Yth;
Psyna_thy = Psyn_thy_smag .* sphase_m;
Ps_syn_thy = stft(Psyna_thy,2048,256,0,hann(2048));
wavwrite(Ps_syn_thy,'synth_p.wav');

Ptr_pinv = pinv(Ptransformed);

% Z = original transcription matrix of transformed harmonica notes
Z = Ptr_pinv * smag_m

% Zth = thresholded transcription matrix of transformed harmonica notes
Zth = Z .* (Z > 0.05);

% Ptr_syna = sythesized music spectrum from the original transcription
% matrix
Ptr_syn_smag = Ptransformed * Z;
Ptr_syna = Ptr_syn_smag .* sphase_m;
Ptr_s_syn = stft(Ptr_syna,2048,256,0,hann(2048));
wavwrite(Ptr_s_syn,'synth_transz.wav');

% Ptr_synaz = synthesized music spectrum from the thresholded transcription
% matrix
Ptr_synz_smag = Ptransformed * Zth;
Ptr_synaz = Ptr_synz_smag .* sphase_m;
Ptr_s_synz = stft(Ptr_synaz,2048,256,0,hann(2048));
wavwrite(Ptr_s_synz,'synth_trans.wav');
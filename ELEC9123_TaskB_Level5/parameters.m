%% ==========================================================
% ELEC9123 Design Task B
%
% Parameter Setting File
%
% This file stores all common parameters used in Task B.
% All simulation modules use these parameters to keep the
% same system settings.
%
% Main Parameters:
%   N         Number of Monte Carlo samples
%   N0        Noise variance
%   SNR_dB    SNR range in dB
%   K         Rician K-factor
%   hd        Deterministic LoS component
%   R         Radius of circular user deployment region
%   alpha     Path loss exponent
%   C         Capacity threshold for outage probability
%
% ==========================================================

%% Monte Carlo Setting

% Number of random samples
N = 1e7;

%% Noise Setting

% Noise variance
N0 = 1;

%% SNR Setting

% SNR range in dB
SNR_dB = 0:1:15;

% Convert SNR from dB to linear scale
SNR = 10.^(SNR_dB/10);

%% Rician Channel Setting

% Rician K-factor
K = 5;

% Deterministic LoS component
hd = 1;

%% Random User Deployment Setting

% Radius of circular region
R = 3;

% Path loss exponent
alpha = 2.2;

%% Outage Probability Setting

% Capacity threshold
C = 1.2;

% Equivalent SNR threshold
gamma_th = 2^C - 1;

%% BPSK Symbol Generation

% Generate random binary bits
bits = randi([0 1],N,1);

% BPSK mapping
% Bit 0 -> -1
% Bit 1 -> +1
x = 2*bits - 1;

%% Display Parameter Summary

disp('Default parameters loaded:');
disp(['N = ', num2str(N)]);
disp(['N0 = ', num2str(N0)]);
disp(['SNR range = ', num2str(SNR_dB(1)), ...
      ' dB to ', num2str(SNR_dB(end)), ' dB']);
disp(['K = ', num2str(K)]);
disp(['hd = ', num2str(hd)]);
disp(['R = ', num2str(R), ' m']);
disp(['alpha = ', num2str(alpha)]);
disp(['C = ', num2str(C), ' bps/Hz']);
disp(['gamma_th = ', num2str(gamma_th)]);
clc;
clear;
close all;

%% ==========================================================
% ELEC9123 Design Task B
%
% Main Program
%
% This file controls the execution of the entire project.
%
% The program performs:
%   1. Load all system parameters
%   2. Verify Laplacian random variables
%   3. Simulate BER under different channel models
%   4. Simulate outage probability
%   5. Generate all required figures
%
% ==========================================================

%% Add project folders

addpath('Verify');
addpath('BER');
addpath('Outage');

%% Load Common Parameters

% Load all system parameters used throughout the project
run('parameters.m');

%% Generate Laplacian Noise

lap_noise = laplace_verify(N,N0);

%% Verify Laplacian PDF and CDF

plot_noise(lap_noise,N0);

%% BER Simulation

% AWGN channel
[BER_AWGN_sim,BER_AWGN_theory] = ber_awgn(bits,x,SNR,N0);

% Laplacian noise channel
[BER_Lap_sim,BER_Lap_theory] = ber_laplace(bits,x,SNR,N0);

% Rayleigh fading channel
[BER_Rayleigh_sim,BER_Rayleigh_theory] = ber_rayleigh(bits,x,SNR,N0);

% Rician fading channel
[BER_Rician_sim,BER_Rician_theory] = ber_rician(bits,x,SNR,N0,K);

% Random users over Rayleigh fading channel
[BER_RandRayleigh_sim,BER_RandRayleigh_theory] = ber_random_rayleigh(bits,x,SNR,N0,R,alpha);

% Random users over Rician fading channel
[BER_RandRician_sim,BER_RandRician_theory] = ber_random_rician(bits,x,SNR,N0,K,R,alpha);

%% Outage Probability Simulation

% Rayleigh fading
[Pout_Rayleigh_sim,Pout_Rayleigh_theory] = outage_rayleigh(SNR,gamma_th,N);

% Rician fading
[Pout_Rician_sim,Pout_Rician_theory] = outage_rician(SNR,gamma_th,N,K);

% Random users over Rayleigh fading
[Pout_RandRayleigh_sim,Pout_RandRayleigh_theory] = outage_random_rayleigh(SNR,gamma_th,N,R,alpha);

% Random users over Rician fading
[Pout_RandRician_sim,Pout_RandRician_theory] = outage_random_rician(SNR,gamma_th,N,R,alpha,K);

%% Plot BER Results

% Plot BER performance comparison for all channel models
plot_ber(SNR_dB,...
         BER_AWGN_sim,BER_AWGN_theory,...
         BER_Lap_sim,BER_Lap_theory,...
         BER_Rayleigh_sim,BER_Rayleigh_theory,...
         BER_RandRayleigh_sim,BER_RandRayleigh_theory,...
         BER_Rician_sim,BER_Rician_theory,...
         BER_RandRician_sim,BER_RandRician_theory);

%% Plot Outage Results

% Plot outage probability comparison for all channel models
plot_outage(SNR_dB,...
             Pout_Rayleigh_sim,Pout_Rayleigh_theory,...
             Pout_RandRayleigh_sim,Pout_RandRayleigh_theory,...
             Pout_Rician_sim,Pout_Rician_theory,...
             Pout_RandRician_sim,Pout_RandRician_theory);

%% End of Program

disp('===========================================');
disp(        'ELEC9123 Design Task B');
disp(        'Program finished successfully.');
disp('===========================================');
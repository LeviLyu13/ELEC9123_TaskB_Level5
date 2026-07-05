function plot_outage(SNR_dB,...
                     Pout_Rayleigh_sim,Pout_Rayleigh_theory,...
                     Pout_Random_sim,Pout_Random_theory,...
                     Pout_Rician_sim,Pout_Rician_theory,...
                     Pout_RandomRician_sim,Pout_RandomRician_theory)

% ==========================================================
% ELEC9123 Design Task B
%
% Outage Probability Plot
%
% This function plots the simulated and analytical outage
% probability under different channel models.
%
% Inputs:
%   SNR_dB                        SNR values in dB
%
%   Pout_Rayleigh_sim             Simulated Rayleigh outage probability
%   Pout_Rayleigh_theory          Analytical Rayleigh outage probability
%
%   Pout_Random_sim              Simulated Random Rayleigh outage probability
%   Pout_Random_theory           Analytical Random Rayleigh outage probability
%
%   Pout_Rician_sim              Simulated Rician outage probability
%   Pout_Rician_theory           Analytical Rician outage probability
%
%   Pout_RandomRician_sim        Simulated Random Rician outage probability
%   Pout_RandomRician_theory     Analytical Random Rician outage probability
%
% Outputs:
%   None
%
% ==========================================================

%% Plot Outage Probability

figure;

%% Rayleigh Fading

% Plot analytical Rayleigh outage probability
semilogy(SNR_dB,Pout_Rayleigh_theory,'r','LineWidth',2);
hold on;

% Plot simulated Rayleigh outage probability
semilogy(SNR_dB,Pout_Rayleigh_sim,'ro','LineWidth',1.5);

%% Random User Rayleigh Fading

% Plot analytical Random Rayleigh outage probability
semilogy(SNR_dB,Pout_Random_theory,'b','LineWidth',2);

% Plot simulated Random Rayleigh outage probability
semilogy(SNR_dB,Pout_Random_sim,'bs','LineWidth',1.5);

%% Rician Fading

% Plot analytical Rician outage probability
semilogy(SNR_dB,Pout_Rician_theory,'k','LineWidth',2);

% Plot simulated Rician outage probability
semilogy(SNR_dB,Pout_Rician_sim,'kd','LineWidth',1.5);

%% Random User Rician Fading

% Plot analytical Random Rician outage probability
semilogy(SNR_dB,Pout_RandomRician_theory,'m','LineWidth',2);

% Plot simulated Random Rician outage probability
semilogy(SNR_dB,Pout_RandomRician_sim,'m^','LineWidth',1.5);

%% Figure Settings

grid on;

xlabel('Average SNR \gamma_b (dB)');
ylabel('Outage Probability');
title('Outage Probability Comparison under Different Channel Models');

legend('Rayleigh Theory', ...
       'Rayleigh Simulation', ...
       'Random Rayleigh Theory', ...
       'Random Rayleigh Simulation', ...
       'Rician Theory', ...
       'Rician Simulation', ...
       'Random Rician Theory', ...
       'Random Rician Simulation', ...
       'Location','southwest');

%% Display Result

disp('----------------------------------------');
disp('Outage probability plot completed.');
disp('----------------------------------------');

end
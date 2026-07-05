function plot_ber(SNR_dB,...
                  BER_AWGN_sim,BER_AWGN_theory,...
                  BER_Lap_sim,BER_Lap_theory,...
                  BER_Rayleigh_sim,BER_Rayleigh_theory,...
                  BER_Random_sim,BER_Random_theory,...
                  BER_Rician_sim,BER_Rician_theory,...
                  BER_RandomRician_sim,BER_RandomRician_theory)

% ==========================================================
% ELEC9123 Design Task B
%
% BER Plot
%
% This function plots the simulated and analytical BER
% results for different channel models.
%
% Inputs:
%   SNR_dB                     SNR values in dB
%
%   BER_AWGN_sim               Simulated BER over AWGN channel
%   BER_AWGN_theory            Analytical BER over AWGN channel
%
%   BER_Lap_sim                Simulated BER over Laplacian channel
%   BER_Lap_theory             Analytical BER over Laplacian channel
%
%   BER_Rayleigh_sim           Simulated BER over Rayleigh channel
%   BER_Rayleigh_theory        Analytical BER over Rayleigh channel
%
%   BER_Random_sim             Simulated BER over Random Rayleigh channel
%   BER_Random_theory          Analytical BER over Random Rayleigh channel
%
%   BER_Rician_sim             Simulated BER over Rician channel
%   BER_Rician_theory          Analytical BER over Rician channel
%
%   BER_RandomRician_sim       Simulated BER over Random Rician channel
%   BER_RandomRician_theory    Analytical BER over Random Rician channel
%
% Outputs:
%   None
%
% ==========================================================

%% Plot BER Curves

figure;

%% AWGN

semilogy(SNR_dB,BER_AWGN_theory,'r','LineWidth',2);
hold on;
semilogy(SNR_dB,BER_AWGN_sim,'ro','LineWidth',1.5);

%% Laplacian Noise

semilogy(SNR_dB,BER_Lap_theory,'b','LineWidth',2);
semilogy(SNR_dB,BER_Lap_sim,'bs','LineWidth',1.5);

%% Rayleigh Fading

semilogy(SNR_dB,BER_Rayleigh_theory,'k','LineWidth',2);
semilogy(SNR_dB,BER_Rayleigh_sim,'kd','LineWidth',1.5);

%% Random User Rayleigh Fading

semilogy(SNR_dB,BER_Random_theory,'m','LineWidth',2);
semilogy(SNR_dB,BER_Random_sim,'m^','LineWidth',1.5);

%% Rician Fading

semilogy(SNR_dB,BER_Rician_theory,'g','LineWidth',2);
semilogy(SNR_dB,BER_Rician_sim,'gv','LineWidth',1.5);

%% Random User Rician Fading

semilogy(SNR_dB,BER_RandomRician_theory,'c','LineWidth',2);
semilogy(SNR_dB,BER_RandomRician_sim,'cp','LineWidth',1.5);

%% Figure Settings

grid on;

xlabel('Average SNR \gamma_b (dB)');
ylabel('Bit Error Rate (BER)');
title('BER Performance Comparison under Different Channel Models');

legend('AWGN Theory', ...
       'AWGN Simulation', ...
       'Laplacian Theory', ...
       'Laplacian Simulation', ...
       'Rayleigh Theory', ...
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
disp('BER plot completed.');
disp('----------------------------------------');

end
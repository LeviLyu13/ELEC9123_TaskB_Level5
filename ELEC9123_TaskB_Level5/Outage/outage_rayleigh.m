function [Pout_sim,Pout_theory] = outage_rayleigh(SNR,gamma_th,N)

% ==========================================================
% ELEC9123 Design Task B
%
% Outage Probability over Rayleigh Fading Channel
%
% This function simulates the outage probability over a
% Rayleigh fading channel and compares it with the analytical
% result.
%
% Inputs:
%   SNR          Linear average SNR values
%   gamma_th    Outage SNR threshold
%   N            Number of Monte Carlo samples
%
% Outputs:
%   Pout_sim     Simulated outage probability
%   Pout_theory  Analytical outage probability
%
% ==========================================================

%% Initialization

% Number of SNR points
num_SNR = length(SNR);

% Initialize simulated outage probability array
Pout_sim = zeros(1,num_SNR);

% Initialize analytical outage probability array
Pout_theory = zeros(1,num_SNR);

%% Outage Probability Simulation

for i = 1:num_SNR

    % Current average SNR
    gamma_b = SNR(i);

    % Generate Rayleigh fading channel coefficients
    h = (randn(N,1) + 1j*randn(N,1))/sqrt(2);

    % Calculate instantaneous SNR
    gamma_inst = abs(h).^2 * gamma_b;

    % Determine outage events
    outage_events = gamma_inst < gamma_th;

    % Calculate simulated outage probability
    Pout_sim(i) = mean(outage_events);

    %% Calculate analytical outage probability
    Pout_theory(i) = 1 - exp(-gamma_th/gamma_b);

end

%% Display Result

disp('----------------------------------------');
disp('Rayleigh outage probability simulation completed.');
disp('----------------------------------------');

end
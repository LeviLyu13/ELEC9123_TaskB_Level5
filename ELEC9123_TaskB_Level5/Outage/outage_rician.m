function [Pout_sim,Pout_theory] = outage_rician(SNR,gamma_th,N,K)

% ==========================================================
% ELEC9123 Design Task B
%
% Outage Probability over Rician Fading Channel
%
% This function simulates the outage probability over a
% Rician fading channel and compares it with the analytical
% result obtained by numerical integration.
%
% Inputs:
%   SNR          Linear average SNR values
%   gamma_th    Outage SNR threshold
%   N            Number of Monte Carlo samples
%   K            Rician K-factor
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

% Deterministic Line-of-Sight component
hd = 1;

%% Outage Probability Simulation

for i = 1:num_SNR

    % Current average SNR
    gamma_b = SNR(i);

    % Generate scattered component
    hs = (randn(N,1) + 1j*randn(N,1)) / sqrt(2);

    % Generate Rician fading channel coefficients
    h = sqrt(K/(K+1)) * hd + sqrt(1/(K+1)) * hs;

    % Calculate instantaneous SNR
    gamma_inst = gamma_b * abs(h).^2;

    % Determine outage events
    outage_events = gamma_inst < gamma_th;

    % Calculate simulated outage probability
    Pout_sim(i) = mean(outage_events);

    %% Analytical Outage Probability 

    % Calculate Marcum-Q function parameters
    a = sqrt(2*K);
    b = sqrt(2*(K+1) * gamma_th/gamma_b);

    % Calculate analytical outage probability using Marcum-Q function
    Pout_theory(i) = 1 - marcumq(a,b);

end

%% Display Result

disp('----------------------------------------');
disp('Rician outage probability simulation completed.');
disp('----------------------------------------');

end
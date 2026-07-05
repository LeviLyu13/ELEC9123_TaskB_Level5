function [Pout_sim,Pout_theory] = outage_random_rayleigh(SNR,gamma_th,N,R,alpha)

% ==========================================================
% ELEC9123 Design Task B
%
% Outage Probability over Random User Rayleigh Fading Channel
%
% This function simulates the outage probability for randomly
% deployed users over Rayleigh fading channels.
%
% Inputs:
%   SNR          Linear average SNR values
%   gamma_th    Outage SNR threshold
%   N            Number of Monte Carlo samples
%   R            Radius of circular user deployment region
%   alpha        Path loss exponent
%
% Outputs:
%   Pout_sim     Simulated outage probability
%   Pout_theory  Analytical outage probability estimated by averaging
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

    % Generate random user distances in a circular region
    d = R * sqrt(rand(N,1));

    % Avoid zero distance to prevent division by zero
    d(d == 0) = eps;

    % Generate Rayleigh fading channel coefficients
    h = (randn(N,1) + 1j*randn(N,1)) / sqrt(2);

    % Calculate instantaneous SNR with path loss
    gamma_inst = gamma_b * abs(h).^2 ./ (d.^alpha);

    % Determine outage events
    outage_events = gamma_inst < gamma_th;

    % Calculate simulated outage probability
    Pout_sim(i) = mean(outage_events);

    %% Analytical Outage Probability
    
    integrand = @(r) (1 - exp(-gamma_th .* r.^alpha ./ gamma_b)) .* (2 .* r ./ R^2);
    
    Pout_theory(i) = integral(integrand,0,R);

end

%% Display Result

disp('----------------------------------------');
disp('Random user Rayleigh outage simulation completed.');
disp('----------------------------------------');

end
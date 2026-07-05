function [Pout_sim,Pout_theory] = outage_random_rician(SNR,gamma_th,N,R,alpha,K)

% ==========================================================
% ELEC9123 Design Task B
%
% Outage Probability over Random User Rician Fading Channel
%
% This function simulates the outage probability for randomly
% deployed users over Rician fading channels.
%
% Inputs:
%   SNR          Linear average SNR values
%   gamma_th     Outage SNR threshold
%   N            Number of Monte Carlo samples
%   R            Radius of circular user deployment region
%   alpha        Path loss exponent
%   K            Rician K-factor
%
% Outputs:
%   Pout_sim     Simulated outage probability
%   Pout_theory  Numerical outage probability estimated by averaging
%
% ==========================================================

%% Initialization

% Number of SNR points
num_SNR = length(SNR);

% Initialize simulated outage probability array
Pout_sim = zeros(1,num_SNR);

% Initialize theoretical outage probability array
Pout_theory = zeros(1,num_SNR);

% Deterministic Line-of-Sight component
hd = 1;

%% Outage Probability Simulation

for i = 1:num_SNR

    % Current average SNR
    gamma_b = SNR(i);

    % Generate random user distances in a circular region
    d = R * sqrt(rand(N,1));

    % Avoid zero distance to prevent division by zero
    d(d == 0) = eps;

    % Generate scattered component
    hs = (randn(N,1) + 1j*randn(N,1)) / sqrt(2);

    % Generate Rician fading channel coefficients
    h = sqrt(K/(K+1)) * hd + sqrt(1/(K+1)) * hs;

    % Calculate instantaneous SNR with path loss
    gamma_inst = gamma_b * abs(h).^2 ./ (d.^alpha);

    % Determine outage events
    outage_events = gamma_inst < gamma_th;

    % Calculate simulated outage probability
    Pout_sim(i) = mean(outage_events);

    %% Analytical Outage Probability

    % Define outage integrand for random user Rician channel
    integrand = @(r) (1 - marcumq(sqrt(2*K), sqrt(2*(K+1)*gamma_th.*r.^alpha./gamma_b))) .* (2.*r./R^2);

    % Calculate analytical outage probability
    Pout_theory(i) = integral(integrand,0,R);

end

%% Display Result

disp('----------------------------------------');
disp('Random user Rician outage simulation completed.');
disp('----------------------------------------');

end
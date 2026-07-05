function [BER_sim,BER_theory] = ber_random_rayleigh(bits,x,SNR,N0,R,alpha)

% ==========================================================
% ELEC9123 Design Task B
%
% BER Simulation over Random User Rayleigh Fading Channel
%
% This function simulates the BER of a BPSK communication
% system where users are randomly deployed inside a circular
% region and the channel experiences Rayleigh fading and AWGN.
%
% Inputs:
%   bits        Original binary bits
%   x           BPSK symbols
%   SNR         Linear average SNR values
%   N0          Noise variance
%   R           Radius of circular user deployment region
%   alpha       Path loss exponent
%
% Outputs:
%   BER_sim     Simulated BER
%   BER_theory  Analytical BER estimated by numerical averaging
%
% ==========================================================

%% Initialization

% Number of SNR points
num_SNR = length(SNR);

% Initialize simulated BER array
BER_sim = zeros(1,num_SNR);

% Initialize analytical BER array
BER_theory = zeros(1,num_SNR);

% Number of transmitted bits
N = length(bits);

%% BER Simulation

for i = 1:num_SNR

    % Current average SNR
    gamma_b = SNR(i);

    % Calculate BPSK signal amplitude
    A = sqrt(gamma_b * N0);

    % Generate transmitted BPSK signal
    tx_signal = A * x;

    % Generate random user distances in a circular region
    d = R * sqrt(rand(N,1));

    % Avoid zero distance
    d(d == 0) = eps;

    % Generate Rayleigh fading channel coefficients
    h = (randn(N,1) + 1j*randn(N,1))/sqrt(2);

    % Apply path loss to the channel amplitude
    h_eff = h ./ (d.^(alpha/2));

    % Generate complex AWGN noise
    noise = sqrt(N0/2) * (randn(N,1) + 1j*randn(N,1));

    % Received signal
    y = h_eff .* tx_signal + noise;

    % Equalize the received signal
    y_equalized = y ./ h_eff;

    % Hard decision detection
    detected_bits = real(y_equalized) > 0;

    % Calculate simulated BER
    BER_sim(i) = mean(detected_bits ~= bits);

    %% Analytical BER
    
    % Define BER integrand for random user Rayleigh fading
    integrand = @(r) 0.5 .* (1 - sqrt((gamma_b ./ (r.^alpha)) ./ (1 + gamma_b ./ (r.^alpha)))) .* (2 .* r ./ R^2);

    % Calculate analytical BER by averaging over user distance
    BER_theory(i) = integral(integrand,0,R);


end

%% Display Result

disp('----------------------------------------');
disp('Random user Rayleigh BER simulation completed.');
disp('----------------------------------------');

end
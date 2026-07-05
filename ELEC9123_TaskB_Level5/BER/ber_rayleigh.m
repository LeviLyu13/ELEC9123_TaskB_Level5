function [BER_sim,BER_theory] = ber_rayleigh(bits,x,SNR,N0)

% ==========================================================
% ELEC9123 Design Task B
%
% BER Simulation over Rayleigh Fading and AWGN Channel
%
% This function simulates the bit error rate of a BPSK
% communication system over a Rayleigh fading channel with
% additive white Gaussian noise.
%
% Inputs:
%   bits        Original binary bits
%   x           BPSK symbols
%   SNR         Linear SNR values
%   N0          Noise variance
%
% Outputs:
%   BER_sim     Simulated BER over Rayleigh fading channel
%   BER_theory  Analytical BER over Rayleigh fading channel
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

    % Generate Rayleigh fading channel coefficient
    h = (randn(N,1) + 1j*randn(N,1)) / sqrt(2);

    % Generate complex AWGN noise
    noise = sqrt(N0/2) * (randn(N,1) + 1j*randn(N,1));

    % Received signal over Rayleigh fading channel
    y = h .* tx_signal + noise;

    % Channel Equalization
    y_equalized = y ./ h;

    % Hard decision detection
    detected_bits = real(y_equalized) > 0;

    % Calculate simulated BER
    BER_sim(i) = mean(detected_bits ~= bits);

    %% Calculate analytical BER for BPSK over Rayleigh fading
    BER_theory(i) = 0.5 * (1 - sqrt(gamma_b/(1 + gamma_b)));

end

%% Display Result

disp('----------------------------------------');
disp('Rayleigh BER simulation completed.');
disp('----------------------------------------');

end
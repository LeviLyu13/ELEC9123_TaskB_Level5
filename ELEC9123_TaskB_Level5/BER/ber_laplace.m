function [BER_sim,BER_theory] = ber_laplace(bits,x,SNR,N0)

% ==========================================================
% ELEC9123 Design Task B
%
% BER Simulation over Laplacian Noise Channel
%
% This function simulates the bit error rate of a BPSK
% communication system over a Laplacian noise channel.
%
% Inputs:
%   bits        Original binary bits
%   x           BPSK symbols
%   SNR         Linear SNR values
%   N0          Noise variance
%
% Outputs:
%   BER_sim     Simulated BER over Laplacian noise channel
%   BER_theory  Analytical BER over Laplacian noise channel
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

    % Current SNR value
    gamma_b = SNR(i);

    % Calculate BPSK signal amplitude
    A = sqrt(gamma_b * N0);

    % Generate transmitted BPSK signal
    tx_signal = A * x;

    % Generate uniform random variables for Laplacian noise
    u = rand(N,1) - 0.5;

    % Generate Laplacian noise using inverse transform sampling
    noise = -sqrt(N0/2) .* sign(u) .* log(1 - 2*abs(u));

    % Received signal over Laplacian noise channel
    y = tx_signal + noise;

    % Hard decision detection
    detected_bits = y > 0;

    % Calculate simulated BER
    BER_sim(i) = mean(detected_bits ~= bits);

    %% Calculate analytical BER for BPSK over Laplacian noise
    BER_theory(i) = 0.5 * exp(-sqrt(2*gamma_b));

end

%% Display Result

disp('----------------------------------------');
disp('Laplacian BER simulation completed.');
disp('----------------------------------------');

end
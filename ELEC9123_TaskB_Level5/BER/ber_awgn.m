function [BER_sim,BER_theory] = ber_awgn(bits,x,SNR,N0)

% ==========================================================
% ELEC9123 Design Task B
%
% BER Simulation over AWGN Channel
%
% This function simulates the bit error rate of a BPSK
% communication system over an AWGN channel.
%
% Inputs:
%   bits        Original binary bits
%   x           BPSK symbols
%   SNR         Linear SNR values
%   N0          Noise variance
%
% Outputs:
%   BER_sim     Simulated BER over AWGN channel
%   BER_theory  Analytical BER over AWGN channel
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

    % Generate real AWGN noise
    noise = sqrt(N0/2) * randn(N,1);

    % Generate transmitted BPSK signal
    tx_signal = A * x;

    % Generate received signal over AWGN channel
    y = tx_signal + noise;

    % Hard decision detection
    detected_bits = y > 0;

    % Calculate simulated BER
    BER_sim(i) = mean(detected_bits ~= bits);

    %% Calculate analytical BER for BPSK over AWGN
    BER_theory(i) = 0.5 * erfc(sqrt(gamma_b));

end

%% Display Result

disp('----------------------------------------');
disp('AWGN BER simulation completed.');
disp('----------------------------------------');

end
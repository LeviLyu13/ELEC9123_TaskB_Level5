function [BER_sim,BER_theory] = ber_rician(bits,x,SNR,N0,K)

% ==========================================================
% ELEC9123 Design Task B
%
% BER Simulation over Rician Fading and AWGN Channel
%
% This function simulates the BER of a BPSK system over
% a Rician fading channel with AWGN.
%
% Inputs:
%   bits        Original binary bits
%   x           BPSK symbols
%   SNR         Linear average SNR values
%   N0          Noise variance
%   K           Rician K-factor
%
% Outputs:
%   BER_sim     Simulated BER
%   BER_theory  Theoretical BER estimated by numerical averaging
%
% ==========================================================

%% Initialization

% Number of SNR points
num_SNR = length(SNR);

% Initialize simulated BER array
BER_sim = zeros(1,num_SNR);

% Initialize theoretical BER array
BER_theory = zeros(1,num_SNR);

% Number of transmitted bits
N = length(bits);

% Deterministic Line-of-Sight component
hd = 1;

%% BER Simulation

for i = 1:num_SNR

    % Current average SNR
    gamma_b = SNR(i);

    % Calculate BPSK signal amplitude
    A = sqrt(gamma_b * N0);

    % Generate transmitted BPSK signal
    tx_signal = A * x;

    % Generate scattered component
    hs = (randn(N,1) + 1j*randn(N,1)) / sqrt(2);

    % Generate Rician fading channel coefficient
    h = sqrt(K/(K+1)) * hd + sqrt(1/(K+1)) * hs;

    % Generate complex AWGN noise
    noise = sqrt(N0/2) * (randn(N,1) + 1j*randn(N,1));

    % Received signal over Rician fading channel
    y = h .* tx_signal + noise;

    % Equalize the received signal
    y_equalized = y ./ h;

    % Hard decision detection
    detected_bits = real(y_equalized) > 0;

    % Calculate simulated BER
    BER_sim(i) = mean(detected_bits ~= bits);

    %% Analytical BER

    % Define Rician SNR PDF
    f_aR = @(x) (K+1)./gamma_b .* exp(-K - (K+1).*x./gamma_b) .* besseli(0,sqrt(4*K*(K+1).*x./gamma_b));

    % Calculate analytical BER using numerical integration
    BER_theory(i) = integral(@(x) 0.5 .* erfc(sqrt(x)) .* f_aR(x),0,100);

end

%% Display Result

disp('----------------------------------------');
disp('Rician BER simulation completed.');
disp('----------------------------------------');

end
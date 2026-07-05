function [BER_sim,BER_theory] = ber_random_rician(bits,x,SNR,N0,K,R,alpha)

% ==========================================================
% ELEC9123 Design Task B
%
% BER Simulation over Random User Rician Fading Channel
%
% This function simulates the BER of a BPSK communication
% system where users are randomly deployed inside a circular
% region and the channel experiences Rician fading and AWGN.
%
% Inputs:
%   bits        Original binary bits
%   x           BPSK symbols
%   SNR         Linear average SNR values
%   N0          Noise variance
%   K           Rician K-factor
%   R           Radius of circular user deployment region
%   alpha       Path loss exponent
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

    % Generate random user distances in a circular region
    d = R * sqrt(rand(N,1));

    % Avoid zero distance to prevent division by zero
    d(d == 0) = eps;

    % Generate scattered component
    hs = (randn(N,1) + 1j*randn(N,1)) / sqrt(2);

    % Generate Rician fading channel coefficient
    h = sqrt(K/(K+1))*hd + sqrt(1/(K+1))*hs;

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

    % Define PDF of Rician channel power gain |h|^2
    f_h2 = @(z) (K+1) .* exp(-K - (K+1).*z) .* besseli(0,2.*sqrt(K.*(K+1).*z));

    % Define conditional BER for a fixed user distance
    innerBER = @(r) integral(@(z) 0.5 .* erfc(sqrt(gamma_b.*z./((max(r,eps)).^alpha))).* f_h2(z),0,100,'ArrayValued',true);

    % Define outer integrand over random user distance
    integrand = @(r) arrayfun(@(rr) innerBER(rr),r) .* (2 .* r ./ R^2);

    % Calculate analytical BER by double numerical integration
    BER_theory(i) = integral(integrand,eps,R,'ArrayValued',true);

end

%% Display Result

disp('----------------------------------------');
disp('Random user Rician BER simulation completed.');
disp('----------------------------------------');

end
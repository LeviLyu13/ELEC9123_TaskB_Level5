function plot_noise(lap_noise,N0)

% ==========================================================
% ELEC9123 Design Task B
%
% Laplacian Noise Distribution Verification
%
% This function verifies the generated Laplacian noise by
% comparing the simulated PDF and CDF with the corresponding
% analytical results.
%
% Inputs:
%   lap_noise    Generated Laplacian noise samples
%   N0           Noise variance
%
% Outputs:
%   None
%
% ==========================================================

%% Generate Analytical PDF

% Generate x-axis values
x = linspace(-6,6,1000);

% Analytical Laplacian PDF
pdf_theory = (1/sqrt(2*N0)) .* exp(-sqrt(2/N0) .* abs(x));

%% Plot PDF Comparison

figure;

% Simulated PDF
histogram(lap_noise,100,'Normalization','pdf');
hold on;

% Analytical PDF
plot(x,pdf_theory,'r','LineWidth',2);

grid on;
xlabel('Noise Value');
ylabel('Probability Density Function');
title('Laplacian PDF');
legend('Simulation','Theory');

%% Generate Analytical CDF

% Initialize CDF
cdf_theory = zeros(size(x));

% Calculate analytical CDF
for i = 1:length(x)

    if x(i) <= 0

        cdf_theory(i) = 0.5 * exp(sqrt(2/N0)*x(i));

    else

        cdf_theory(i) = 1 - 0.5 * exp(-sqrt(2/N0)*x(i));

    end

end

%% Plot CDF Comparison

figure;

% Simulated CDF
[f_sim,x_sim] = ecdf(lap_noise);

plot(x_sim,f_sim,'b','LineWidth',2.5);
hold on;

% Analytical CDF
plot(x,cdf_theory,'r','LineWidth',1.5);

grid on;
xlabel('Noise Value');
ylabel('Cumulative Distribution Function');
title('Laplacian CDF');
legend('Simulation','Theory','Location','southeast');

%% Display Result

disp('========================================');
disp('Laplacian PDF and CDF verification completed.');
disp('========================================');

end
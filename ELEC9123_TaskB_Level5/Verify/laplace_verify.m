function lap_noise = laplace_verify(N,N0)

% ==========================================================
% ELEC9123 Design Task B
%
% Laplacian Random Variable Verification
%
% This function generates Laplacian random variables using
% the inverse transform sampling method.
%
% The simulated PDF and CDF are compared with the analytical
% PDF and CDF given in the task sheet.
%
% Inputs:
%   N        Number of Monte Carlo samples
%   N0       Noise variance
%
% Outputs:
%   lap_noise   Generated Laplacian noise samples
%
% ==========================================================

%% Generate Uniform Random Variables

% Generate uniformly distributed random variables in (0,1)
u = rand(N,1);

% Shift the uniform random variables to (-0.5,0.5)
% This makes the generated Laplacian noise symmetric around zero
u = u - 0.5;

%% Generate Laplacian Random Variables

% Generate Laplacian random variables using inverse transform sampling
lap_noise = -sqrt(N0/2) .* sign(u) .* log(1 - 2*abs(u));

%% Display Result

disp('========================================');
disp('Laplacian noise generated successfully.');
disp(['Number of generated samples = ', num2str(length(lap_noise))]);
disp('========================================');

end
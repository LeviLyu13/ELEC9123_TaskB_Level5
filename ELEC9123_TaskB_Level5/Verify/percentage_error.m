function [mean_error,max_error,error_percent] = ...
    percentage_error(sim_result,theory_result,threshold)

% ==========================================================
% Calculate Percentage Error
%
% This function calculates the percentage deviation between
% simulation and theoretical results.
% 
% Very small theoretical BER values are excluded 
% to avoid numerical blow-up
%
% Inputs:
%   sim_result    - Simulation results
%   theory_result - Theoretical results
%   threshold     - Minimum theoretical value considered
%
% Outputs:
%   mean_error    - Mean percentage error (%)
%   max_error     - Maximum percentage error (%)
%   error_percent - Percentage error at each valid point (%)
% ==========================================================

% Select valid data points
valid_index = theory_result > threshold & sim_result > 0;

% Calculate percentage error
error_percent = abs(sim_result(valid_index) - theory_result(valid_index)) ./ theory_result(valid_index) * 100;

% Calculate statistics
mean_error = mean(error_percent);
max_error  = max(error_percent);

end
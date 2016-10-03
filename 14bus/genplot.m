
% ~~~~~~~~~INPUTS~~~~~~~~~ %

% method = method type number one would like to use
% numtrials = number of trials desired
% noise = percentage of max amplitude to add as gaussian noise
% window = percentage of PMUs visible

% ~~~~~~~~~OUTPUTS~~~~~~~~~ %

% A png file with the desired image
% out = The Confusion Matrix
% confidence = array of confidence measures from each
%               trial instance


% TODO: fix calc_contig, this as right now M is printing out the norms
% of the eigenvectors instead.
function [sum_matrix, ranking_matrix] = genplot(method)

load metadata.mat

%   temp variables
sum_matrix = zeros(numcontigs);
ranking_matrix = zeros(numcontigs);

for i = 1:numcontigs
    [sums, ranking, vecs, res] = run_contigtrial(method, i);    
    sum_matrix(i,:) = sums;
    ranking_matrix(i,:) = ranking;
end

end

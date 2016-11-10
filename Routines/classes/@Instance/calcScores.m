function [ranking, scores] = calcScores(obj, method, vecs, residuals)
[numcontigs, numbuses, filename, timestep, numlines, differential, algebraic] = getMetadata(obj);

method_list = {'None', 'Equal', 'Projection'};
if(~(any(ismember(method_list, method))))
    disp('No Fitting Method Listed, Please Choose from the following list');
    disp(method_list);
    error('Input Error');
end
switch method
    
    case 'None' % no weighting; a simple sum
        sums = zeros(1,numcontigs);
        for i = 1:numcontigs
            res = residuals{i};
            [~,n] = size(res);
            for j = 1:n
                sums(i) = sums(i) + norm(res(:,j));
            end
        end
        [scores, ranking] = sort(sums, 'ascend');
        
    case 'Equal'
        scores = zeros(1,numcontigs);
        r1 = residuals{1};
        [~,n] = size(r1);
        for i = 1:n
            temp = zeros(1,numcontigs);
            for j = 1:numcontigs
                res = residuals{j};
                temp(j) = norm(res(:,i));
            end
            [~,idx] = sort(temp, 'ascend');
            
            for j = 1:numcontigs
                scores(idx(j)) = scores(idx(j)) + j;
            end
        end
        [scores, ranking] = sort(scores, 'ascend');
        
    case 'Projection'
        
        A = full(matrix_read('matrixfull'));
        E = zeros(size(A)); E(1:differential,1:differential) = eye(differential);
        [X,~] = eig(A,E);
        X = normalizematrix(X);
        sums = zeros(1,numcontigs);
        for i = 1:numcontigs
            V = vecs{i};
            
            for j = 1:size(V,2)
                temp = X\V(:,j);
                temp = abs(temp);
                temp = temp(temp > .1);
                sums(i) = sums(i) + sum(temp);
            end
        end
        [scores, ranking] = sort(sums, 'ascend');
end

end
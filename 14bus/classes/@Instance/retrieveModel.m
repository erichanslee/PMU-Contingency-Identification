% retrieveModel returns linearized DAE model i, where i = contignum

function [A,E] = retrieveModel(obj,contignum)
temp = obj.testbank{contignum};
A = temp{1};
E = temp{2};
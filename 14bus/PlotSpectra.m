function PlotSpectra(A, E, i)

hold on
grid on
axis equal
xlabel('Re');
ylabel('Im');

[center, radius] = Gershg(A+E, i);
PlotCircle(center, radius, '--b');
[center, radius] = BauerFike(A, E, i);
PlotCircle(center, radius, '-b');


[yright,d] = eig(A);
d = diag(d);
[yleft,~] = eig(A);
DIR = yleft(:,i)'*E*yright(:,i)/(yleft(:,i)'*yright(:,i));
p1 = [real(d(i)), imag(d(i))];
p2temp = d(i) + DIR/norm(DIR);
p2 = [real(p2temp), imag(p2temp)];
dp = p2-p1;                         
q = quiver(p1(1),p1(2),dp(1),dp(2),0);
q.Marker = 'o'

end

function PlotCircle(center, radius, mode)
    t = 0:pi/100:2*pi;
    c = cos(t);
    s = sin(t);
    x = real(center) + radius*c;
    y = imag(center) + radius*s;
    plot(x,y, mode);
end

function [center, radius] = Gershg(A, i)
% Gershgorin's circles C of the matrix A.

d = diag(A);
center = d(i);
B = A - diag(d);
r = sum(abs(B'));
radius = r(i);

end

function [center, radius] = BauerFike(A, E, i)

% BauerFike Circles

nE = norm(E);
[vright,d] = eig(A);
[vleft,~] = eig(A);
center = d(i,i);
radius = size(A,1)*nE/abs(dot(vleft(:,i),vright(:,i)));
end
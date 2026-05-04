clc;
clear all;





























f = @(x1,x2) x1^2 + 2*x2^2;
grad_f = @(x1,x2) [2*x1; 4*x2];

x = [0.1; 0.1];
max_itr = 100;
tol = 1e-6;
alpha = 0.2;

















fprintf('\nInitial Point = (%f, %f)', x(1), x(2));
















for i = 1:max_itr
    gradient = grad_f(x(1), x(2));
    if norm(gradient) < tol
        fprintf('\nConverged after %d iterations', i-1);
        break;
    end
    x = x - alpha * gradient;
    fprintf('\nIteration %d: x = (%f, %f), f(x) = %f', i, x(1), x(2), f(x(1), x(2)));
end








fprintf('\nFinal Solution: (%f, %f)', x(1), x(2));
fprintf('\nMinimum Function Value: %f\n', f(x(1), x(2)));
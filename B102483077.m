clc;
clear all;
n = 2;
M = 1000;
c = [3 2];
a = [1 1;
     1 3];
b = [2;
     3];





















A = [1 1 -1 1 0 2;
     1 3  0 0 1 3];

cost = [c 0 -M -M 0];

bv = [4 5];

zj_cj = cost(bv) * A - cost;

RUN = true;
iter = 1;

















while RUN
    fprintf('\nIteration %d\n', iter);

    if any(zj_cj(1:end-1) < 0)

        fprintf('Solution not optimal\n');

        [~, pivot_col] = min(zj_cj(1:end-1));

        if all(A(:, pivot_col) <= 0)
            error('LPP is unbounded');
        end

        sol = A(:, end);
        col = A(:, pivot_col);

        ratio = inf(size(A,1),1);

        for i = 1:size(A,1)

            if col(i) > 0
                ratio(i) = sol(i) / col(i);
            end

        end





















        [~, pivot_row] = min(ratio);

        pivot_key = A(pivot_row, pivot_col);

        A(pivot_row, :) = A(pivot_row, :) / pivot_key;

        for i = 1:size(A,1)

            if i ~= pivot_row

                A(i, :) = A(i, :) ...
                    - A(i, pivot_col) * A(pivot_row, :);

            end

        end

        bv(pivot_row) = pivot_col;

        zj_cj = cost(bv) * A - cost;

    else

        fprintf('Optimal solution reached\n');
        RUN = false;

    end

    iter = iter + 1;
end


















final_table = array2table([zj_cj; A]);
disp(final_table);

solution = zeros(1, n);

for i = 1:length(bv)

    if bv(i) <= n
        solution(bv(i)) = A(i, end);
    end

end




















fprintf('\nSolution:\n');
fprintf('x1 = %.2f\n', solution(1));
fprintf('x2 = %.2f\n', solution(2));
fprintf('Maximum Z = %.2f\n', zj_cj(end));

using Combinatorics, LinearAlgebra

function isnonnegative(x::Array{Float64,1})
    return length(x[x.<0]) == 0
end

function searchBFS(c, A, b)
    m, n = size(A)
    @assert rank(A) == m

    opt_x = zeros(n)
    obj = Inf

    for b_idx in combinations(1:n, m)
        B = A[:, b_idx]
        c_B = c[b_idx]
        x_B = inv(B) * b
        if isnonnegative(x_B)
            z = dot(c_B, x_B)
            if z < obj
                obj = z
                opt_x = zeros(n)
                opt_x[b_idx] = x_B
            end
        end

        println("Basis:", b_idx)
        println("\t x_B = ", x_B)
        println("\t nonnegative? ", isnonnegative(x_B))

        if isnonnegative(x_B)
            println("\t obj = ", dot(c_B, x_B))
        end
    end
    return opt_x, obj
end

c = [-3; -2; -1; -5; 0; 0; 0]
A = [7 3 4 1 1 0 0;
    2 1 1 5 0 1 0;
    1 4 5 2 0 0 1]
b = [7; 3; 8]
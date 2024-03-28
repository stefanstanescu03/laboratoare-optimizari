using ForwardDiff
using LinearAlgebra

g(x) = 10 * (x[2] - x[1]^2)^2 + (x[1] - 1)^2
g2(x) = (x[1] + 2 * x[2] - 7)^2 + (2 * x[1] + x[2] - 5)^2
g3(x) = -cos(x[1]) * cos(x[2]) * exp(-((x[1] - pi)^2 + (x[2] - pi)^2))
g4(x) = sin(x[1] + x[2]) + (x[1] - x[2])^2 - 1.5 * x[1] + 2.5 * x[2] + 1
g5(x) = (1.5 - x[1] + x[1] * x[2])^2 + (2.25 - x[1] + x[1] * x[2]^2)^2 + (2.625 - x[1] + x[1] * x[2]^3)^2
g6(x) = exp(5 * (x[1] - 8)^2 + 6 * (x[2] - 3)^2)

function newton_method(f, x, eps)

    grad(x) = ForwardDiff.gradient(f, x)
    hess(x) = ForwardDiff.hessian(f, x)

    while norm(grad(x)) > eps
        # x = x - inv(hess(x)) * grad(x)
        x = hess(x) \ (hess(x) * x - grad(x))
    end

    return x

end

function gradient_descent(f, x, a, max_steps, eps)

    grad(x) = ForwardDiff.gradient(f, x)
    k = 0
    while norm(grad(x)) > eps && k < max_steps
        x = x - a * grad(x)
        k += 1
    end

    return x

end

# println(newton_method(g, [10, 10], 1e-2))
# println(newton_method(g2, [10, 10], 1e-2))
# println(newton_method(g3, [3, 3], 1e-2))
# println(newton_method(g4, [1, 1], 1e-2))
println(newton_method(g, [1, 0], 0.1))
println(gradient_descent(g, [1, 0], 0.01, 1000, 0.1))
println(g([1, 1]))
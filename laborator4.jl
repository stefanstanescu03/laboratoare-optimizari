using ForwardDiff
using LinearAlgebra

f(x) = (x[1] - 3)^4 + (x[1] - 3 * x[2])^2
f2(x) = 10 * (x[2] - x[1]^2)^2 + (x[1] - 1)^2

function golden_section(f, a, b, eps)
    gr = (-1 + sqrt(5)) / 2
    l = a + (1 - gr) * (b - a)
    r = a + gr * (b - a)
    fl = f(l)
    fr = f(r)
    while abs(b - a) > eps
        if fl < fr
            b = r
            r = l
            l = a + (1 - gr) * (b - a)
            fr = fl
            fl = f(l)
        else
            a = l
            l = r
            r = a + gr * (b - a)
            fl = fr
            fr = f(r)
        end
    end
    return (a + b) / 2
end

function gradient_descent(f, x, max_steps, eps)

    grad(x) = ForwardDiff.gradient(f, x)
    k = 0
    while norm(grad(x)) > eps && k < max_steps
        d = -grad(x)
        g(l) = f(x + l * d)
        step = golden_section(g, 0, 1, 1e-5)
        x = x + step * d
        k += 1
    end

    return x
end

println(gradient_descent(f, [10, 10], 1000, 1e-10))
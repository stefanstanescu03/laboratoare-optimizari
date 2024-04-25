using ForwardDiff
using LinearAlgebra

f(x) = x[1] - x[2] + 2 * x[1]^2 + 2 * x[1] * x[2] + x[2]^2

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

function fletcher_reeves(f, x, max_steps, eps)
    grad(x) = ForwardDiff.gradient(f, x)
    d = -grad(x)
    g1(l) = f(x + l * d)
    l = golden_section(g1, -10, 10, 1e-5)
    x1 = x
    x2 = x1 + l * d
    k = 1
    println("pas ", k, ": ", l, " ", d, " ", x2)
    while norm(grad(x2)) > eps && k < max_steps
        k += 1
        d = -grad(x2) + norm(grad(x2))^2 / norm(grad(x1))^2 * d
        g(l) = f(x2 + l * d)
        l = golden_section(g, -10, 10, 1e-5)
        x1 = x2
        x2 = x1 + l * d
        println("pas ", k, ": ", l, " ", d, " ", x2)
    end

    return x2
end

println(fletcher_reeves(f, [0, 0], 1000, 0.1))
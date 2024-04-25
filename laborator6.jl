using ForwardDiff
using LinearAlgebra

f(x) = x[1] - x[2] + 2 * x[1]^2 + 2 * x[1] * x[2] + x[2]^2

function gs(f, a, b, eps)
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

function DFP(f, x, eps)
    # D = Matrix(1.0I, length(x), length(x))
    D = I(length(x))

    grad(x) = ForwardDiff.gradient(f, x)

    grad_ant = grad(x)
    grad_curr = grad(x)

    d = -D * grad_ant

    g(l) = f(x + l * d)
    l = gs(g, -10, 10, 1e-4)

    x = x + l * d

    while norm(grad_ant) > eps

        grad_curr = grad(x)

        p = l * d
        q = grad_curr - grad_ant

        D = D + (p * p') / (p' * q) - (D * q * q' * D) / (q' * D * q)
        d = -D * grad_curr

        g(l) = f(x + l * d)
        l = gs(g, -10, 10, 1e-4)

        x = x + l * d

        grad_ant = grad_curr
    end

    return x
end

println(DFP(f, [0, 0], 0.01))
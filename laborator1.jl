function f(x)
    return x^4 - 14 * x^3 + 60 * x^2 - 70 * x
end

function find_min(f, a, b, eps)
    d = 1e-10
    while abs(b - a) > eps
        l = (a + b) / 2 - d
        r = (a + b) / 2 + d
        if f(l) < f(r)
            b = r
        else
            a = l
        end
    end
    return f((a + b) / 2)
end

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
    return f((a + b) / 2)
end

println(find_min(f, 0, 2, 1e-4))
println(golden_section(f, 0, 2, 1e-4))
function f1(x)
    return x^2 + x + 1
end

function f2(x)
    return x^4 + x^3 + 5 * x^2 + x + 2
end

function f3(x)
    return 5 * x^2 + x + 16
end

function f4(x)
    return sin(x) - cos(x)
end

function f5(x)
    return exp(x) - cos(x) - 5 * sin(x)
end

function f6(x)
    return x^2 - x * cos(x)
end

function fibonacci_search(f, a, b, eps)
    fib = Int[]
    n = 2
    append!(fib, 1)
    append!(fib, 1)
    while fib[n] < (b - a) / eps
        n += 1
        append!(fib, fib[n-1] + fib[n-2])
    end

    l = a + fib[n-2] / fib[n] * (b - a)
    u = a + fib[n-1] / fib[n] * (b - a)

    fl = f(l)
    fu = f(u)

    l_prev = -1
    a_prev = -1
    b_prev = -1

    for k = 1:n-2

        l_prev = l
        a_prev = a
        b_prev = b

        if fl >= fu
            a = l
            l = u
            u = a + fib[n-k-1] / fib[n-k] * (b - a)
            fl = fu
            fu = f(u)
        else
            b = u
            u = l
            l = a + fib[n-k-2] / fib[n-k] * (b - a)
            fu = fl
            fl = f(l)
        end
    end

    l = l_prev
    u = l + eps
    if fl > fu
        a = l
        b = b_prev
    else
        a = a_prev
        b = l
    end

    return (a + b) / 2

end

x_min = fibonacci_search(f1, -3, 3, 1e-10)
println(x_min, ' ', f1(x_min))
x_min = fibonacci_search(f2, -3, 3, 1e-10)
println(x_min, ' ', f2(x_min))
x_min = fibonacci_search(f3, -4, 4, 1e-10)
println(x_min, ' ', f3(x_min))
x_min = fibonacci_search(f4, -2, 2, 1e-10)
println(x_min, ' ', f4(x_min))
x_min = fibonacci_search(f5, -7, -3, 1e-10)
println(x_min, ' ', f5(x_min))
x_min = fibonacci_search(f6, -3, 4, 1e-4)
println(x_min, ' ', f6(x_min))
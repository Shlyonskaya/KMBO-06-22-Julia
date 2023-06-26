1.
#Алгоритм быстрого возведения в степень
function myfastpow(a, n)
    k=n
    p=a
    t=1
 
    while k>0
        if iseven(k)
            k /= 2 
            p *= p
        else
            k -= 1 
            t *= p 
        end
    end
    return t
end

print(myfastpow(5,14))

2.
#n-й член Фибоначчи возвдением матрицы в степень
function FibMat(n)
    m = [1 1; 1 0]
    m = myfastpow(m,n)
    return m[1,1]
end

print(FibMat(9))

3.
#Считаем log(a,b) с погрешностью Eps

# log[1/a] x = - log[a] x
function log(a0, x, epsilon)
    a = a0; flag  = false
    if a < 1.0
        a = 1.0 / a
        flag = true
    end
    y = 0.0; z = x; t = 1.0;
    while abs(t) > epsilon || z < 1.0 / a || z > a
        # инвариант a^y * z^t == x
        if z > a
            z /= a
            y += t
        elseif  z < 1.0 / a
            z *= a
            y -= t
        else
            z *= z
            t /= 2.0
        end
    end

    return (flag) ? -y : y
end

print(log(0.2,15.67,1e-8))

4.
#Поиск решения уравнения f(x) = 0 методом деления отрезка пополам
function bisection(f::Function, a, b, epsilon)
    f_a = f(a)
    while (b - a > epsilon)
        t = (a + b)/2
        f_t = f(t)
        if (f_t == 0)
            return t
        elseif (f_t * f_a < 0)
            b = t
        else
            a, f_a = t, f_t
        end
    end
    return (a+b) / 2
end

#f(x)=0
function f(x)
    return x * x - 3 * x
end

print(bisection(f, -1, 2, 0.01))

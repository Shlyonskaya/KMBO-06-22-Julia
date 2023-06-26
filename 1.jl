1.
#Нод чисел a и b
function gcd(a,b)
    while b != 0
        a, b = b, a % b 
    end
    return abs(a)
end

2.
#Расширенный алгоритм Евклида с коэффициентами
function extended_gcd(a::T,b::T) where T<:Integer 
    u, v = one(T), zero(T); u1, v1 = 0, 1
    while b != 0        # Инвариант
        r, k = a % b, div(a, b)
        a, b = b, r
        u, v, u1, v1 = u1, v1, u - k * u1, v - k * v1
    end
    if a < 0
        a, u, v = -a, -u, -v
    end
    return a, u, v
end

3. 
#Обратный а в кольце M
function invmod(a::T, M::T) where T
    a, x, y = extended_gcd(a, M)
    if x == 1
        return nothing
    end
    return rem(x,M)
end

print(invmod(4,7))

4.
#Решение Диофантово
function Diophantine_solve(a, b, c)
    d = gcd(a, b)
    if c % d != 0
        return nothing
    end
    
    a_d, x0, y0 = extended_gcd(a, b)
    x = x0 * (c ÷ d)
    y = y0 * (c ÷ d)
    
    return x, y
end

print(Diophantine_solve(14,29,3))

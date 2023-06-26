1.
#Является ли число n простым
function isPrime(n)

    for i in 2:sqrt(n)
        if n % i == 0
            return false
        end
    end
    return true
end

print(isPrime(103))

2.
#Решето Эратосфена
function resheto(n::Integer)
    prime_indexes = ones(Bool, n)
    prime_indexes[begin] = false
    i = 2
    prime_indexes[i^2:i:n] .= false 
    i = 3
   
    while i <= n
        prime_indexes[i^2:2i:n] .= false
        i+=1
        while i <= n && prime_indexes[i] == false
            i+=1
        end

    end
    return findall(prime_indexes)
end

print(resheto(200))

3.
#Факторизаиця
function factorize(n::IntType) where IntType <: Integer
    list = NamedTuple{(:div, :deg), Tuple{IntType, IntType}}[]
    for p in resheto(Int(ceil(n/2)))
        k = degree(n, p) 
        if k > 0
            push!(list, (div=p, deg=k))
        end
    end
    return list
end

function degree(n, p) 
    k=0
    n, r = divrem(n,p)
    while n > 0 && r == 0
        k += 1
        n, r = divrem(n,p)
    end
    return k
end

print(factorize(420))

4.
# Средне квадратическое отклонение
function mean_mass(mass)
    T = eltype(mass)    # определяем тип элементов массива mass
    n = 0; s1 = zero(T); s2 = zero(T)
    for a ∈ mass
        n += 1; s1 .+= a; s2 += a*a
    end
    mean = s1 ./ n
    return mean, sqrt(s2/n - mean*mean)
end

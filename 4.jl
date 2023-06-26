1.
# Тейлор для экспоненты
function taylor_exp(n::Int64, x::T) where T
    a0 = one(T)
    res = a0
    for i in 1:n-1
        a0 *= x / (i+1)
        res += a0
    end
    return res

end

println( taylor_exp(20, 0.5))

2.
# Вычисление машинной точности
function machine_precision()
    eps = Float64(0.5)^52
    while (1.0 + eps) > 1.0
        eps /= 2.0
    end
    return eps
end

println(machine_precision())

3.
# Построение функций Бесселя
using Plots
function bessel(M::Integer, x::Real)
    sqrx = x*x
    a = 1/factorial(M)
    m = 1
    s = 0 
    
    while s + a != s
        s += a
        a = -a * sqrx /(m*(M+m)*4)
        m += 1
    end
    
    return s*(x/2)^M
end

values = 0:0.1:20
myPlot = plot()
for m in 0:5
	plot!(myPlot, values, bessel.(m, values))
end
display(myPlot)

4.
#4 Обратный ход Жордана-Гаусса
using LinearAlgebra
function gaussian_elimination(A::AbstractMatrix{T}, b::AbstractVector{T})::AbstractVector{T} where T
    @assert size(A, 1) == size(A, 2)
    n = size(A, 1) 
    x = zeros(T, n)

    for i in n:-1:1
        x[i] = b[i]
        for j in i+1:n
            x[i] =fma(-x[j] ,A[i,j] , x[i])
        end
        x[i] /= A[i,i]
    end
    return x
end

5.
#Приведение матрицы к ступеньчатому виду
function TransformToSteps!(matrix::AbstractMatrix, epsilon::Real = 1e-7)::AbstractMatrix
	@inbounds for k ∈ 1:size(matrix, 1)
		absval, Δk = findmax(abs, @view(matrix[k:end,k]))

		(absval <= epsilon) && throw("Вырожденая матрица")

		Δk > 1 && swap!(@view(matrix[k,k:end]), @view(matrix[k+Δk-1,k:end]))

		for i ∈ k+1:size(matrix,1)
			t = matrix[i,k]/matrix[k,k]
			@. @views matrix[i,k:end] = matrix[i,k:end] - t * matrix[k,k:end]  
		end
	end
	return matrix
end

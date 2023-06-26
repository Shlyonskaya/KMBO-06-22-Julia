1.
# Сортировка вставками O(n^2)
function insert_sort!(array::AbstractVector{T})::AbstractVector{T} where T <: Number
    n = 1
    # Инвариант: срез array[1:n] - отсортирован

    while n < length(array) 
        n += 1
        i = n

        while i > 1 && array[i-1] > array[i]
            array[i], array[i-1] = array[i-1], array[i]
            i -= 1
        end

        # Утверждение: array[1] <= ... <= array[n]
    end

    return array
end

insert_sort(array::AbstractVector)::AbstractVector = insert_sort!(copy(array))

2.
# Сортировка расчёской
function rascheska(arr)
    step = length(arr)
    shrink = 1.247
   while step >=1 
        for i in 1:length(arr) - step
            if arr[i] > arr[i+step]
                arr[i], arr[i+step] = arr[i+step], arr[i]
            end
        end
        step = Int(floor(step/shrink))
   end
    return arr
end

arr = [2, 1, 5, 4, 3, 2, 7, 2, 8, 9]
print(rascheska(arr))

3.
# Сортировка Шелла

# Сравнение с рекурсией
function compare!(arr, i, g)
    if i < 0 || g < 0 
        return;
    end
    if arr[i] > arr[g]
        arr[i], arr[g] = arr[g], arr[i]
        compare!(arr, i, 2i - g)
    end
end

function shell_sort!(arr)
    len = length(arr)   
    step = div(len, 2)          

    while step >= 1
        for i in 1:len - step       
            compare!(arr,i,i + step)
        end
        step = div(step, 2)
    end
    return arr
end

arr = [1, 1, 5, 4, 3, 2, 7, 2, 8, 9]    
print(shell_sort!(arr))

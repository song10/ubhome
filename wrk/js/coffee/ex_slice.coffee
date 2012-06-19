numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9]

start   = numbers[0..2]

middle  = numbers[3...6]

end     = numbers[6..]

copy    = numbers[..]

numbers[3..6] = [-3, -4, -5, -6]

print start
print middle
print end
print copy
print numbers

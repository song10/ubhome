square = (x) -> x * x
cube = (x=5) -> square(x) * x

print = console.log

print square 3
print cube 4
print cube()
print square 6

from timeit import timeit

file_path = 'input/day1.txt'

file = open(file_path, 'r')
def score():
  lines = file.read().splitlines()
  touples = map(lambda x: x.split('   '), lines)
  int_touples = map(lambda x: (int(x[0]), int(x[1])), touples)
  split = zip(*int_touples)
  sort = map(lambda x: sorted(x), split)
  traverse = zip(*sort)
  subtract = map(lambda x: abs(x[0]-x[1]), traverse)
  print(sum(subtract))

print(timeit('score()', number=1, globals=globals()))

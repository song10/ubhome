// Generated by CoffeeScript 1.3.3
(function() {
  var cube, print, square;

  square = function(x) {
    return x * x;
  };

  cube = function(x) {
    if (x == null) {
      x = 5;
    }
    return square(x) * x;
  };

  print = console.log;

  print(square(3));

  print(cube(4));

  print(cube);

  print(square(6));

}).call(this);

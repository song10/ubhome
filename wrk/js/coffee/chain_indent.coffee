fn = (x) ->
    print "# #{x} #"
    this

fn2 = (x) ->
    print "* #{x} *"
    this

a =
    b:
      d: fn2
      e: fn2
    c: fn
    f: fn

a
    .b
        .d("d")
        .e("e")

a.b
    .d("d")
    .e("e")

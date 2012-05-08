fn = function (x) { console.log(x); };
var a = {
    'b': {
        'd': fn,
        'e': fu
    },
    'c': fn
};

a
    .b
        .d('d')
        .e('e')
    .c('c');

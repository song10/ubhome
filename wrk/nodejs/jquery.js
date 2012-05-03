print = console.log;

function $(x) {
    if ("string" == typeof(x))
        return print(x);
    else if ("function" == typeof(x))
        return x();

    return;
}

$("hello, world!");
$(function () { print("hola, beaty~"); });

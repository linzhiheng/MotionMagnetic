%Main
clear
clc

as1 = as1();
as1.a1 = 111;
as1.show();

as2 = as2();
as2.a1 = 222;
as2.show();
clc
b = b(as1);
clc
testInput = [1,2];
b.function1(testInput, 3, 4);
f2 = b.function2(5, 3);
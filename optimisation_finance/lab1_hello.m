clear, clc
% AerE 160, Fall 2015, Lab 1-Demo
% Matthew E. Nelson
% My first program in MATLAB, Hello World!
disp(' Hello, World! ');
%---------------------------------
clear, clc
% AerE 160, Fall 2015, Lab 1-Demo
% Matthew E. Nelson
% User Input
% See if the students can catch the error
Name = input(' Enter your Name in single quotes: ');
disp('Hello!')
% make a mistake on purpose: use name instead of Name
disp(name) 
%--------------------------
clear, clc
% AerE 160, Fall 2015, Lab 1-Demo
% Matthew E. Nelson
% putting it all together
Name = input(' Enter your Name in single quotes: ');
fprintf('Hello, %s !', Name)
%% MATLAB Basics
%% Four arithmetical operations
% You can perform addition by +, subtraction by -, multiplication by
% * and division by /. For example,
%%
1+2
1-2
1*2
1/2
%% Substition
% You can substitute a number to a variable by
%%
a=3
%%
% If you put ; at the end of the sentence, the result will not appear in the command window.
%%
a=3;
%% Vector and matrix
% A row vector is made by
%%
b = [1 2]
%%
% By putting ', a row vector is transposed into a column vector.
%%
b = [1 2]'
%%
% A column vector is also made by
%%
b = [1;2]
%%
% you can make a row vector in which its elements increase from 1 to 10 by
%%
b = [1:10]
%%
% The degree of increment is specified as
b = [1:2:9]
%%
% A 2x2 matrix is given for example
c = [1 2;0 3]
%%
% and we obtain the transposed matrix by
c'
%%
% Matrix multiplication is done by
b = [1;2];
c*b
%%
% and to take factorial,
c = [1:5].^2
%%
%% Other useful commands
% The following commands are often used:
% To create a n-by-m matrix filled with zeros
n=2;
m=3;
zeros(n,m)
%%
% To create a n-by-m matrix filled with ones
ones(n,m)
%%
% To create a n-by-n diagonal matrix with ones
n=2;
eye(n)
%%
% To take the inverse of the square matrix
c = [1 2;0 3]
inv(c)
%%
% To clear a variable from memory
clear a;
%%
% To clear all the variables from memory
clear all;
%%
% To calculate the mean of x
x = [1 2 3 4 5];
mean(x)
%%
% To calculate the standard deviation of x
%%
std(x)
%%
% To calculate the variance of x
var(x)
%%
% To calculate the minimum of x
min(x)
%%
% To calculate the maximum of x
max(x)
%%
% To see the help, for example
help mean
%%
%% Using m-files
% It is useful to create a m-file to execute several sentences at one time.
% For example, create the following file and save it as test.m. The part after % is regarded as comments and not executed.
%%
clear all;
c = [1 2; 0 3]; % 2x2 matrix
b = [1 2]'; % 2x1 vector
c*b
%%
% To plot a 2D figure,
figure;
x = [-10:1:10];
y = x.^2;
plot(x,y);
%%
%% For loop
% By using "for loop," we repeat increasing the number of index and executing the
% same procedure. For example,
%%
a = 0;
for i=1:5
  a = a+i
end
%%
%% While loop
% By using "while loop," we repeat the same procedure until the condition is met. 
%%
a = 0; i = 1;
while(a<15)
  a = a+i
  i = i+1;
end
%%
%% If clause
% If the condition is true, we execute a certain procedure. Otherwise, we
% do nothing or execute another procedure. For example,
%%
a = 1; b = 2;

if (a<b)
   disp('a is greater than b');
else
   disp('b is greater than or equal to a')
end
%% 
%% Displaying results
% We can display matrix or strings in a format
%%
a = [1 2];
disp(a)
%%
% which is different from 
%%
a
%%
% If we want to substitute numbers into strings,
x = 1.5;
disp(sprintf('x is equal to %1.4f',x));
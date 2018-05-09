clear all;

n = 101;
x = linspace(-5,5,n);
y = 1./(1+x.^2);

figure;
plot(x,y);
hold on;

n1 = 5;
x1 = linspace(-5,5,n1)';
y1 = 1./(1+x1.^2);

plot(x1,y1,'o','MarkerSize',10);

for i=1:n
    
    x0 = x(i);
    y0 = intf1(x1,y1,x0)
    y_int1(i) = y0;
    
end

%plot(x0,y0,'x','MarkerSize',10);
plot(x,y_int1);
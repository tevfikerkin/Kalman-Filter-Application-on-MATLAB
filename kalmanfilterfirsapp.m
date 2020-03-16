% First Kalman Filter Application
clc;
clear all;

iteration = 1:10;
x_pre = 1030;
xmin=998;
xmax=1010;
n=length(iteration);
measurement=xmin+rand(1,n)*(xmax-xmin);
%measurement=[1030,989,1017,1009,1013,979,1008,1042,1012,1011];
z = 1010 * ones(1, length(iteration));
for i=1:length(iteration)
    alfa = 1/i;
    x_next(i) = x_pre + alfa*(measurement(i)-x_pre);
    x_pre = x_next(i);
end
plot(iteration,x_next);
hold on;
plot(iteration,z,'r');
hold on;
plot(iteration,measurement,'g');
grid on;
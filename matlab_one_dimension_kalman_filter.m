% Ývmelenen bir uçak takibi için alfa,beta,gama kalman filtresi
%uçak 15 saniye boyunca 50m/s sabit hýz ile uçaktadýr. bu
... bu sürenin sonunda 8m/s^2 sabit ivmeyle 35sn uçmaktadýr. Baþlangýç irtifasý 30000m'dir.

clc;
clear all;

x_axis=5:5:55;

xTrue_0 = 30000;
vTrue_0 = 50;
aTrue_0 = 8;

t = 5;
alfa = 0.5;
beta = 0.4;
gama = 0.1;
z = [30160,30365,30890,31050,31785,32215,33130,34510,36010,37265];

for i=1:11
    if i==1
        x_1 = 30000;
        v_1 = 50;
        a_1 = 0;
    else
        %%sistem güncellemesi
        x_1(i) = x_0 + alfa * (z(i-1) - x_0);
        v_1(i) = v_0 + beta * ( ( z(i-1) - x_0 ) / t );
        a_1(i) = a_0 + gama * ( ( z(i-1) - x_0 ) / ( 0.5 * t^2 ) );
    
    end
    
  
    %% bir sonraki konum, hýz ve ivme tahmini  
    x_2(i) = x_1(i) + v_1(i) * t + a_1(i) * t^2 * 0.5; %konumun sonraki deðer için tahmini
    v_2 = v_1(i) + a_1(i) * t^2;
    a_2 = a_1(i);
    
    x_0 = x_2(i);
    v_0 = v_2;
    a_0 = a_2;
end

for n=1:10
    %% beklenen gerçek deðerler
   if n<4
       trueX(n) = xTrue_0 +vTrue_0*t;
       xTrue_0 = trueX(n);
   else
       trueV(n) = vTrue_0 + aTrue_0 * t;
       vTrue_0 = trueV(n);
       trueX(n) = xTrue_0 + vTrue_0 * t;
       xTrue_0 = trueX(n);
   end
end

plot(x_axis,x_1);
hold on;
plot(5:5:50,z,'r');
hold on;
plot(5:5:50,trueX,'g');
hold on;
plot(x_axis,x_2,'c');
grid on;
legend('Hesaplama','Ölçüm','Doðru Konum','Tahmin');


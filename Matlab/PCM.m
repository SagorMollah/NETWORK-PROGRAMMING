clc;
clear all;
close all;
n=input('Enter value for n bit PCM signal : ');
n1=input('Enter number of samples in a period : ');
L=2^n;
%Signal generation
x=0:1/100:4*pi;
y=8*sin(x);
subplot(221);
plot(x,y);
grid on;
%sampling operation
x=0:2*pi/n1:4*pi
s=8*sin(x);
subplot(311);
plot(s);
title("Analog Signal");
ylabel("Amplitude ");
xlabel("Time");
subplot(312);
stem(s);
grid on;
title("Sampled Signal");
ylabel("Amplitude");
xlabel("Time");
%Quantization process
vmax=8;
vmin=-vmax;
del=(vmax-vmin)/L;
part=vmin:del:vmax;
code=vmin-(del/2):del:vmax+(del/2);
[ind,q]=quantiz(s,part,code);
l1=length(ind);
l2=length(q);
for i=1:11
if(ind(i)~=0)
ind(i)=ind(i)-1;
end
i=i+1
end
for i=1:12
if(q(i)==vmin-(del/2))
q(i)=vmin+(del/2);
end
end
subplot(3,1,3);
stem(q);
grid on;
title('Quantized Signal');
ylabel('Amplitude');
xlabel('Time');
%Encoding process
figure(2)
code=de2bi(ind,'left-msb');
k=1;
for i=1:11
for j=1:n
coded(k)=code(i,j);
j=j+1;
k=k+1;
end
i=i+1;
end
subplot(211);
grid on;
stairs(coded);
axis([0 100 -2 3]);
title('Encoded Signal');
ylabel('Amplitude');
xlabel('Time');
%demodulation of PCM signal
qunt=reshape(coded,n,length(coded)/n);
index=bi2de(qunt','left-msb');
q=del*index+vmin+(del/2);
subplot(212);
grid on;
plot(q);
title('Demodulated Signal');
ylabel('Amplitude');
xlabel('Time');

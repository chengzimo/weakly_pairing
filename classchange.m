function [classes1]=classchange(classes,N)
n=max(classes)+1;
m=0;
for i=1:N
    m=max(classes);
end   
classes1=zeros(N,m+1);

for i=1:N
    a=classes(i,1);
    for j=1:n 
       if j-1==a
           classes1(i,j)=1;
       end
    end
end   

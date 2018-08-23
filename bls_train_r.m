function [T3,beta11,ps,wh,l2]=bls_train_r(train_x,s,N1,N2,N3)
% function [TrainingAccuracy,TestingAccuracy,Training_time,Testing_time] = bls_train(train_x,train_y,test_x,test_y,s,C,N1,N2,N3)
% Learning Process of the proposed broad learning system
%Input: 
%---train_x,test_x : the training data and learning data 
%---train_y,test_y : the label 
%---We: the randomly generated coefficients of feature nodes
%---wh:the randomly generated coefficients of enhancement nodes
%----s: the shrinkage parameter for enhancement nodes
%----C: the regularization parameter for sparse regualarization
%----N11: the number of feature nodes  per window
%----N2: the number of windows of feature nodes

%%%%%%%%%%%%%%feature nodes%%%%%%%%%%%%%%
tic
train_x = zscore(train_x')';
H1 = [train_x .1 * ones(size(train_x,1),1)];y=zeros(size(train_x,1),N2*N1);
for i=1:N2
    we=2*rand(size(train_x,2)+1,N1)-1;
    We{i}=we;
    A1 = H1 * we;A1 = mapminmax(A1);
    clear we;
beta1  =  sparse_bls(A1,H1,1e-3,50)';
beta11{i}=beta1;
% clear A1;
T1 = H1 * beta1;
% fprintf(1,'Feature nodes in window %f: Max Val of Output %f Min Val %f\n',i,max(T1(:)),min(T1(:)));

[T1,ps1]  =  mapminmax(T1',0,1);T1 = T1';
ps(i)=ps1;
% clear H1;
% y=[y T1];
y(:,N1*(i-1)+1:N1*i)=T1;
end

clear H1;
clear T1;
%%%%%%%%%%%%%enhancement nodes%%%%%%%%%%%%%%%%%%%%%%%%%%%%

H2 = [y .1 * ones(size(y,1),1)];
if N1*N2>=N3
     wh=orth(2*rand(N2*N1+1,N3)-1);
else
    wh=orth(2*rand(N2*N1+1,N3)'-1)'; 
end
T2 = H2 *wh;
l2 = max(max(T2));
l2 = s/l2;
% fprintf(1,'Enhancement nodes: Max Val of Output %f Min Val %f\n',l2,min(T2(:)));

T2 = tansig(T2 * l2);
T3=[y T2];
clear H2;clear T2;
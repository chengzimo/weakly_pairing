function [TT3]=bls_test_r(test_x,N1,N2,beta11,ps,wh,l2)
%%%%%%%%%%%%%%%%%%%%%%Testing Process%%%%%%%%%%%%%%%%%%%
test_x = zscore(test_x')';%数据标准化处理
HH1 = [test_x .1 * ones(size(test_x,1),1)];
%clear test_x;
yy1=zeros(size(test_x,1),N2*N1);
for i=1:N2
    beta1=beta11{i};ps1=ps(i);
    TT1 = HH1 * beta1;
    TT1  =  mapminmax('apply',TT1',ps1)';

clear beta1; clear ps1;
%yy1=[yy1 TT1];
yy1(:,N1*(i-1)+1:N1*i)=TT1;%测试的特征节点实际输出
end
clear TT1;clear HH1;
HH2 = [yy1 .1 * ones(size(yy1,1),1)]; 
TT2 = tansig(HH2 * wh * l2);TT3=[yy1 TT2];
clear HH2;clear wh;clear TT2;

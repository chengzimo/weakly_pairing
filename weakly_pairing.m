clc;
clear;
load featRGBD.mat
load g.mat
load isTest.mat
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
X1_trn = colorFeat(~isTest,:);
X1_tst = colorFeat(isTest,:);
X2_trn = depthFeat(~isTest,:);
X2_tst = depthFeat(isTest,:);
trainClasses = classes(~isTest,:);
testClasses = classes(isTest,:);

%  G=g(~isTest,2);%按照同一张图像打乱样本序列
G=g(~isTest,4);%按照同一个物体打乱样本序列
[X2_trn,idx1,mungroups1]=replace_feat(G,X2_trn);
%% center
[X1_trn, mu, sigma] = zscore_DL(X1_trn);
X1_tst = normalize(X1_tst, mu, sigma);
[X2_trn, mu, sigma] = zscore_DL(X2_trn);
X2_tst = normalize(X2_tst, mu, sigma);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s =.08; N1=10; N2=5;
N33=250;
% N33=[50 100 150 200 250 300 350 400 450 500];
dim=50;
r=100;
for j=1:size(N33,2)
    N3=N33(1,j);
    disp(['N3 is' num2str(N3)]);
    run bls
end
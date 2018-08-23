function [train_RGBD,test_RGBD]=blstrain(G,X1_trn,X2_trn,X1_tst,X2_tst,s,N1,N2,N3,dim,r)
[H1,b11,p1,whh1,ll1]=bls_train_r(X1_trn,s,N1,N2,N3);
[H2,b12,p2,whh2,ll2]=bls_train_r(X2_trn,s,N1,N2,N3);
[T1]=bls_test_r(X1_tst,N1,N2,b11,p1,whh1,ll1);
[T2]=bls_test_r(X2_tst,N1,N2,b12,p2,whh2,ll2);
clear b11;clear p1;clear whh1;clear ll1;
clear b12;clear p2;clear whh2;clear ll2;

[W1,W2]=cluster_CCA(H1,G,H2,G,dim,r);

H1=H1*W1;
H2=H2*W2;
T1=T1*W1;
T2=T2*W2;

train_RGBD=[H1 H2];
test_RGBD=[T1 T2];
clear H1;clear H2;
clear T1;clear T2;
clear W1;clear W2;


function [A,B]=cluster_CCA(X1,G1,X2,G2,dim,r)
% H1 and H2 are NxD matrices containing samples rowwise.
% dim is the desired dimensionality of CCA space.
% r is the regularization of autocovariance for computing the correlation.
% A and B are the transformation matrix for view 1 and view 2.
% m1 and m2 are the mean for view 1 and view 2.
% D is the vector of singular values.
rcov1=0.1; rcov2=r;
% rcov1=1; rcov2=1;
[N,d1] =size(X1);
[~,d2] =size(X2);
dim=min([N,d1,d2,dim]);
numgroups =G1(size(G1,1),:);
% Remove mean.
m1 = mean(X1,1); 
X1 = X1-repmat(m1,N,1);
m2 = mean(X2,1); X2 = X2-repmat(m2,N,1);

k1=tabulate(G1);
G1_size=k1(:,2);
k2=tabulate(G2);G2_size=k2(:,2);
G1_idx=[0;cumsum(G1_size)];
G2_idx=[0;cumsum(G2_size)];

M=sum(G1_size.*G2_size);
S11=zeros(d1,d1);
 for i=1:numgroups
            X1_sel=X1(G1_idx(i)+1:G1_idx(i+1),:)'*X1(G1_idx(i)+1:G1_idx(i+1),:);
            X1_sel=X1_sel*G2_size(i);
            S11=S11+X1_sel;
 end
S11 =S11/M+rcov1*eye(d1); 

S22=zeros(d2,d2);
 for i=1:numgroups
            X2_sel=X2(G2_idx(i)+1:G2_idx(i+1),:)'*X2(G2_idx(i)+1:G2_idx(i+1),:);
            X2_sel=X2_sel*G1_size(i);
            S22=S22+X2_sel;
 end
 S22 =S22/M+rcov2*eye(d2); 

% S12=zeros(d1,d2);
%  for i=1:numgroups
%             X1_sel=X1(G1_idx(i)+1:G1_idx(i+1),:);
%             X2_sel=X2(G2_idx(i)+1:G2_idx(i+1),:);
%             for j=1:size(X1_sel,1)
%                 for k=1:size(X2_sel,1)
%                     X12_sel=X1_sel(j,:)'*X2_sel(k,:);
%                     S12=S12+X12_sel;
%                 end
%             end
%  end
%  S12 = S12/M;

XcYc=G1_size.*G2_size;
S12=zeros(d1,d2);
for i=1:numgroups
            X1_mean=mean(X1(G1_idx(i)+1:G1_idx(i+1),:));
            X2_mean=mean(X2(G2_idx(i)+1:G2_idx(i+1),:));
            X12=XcYc(i,:)*X1_mean'*X2_mean;
            S12=S12+X12;
end
S12 = S12/M;
[V1,D1] = eig(S11); [V2,D2] = eig(S22);
% For numerical stability.
D1 = diag(D1); idx1 = find(D1>1e-12); D1 = D1(idx1); V1 = V1(:,idx1);
D2 = diag(D2); idx2 = find(D2>1e-12); D2 = D2(idx2); V2 = V2(:,idx2);

K11 = V1*diag(D1.^(-1/2))*V1';
K22 = V2*diag(D2.^(-1/2))*V2';
T = K11*S12*K22;
[U,~,V] = svd(T,0);
A = K11*U(:,1:dim);
B = K22*V(:,1:dim);


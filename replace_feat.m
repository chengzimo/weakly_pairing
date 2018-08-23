function [Feat1,idx,G]=replace_feat(g,Feat)
G=1;
for i=2:size(g,1)
    if g(i,1)==g(i-1,1)
        G=[G;G(i-1,:)];
    else
        G=[G;G(i-1,:)+1];
    end
end
k=tabulate(G);
k=k(:,2);
 n=size(unique(G),1);
idx=[];
 for i=1:n
    p=randperm(k(i));
    curidx=p+length(idx);
    idx=[idx curidx];
 end
Feat1=Feat(idx(:,:),:);
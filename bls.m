tic
[train_RGBD,test_RGBD]=blstrain(G,X1_trn,X2_trn,X1_tst,X2_tst,s,N1,N2,N3,dim,r);
[train_y]=classchange(trainClasses,6415);
[test_y]=classchange(testClasses,1604);
[TrainingAccuracy,TestingAccuracy,Training_time,Testing_time] = bls_train(train_RGBD,train_y,test_RGBD,test_y,0.08,2^-30,10,5,250);
clear train_RGBD;clear test_RGBD;
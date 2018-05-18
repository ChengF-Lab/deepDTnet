addpath(genpath('../../DNGR'));


Kstep = 3;
alpha = 0.98;

dim = 732;
% dim = 1915;
data=load('../../data/drugsim1network.txt');
[m,n]=size(data);

BuildNets;                          %Build Nerual Networks
rep_sim1_drug = DNGR(data, sae, opts, nnsize, Kstep, alpha);  %Run DNGR Algorithm

save('../../feature/rep_sim1_drug.mat','rep_sim1_drug'); 
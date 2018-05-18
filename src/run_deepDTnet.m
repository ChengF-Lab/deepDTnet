clear;
clc
dim_drug = 100;
dim_prot = 400;
dim_imc = 200;

% matrix:732*1915
interaction = load('../data/drugProtein.txt');

% load embedding features
load('../feature/rep_drug_drug.mat');
load('../feature/rep_sim1_drug.mat');
load('../feature/rep_sim2_drug.mat');
load('../feature/rep_sim3_drug.mat');
load('../feature/rep_sim4_drug.mat');
load('../feature/rep_sim5_drug.mat');
load('../feature/rep_sim6_drug.mat');
load('../feature/rep_p_p.mat');
load('../feature/rep_sim1_protein.mat');
load('../feature/rep_sim2_protein.mat');
load('../feature/rep_sim3_protein.mat');
load('../feature/rep_sim4_protein.mat');
load('../feature/rep_protein_disease.mat');
load('../feature/rep_drug_disease.mat');
load('../feature/rep_drug_se.mat');

prot_feat=[rep_p_p,rep_protein_disease,rep_sim1_protein,rep_sim2_protein,rep_sim3_protein,rep_sim4_protein];
drug_feat=[rep_drug_drug,rep_drug_disease,rep_drug_se,rep_sim1_drug,rep_sim2_drug,rep_sim3_drug,rep_sim4_drug,rep_sim5_drug,rep_sim6_drug];

% feature normalization
for i=1:size(drug_feat,2)
    if (norm(drug_feat(:,i)) > 0)
        drug_feat(:,i) = drug_feat(:,i)/norm(drug_feat(:,i));
    end
end
for i=1:size(prot_feat,2)
    if (norm(prot_feat(:,i)) > 0)
        prot_feat(:,i) = prot_feat(:,i)/norm(prot_feat(:,i));
    end
end


nFold = 5;
Nrepeat = 1;


AUROC = zeros(Nrepeat, 1);
AUPRC = zeros(Nrepeat, 1);

for p = 1 : Nrepeat
    fprintf('Repetition #%d\n', p);
    [AUROC(p), AUPRC(p)] = PUMC(p, nFold, interaction, drug_feat, prot_feat, dim_imc);
end

for i = 1 : Nrepeat
	fprintf('Repetition #%d: AUROC=%.6f, AUPR=%.6f\n', i, AUROC(i), AUPRC(i));
end
fprintf('Mean: AUROC=%.6f, AUPR=%.6f\n', mean(AUROC), mean(AUPRC));
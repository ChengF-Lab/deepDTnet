function [roc_avg, pr_avg] = PUMC(seed, nFold, interaction, drug_feat, prot_feat, dim_imc)
    lambda=0.01;
    alpha=0.03;
	rng(seed);
	Pint = find(interaction); % pair of interaction
	Nint = length(Pint);
	Pnoint = find(~interaction);
    Pnoint = Pnoint(randperm(length(Pnoint), Nint * 1));
	Nnoint = length(Pnoint);

	posFilt = crossvalind('Kfold', Nint, nFold);
	negFilt = crossvalind('Kfold', Nnoint, nFold);

	AUROC = zeros(nFold, 1);
	AUPRC = zeros(nFold, 1);

    for foldID = 1 : nFold
		train_posIdx = Pint(posFilt ~= foldID);
		train_negIdx = Pnoint(negFilt ~= foldID);
		train_idx = [train_posIdx; train_negIdx];
		Ytrain = [ones(length(train_posIdx), 1); zeros(length(train_negIdx), 1)];
		fprintf('Train data: %d positives, %d negatives\n', sum(Ytrain == 1), sum(Ytrain == 0));

		test_posIdx = Pint(posFilt == foldID);
		test_negIdx = Pnoint(negFilt == foldID);
		test_idx = [test_posIdx; test_negIdx];
		Ytest = [ones(length(test_posIdx), 1); zeros(length(test_negIdx), 1)];		
		fprintf('Test data: %d positives, %d negatives\n', sum(Ytest == 1), sum(Ytest == 0));

		[I, J] = ind2sub(size(interaction), train_idx);
		Xtrain = sparse(I, J, Ytrain, size(interaction, 1), size(interaction, 2));
        [W,H ,~] = imf_train(sparse(double(Xtrain)), sparse(double(drug_feat)), sparse(double(prot_feat)),  ['-n 16 -t 15 -T 5 -g 20 -p 3 -a 0 -s 10 -k ', num2str(dim_imc), ' -l ', num2str(lambda),  ' -r ', num2str(alpha)]);
	    Zscore = drug_feat * W * H' * prot_feat';
		Ypred = Zscore(test_idx);

        [trainroc, trainpr] = auc(Ytrain, Zscore(train_idx), 1e-6);
		[testroc, testpr] = auc(Ytest, Ypred, 1e-6);
		AUROC(foldID) = testroc;
		AUPRC(foldID) = testpr;
		fprintf('Fold %d, Train: AUROC=%f AUPR=%f; Test: AUROC=%f, AUPR=%f\n', foldID, trainroc, trainpr, testroc, testpr);
   end
	roc_avg = mean(AUROC);
    pr_avg = mean(AUPRC);
end

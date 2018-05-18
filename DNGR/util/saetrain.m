function sae = saetrain(sae, x, opts)
    % 输入一个自编码结构，input x，和opt参数
    for i = 1 : numel(sae.ae);
        disp(['Training AE ' num2str(i) '/' num2str(numel(sae.ae))]);
        % 自编码的第i层相当于训练一个输入输出相等的神经网络
        sae.ae{i} = nntrain(sae.ae{i}, x, x, opts);
        t = nnff(sae.ae{i}, x, x);
        x = t.a{2};
        %remove bias term
        x = x(:,2:end);
    end
end

function sae = saetrain(sae, x, opts)
    % ����һ���Ա���ṹ��input x����opt����
    for i = 1 : numel(sae.ae);
        disp(['Training AE ' num2str(i) '/' num2str(numel(sae.ae))]);
        % �Ա���ĵ�i���൱��ѵ��һ�����������ȵ�������
        sae.ae{i} = nntrain(sae.ae{i}, x, x, opts);
        t = nnff(sae.ae{i}, x, x);
        x = t.a{2};
        %remove bias term
        x = x(:,2:end);
    end
end

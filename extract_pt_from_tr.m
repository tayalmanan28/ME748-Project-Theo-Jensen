function pt_tr = extract_pt_from_tr(tr, i)
    n = size(tr,3);
    pt_tr = tr(i,:,:);
    pt_tr = reshape(pt_tr, 2, n);
end
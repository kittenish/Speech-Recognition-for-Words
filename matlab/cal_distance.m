function [data,label] = cal_distance(data, center)
    sizedata =  size(data);
    distance = zeros(90,24,20);
    if sizedata(1) < 90
        data(90,24) = 0;
    elseif sizedata(1) > 90
        data = data(1:90,1:24);
    end
    
    sumdis = zeros(1,20);
    for i = 1:20
        distance(:,:,i) = center(:,:,i) - data(:,:);
        sumdis(1,i) = sum(sum(abs(distance(:,:,i))));
    end
    labels = find(min(min(sumdis)) == sumdis);
    label = labels(1);
end
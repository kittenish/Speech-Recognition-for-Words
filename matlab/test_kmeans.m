function [origin,predict] = test_kmeans()
    global center;
    global labelmap;
    predict = zeros(1,20);
    origin = zeros(1,20);
    path = '/Users/mac/Desktop/pj/testmat/';
    folders = dir(path);
    for i= 1:1000%length(folders)
        if ~folders(i).isdir &&  ~strcmp(folders(i).name,'.') && ~strcmp(folders(i).name,'..') && ~strcmp(folders(i).name, '.DS_Store')
            data = load_data([path,folders(i).name]);
            dist = zeros(1,20);
            for j=1:20
                distance = dtw(data,center(:,:,j));
                dist(1,j) = distance;
            end
            label = find(dist == min(dist))
            labeldata = regexp(folders(i).name, '_', 'split');
            labeldata = char(labeldata(2));
            labeldata = lower(labeldata);
            labeldata = labelmap(labeldata);
            origin(1,labeldata) = origin(1,labeldata) + 1;
            if label == labeldata
                predict(1,label) = predict(1,label) + 1;
            end
        end
    end
    
end
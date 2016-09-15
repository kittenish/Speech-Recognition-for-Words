function [class,distance] = knn(c1,k)
    neighbor = zeros(5813,3);
    allclass = zeros(20);
    path = '/Users/mac/Desktop/pj/old_data/trainmat/';
    folders = dir(path);
    global labelmap;
    global translabel;
    for i= 1:5813%length(folders)
        if ~folders(i).isdir &&  ~strcmp(folders(i).name,'.') && ~strcmp(folders(i).name,'..') && ~strcmp(folders(i).name, '.DS_Store')
            %fprintf('%.0f ',i);
            data = load_data([path,folders(i).name]);
            dist = dtw(data,c1);
            labeldata = regexp(folders(i).name, '_', 'split');
            labeldata = char(labeldata(2));
            labeldata = lower(labeldata);
            labeldata = labelmap(labeldata);
            %fprintf('---');
           
            neighbor(i,:) = [dist,labeldata,i];
        end
    end
    distance = sortrows(neighbor,1);
    away = 1;
    while distance(away,1) == 0        
        away = away + 1;
    end
    distance = distance(away:away + k,:);
    for i = 1:k         
         allclass(distance(i,2),1) = allclass(distance(i,2),1) + 1;
    end
    class = 1;
    for i = 1:20
        if allclass(i,1) > allclass(class,1)
            class = i;
        end
    end
    class = translabel(class);
end
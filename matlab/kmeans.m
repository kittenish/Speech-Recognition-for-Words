function [center] = kmeans(accuracy, N, maxtime)
    %center 为60*24*N 的矩阵，每一个聚类中心是 60*24 的矩阵
    %norm 函数 ：sum(abs(X).^p,2).^(1/p) （被称作第p范式）
    %testmat 共 2660 个
    
    [center] = Init_center(N);
    
    times = 0;
    while 1
        times = times + 1;
        pre_center = center;
        diff = zeros(90,24,N);
        path = '/Users/mac/Desktop/pj/old_data/trainmat/';
        folders = dir(path);
        num = zeros(1,20);
        for i= 1:length(folders)
            if ~folders(i).isdir &&  ~strcmp(folders(i).name,'.') && ~strcmp(folders(i).name,'..') && ~strcmp(folders(i).name, '.DS_Store')    
                data = load_data([path,folders(i).name]);
                [data,label] = cal_distance(data, pre_center);
                diff(:,:,label) = diff(:,:,label) + data(:,:);
                num(1,label) = num(1,label) + 1;
                %fprintf('%.0f \n',label);
            end
        end
        
        flag = 0;
        for i = 1:20
            if num(1,i) == 0
                flag = 1;
                break;
            else
                center(:,:,i) = diff(:,:,i) ./ num(1,i);
                if norm(pre_center(:,:,i) - center(:,:,i)) > accuracy && times < maxtime
                    flag = 1;
                    %if i == 5
                        n = norm(pre_center(:,:,i) - center(:,:,i));
                        fprintf('%.5f \n', i);
                    %end
                end
            end
        end
        if flag == 0
            fprintf('%.0f \n',times);
            return;
        else
            fprintf('-----%.0f \n',times);
        end
    end
end

%在每一维的数据范围内（求出最大最小值），随机确定聚类中心
function [i_center] = Init_center(N)
    i_center = load('/Users/mac/Desktop/pj/coefficient/center.mat');
    i_center = i_center.center;
     global labelmap;
     global avg_time;
%     %一共为60*12维，数据为trainmat里面全部数据
%     i_center = zeros(60,24,N);
%     maxdata = zeros(24);
%     mindata = ones(24)*1000;
%    hang = zeros(20);
%      hang = 0;
%     path = '/Users/mac/Desktop/pj/femalemat/';
%     folders = dir(path);
%     for i= 1:length(folders)
%         if ~folders(i).isdir &&  ~strcmp(folders(i).name,'.') && ~strcmp(folders(i).name,'..') && ~strcmp(folders(i).name, '.DS_Store')
%             data = load_data([path,folders(i).name]);
% %            fprintf('%s  \n',path,folders(i).name);
%             %计算train_avg_time             
%             sizedata = size(data);           
%             labeldata = regexp(folders(i).name, '_', 'split');
%             labeldata = char(labeldata(2));
%             labeldata = lower(labeldata);
%             labeldata = labelmap(labeldata);
%              %fprintf('%s \n',labeldata);
% %              hang(labeldata,1) = hang(labeldata,1) + sizedata(1);
% %              hang(labeldata,2) = hang(labeldata,2) + 1;
%             
% %            if sizedata(1) < avg_time(labeldata,3)*0.6 || sizedata(1) > avg_time(labeldata,3)*1.5
%             if sizedata(1) > 100
%                   percent = sizedata(1) / 100;
%                   after_mfcc = data(1:percent:end,:);
%                   filesave = ['/Users/mac/Desktop/pj/femalemat/', folders(i).name(1:length(folders(i).name) - 4), '.mat'];
% %                 fprintf('pathth: %s  %.5g  %.5g\n',[path, folders(i).name],sizedata(1),avg_time(labeldata,3));
% %                  delete([path,folders(i).name]);
%                     save(filesave,'after_mfcc');
%                   hang = hang + 1;
%            end
%         end
%     end
% %            
%            data = load_data([path,folders(i).name]);
%             for j = 1:24
%                 maxdata(j,1) = max(maxdata(j,1), max(data(:,j)));
%                 mindata(j,1) = min(mindata(j,1), min(data(:,j)));
%             end
%         end
%     end
%     
%     for i = 1:N
%         for j = 1:60
%             for k = 1:24
%             i_center(j,k,i) = mindata(k,1) + (maxdata(k,1) - mindata(k,1)) * rand();
%             end
%         end
%     end
end
function get_character(path)
    
    folders = dir(path);
    % 前三个不是'.', '..', '.DS_Store'.
    for i= 1:length(folders)
        if folders(i).isdir && ~strcmp(folders(i).name,'.') && ~strcmp(folders(i).name,'..') && ~strcmp(folders(i).name, '.DS_Store')
            %fprintf('pathth: %s \n',[path,folders(i).name]);
            get_character([path,folders(i).name,'/']);
        elseif ~folders(i).isdir &&  ~strcmp(folders(i).name,'.') && ~strcmp(folders(i).name,'..') && ~strcmp(folders(i).name, '.DS_Store')
            fprintf('path: %s \n',[path,folders(i).name]);
            file = [path,folders(i).name];
            %fprintf(file);
            [sample,fs] = audioread(file);
            after_find = find_speech(sample,fs);
            after_mfcc = mfcc(after_find,fs);
            sizedata = size(after_mfcc);
            if sizedata(1) > 90
                percent = sizedata(1) / 90 ;
                after_mfcc = after_mfcc(1:percent:end,:);
            else
                after_mfcc(90,24) = 0;
            end
            filesave = ['/Users/mac/Desktop/pj/more_test/', path + folders(i).name(1:length(folders(i).name) - 4), '.mat'];
            %fprintf('%s\n',filesave);
            save(filesave,'after_mfcc');
        end
    end

    %fprintf(file);
    %[sample,fs] = audioread(file);
    %after_find = find_speech(sample,fs);

    %after_mfcc = mfcc(after_find,fs);

    %filesave = '/Users/mac/Desktop/pj/mat/12307130178_Voice_01';
    %save(filesave,'after_mfcc');

end
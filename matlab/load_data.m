function data = load_data(path)
    
    %load 得到的为1*1的struct
    data = load(path);
    data= data.after_mfcc;
end
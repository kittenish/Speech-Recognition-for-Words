
% 运行平台：Mac OSX，MATLAB R2014b
% 录音录2秒钟
Time = 2;

% 输入你的学号
Id = '14307130345';

% 输入你录的单词名
Word = '商行_2';

FS = 8000;
nBits = 16;
recObj = audiorecorder(FS, nBits, 1);
disp('Start speaking.')
recordblocking(recObj, Time);
disp('End of Recording.');

myRecording = getaudiodata(recObj);

filename = strcat(Id, '_');
filename = strcat(filename, Word);
filename = strcat(filename, '_');
filename = strcat(filename, datestr(now, 30));
filename = strcat(filename, '.wav');
filename = strcat('more_data/',filename);
audiowrite(filename, myRecording, FS)

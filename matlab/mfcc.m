function ccc = mfcc(sample, fs)
    %fprintf('%s\n',path);
    %静态特征提取
    bank=melbankm(24,256,fs,0,0.4,'t');%Mel滤波器的阶数为24，fft变换的长度为256，采样频率为16000Hz

    %归一化mel滤波器组系数（来自网络）
    bank=full(bank);
    bank=bank/max(bank(:));
    for k=1:12
        n=0:23;
        dctcoef(k,:)=cos((2*n+1)*k*pi/(2*24));
    end
    
    w=1+6*sin(pi*[1:12] ./12);   
    w=w/max(w);
    
    %预加重处理
    x=double(sample);
    x=filter([1-0.9375],1,x);
    
    %分帧，加汉明窗
    x=enframe(x,hamming(256),80);
    
    %计算每帧的MFCC参数
    for i=1:size(x,1)
        y=x(i,:);
        %fft
        t=abs(fft(y'));
        %能量谱
        t=t.^2;
        %Mel滤波器滤波,取倒数
        %c1=log(bank*t(1:129));
        %dct 离散余弦变换
%         c1 = dct(c1);
%         [c2,ind] = sort(abs(c1),'descend');
%         %idct 反离散余弦变换
%         ccc(i,:)=idct(c2(1:12,:));
        %ccc(i,:)=c2(1:12,:);
        c1=dctcoef*log(bank*t(1:129));
        c2=c1.*w';   
        m(i,:)=c2';  
       
        %差分参数   
        dtm=zeros(size(m));   
        for i=3:size(m,1)-2   
            dtm(i,:)=-2*m(i-2,:)-m(i-1,:)+m(i+1,:)+2*m(i+2,:);   

        end   
        dtm=dtm/3;   

        %合并mfcc参数和一阶差分mfcc参数   

        ccc=[m dtm];  
        %去除首位两帧，因为这两帧的一阶差分参数为0   

        ccc=ccc(3:size(m,1)-2,:);
        
        %ccc=ccc(:,1);
    end

%  subplot(2,1,1) 
%  ccc_1=ccc(:,1);
%  plot(ccc_1);title('MFCC');ylabel('幅值');
%  [h,w]=size(ccc);
%  A=size(ccc);
%  subplot(212) 
%  plot([1,w],A);
%  xlabel('维数');
%  ylabel('幅值');
%  title('维数与幅值的关系')
end
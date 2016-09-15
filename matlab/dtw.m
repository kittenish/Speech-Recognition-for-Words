function dist = dtw(t,r)
    dist = 0;
    n = size(t,1);
    m = size(r,1);
%     subplot(2,1,1)
%     plot(t(:,6));
%     subplot(2,1,2)
%     plot(r(:,6));
    
    %Ö¡Æ¥Åä¾àÀë¾ØÕó
    d = zeros(n,m,24);
    for i = 1:n
        
           temp = repmat(t(i,:),m,1);
%            fprintf('%.0f ',size(temp));
                d(i,:,:) = (temp(:,:)-r(:,:)).^2;
            
        
    end
    %ÀÛ»ý¾àÀë¾ØÕó
    D =  ones(n,m,24) * realmax;
    %for k = 1:24
        D(1,1,:) = d(1,1,:);
        %¶¯Ì¬¹æ»®
        for i = 2:n
            for j = 1:m
                D1 = D(i-1,j,:);
                if j>1
                    D2 = D(i-1,j-1,:) + d(i,j,:);
                    D3 = D(i,j-1,:);
                else
                    D2(1,1,1:24) = realmax ;
                    D3(1,1,1:24) = realmax ;
                end
                %fprintf('%.0f ',size(D2));
                Dmin(1,1,:) = min(D1(1,:),D2(1,:));
                Dmin(1,1,:) = min(Dmin(1,:),D3(1,:));
                D(i,j,:) =d(i,j,:) + Dmin(1,1,:);
            end
        end
    %end
    %global encode;
    for k = 1:24
        dist = dist + D(n,m,k);%*encode(k);
        %fprintf('%.5f --',D(n,m,k));
    end
    
   % dist = dist / (m*n);
    
end
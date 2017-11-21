Speech Recognition for Words
===========================
My Project for Digital Signal Processing and Speech Signal Analysis.  
**** 
## Data  
```
    20 label: '数字','语音','信号','分析','识别','北京','背景','上海','商行',  
              '复旦','speech','voice','sound','happy','lucky','file','open','close','start','stop'
    All data comes from fellow classmates of this class.
```    
## Code
### Matlab  
```    
    Processing raw speech signal: detect valid segment/mfcc feature   
    KNN / KMEANS
```    
### Python  
```    
    LSTM model in Keras: train/test
``` 
## Result  
```
    KNN: k = 20; accuracy: about 70%  
    KMEANS: Terrible
    LSTM:   
        Train model for male/female seperately  
        Male   : validation:91.18%  test:97.09%  
        Female : validation:94.30%  test:97.42%
 ```   

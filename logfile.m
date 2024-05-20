snapshot =

  15×5 table

     TradingVenue      BidVolumem    BidPrice    OfferPrice    OfferVolumem
    _______________    __________    ________    __________    ____________

    Trading Venue 1        16         1.453         1.54            30     
    Trading Venue 1        32         1.436        1.563            49     
    Trading Venue 1        13         1.373        1.621            28     
    Trading Venue 1        23         1.305        1.652            50     
    Trading Venue 1        37         1.298         1.71            44     
    Trading Venue 2        32         1.459        1.548            17     
    Trading Venue 2        40         1.405        1.566            19     
    Trading Venue 2        17         1.374        1.625            31     
    Trading Venue 2        39         1.334        1.682            30     
    Trading Venue 2        33         1.283        1.721            28     
    Trading Venue 3        19          1.45        1.526            23     
    Trading Venue 3        35         1.449        1.575            26     
    Trading Venue 3        36         1.385        1.632            40     
    Trading Venue 3        39         1.318        1.692            42     
    Trading Venue 3        49         1.266        1.743            44    

ktime'

ans = 

  24×1 datetime array

   27-Sep-2023 00:58:04
   27-Sep-2023 00:58:09
   27-Sep-2023 00:58:14
   27-Sep-2023 00:58:19
   27-Sep-2023 00:58:24
   27-Sep-2023 00:58:29
   27-Sep-2023 00:58:34
   27-Sep-2023 00:58:39
   27-Sep-2023 00:58:44
   27-Sep-2023 00:58:49
   27-Sep-2023 00:58:54
   27-Sep-2023 00:58:59
   27-Sep-2023 00:59:04
   27-Sep-2023 00:59:09
   27-Sep-2023 00:59:14
   27-Sep-2023 00:59:19
   27-Sep-2023 00:59:24
   27-Sep-2023 00:59:29
   27-Sep-2023 00:59:34
   27-Sep-2023 00:59:39
   27-Sep-2023 00:59:44
   27-Sep-2023 00:59:49
   27-Sep-2023 00:59:54
   27-Sep-2023 00:59:59


   orderBooks{1, 1}  

ans = 

  struct with fields:

      bids: [5×2 double]
    offers: [5×2 double]

orderBooks{1, 1}.bids

ans =

    1.5815   17.4150
    1.5630   34.8300
    1.4944   14.1497
    1.4204   25.0341
    1.4128   40.2722

orderBooks{1, 1}.offers

ans =

    1.6076   31.3170
    1.6316   51.1510
    1.6922   29.2292
    1.7245   52.1949
    1.7851   45.9316

W =

    1.5723    1.6308    1.6016         0    0.0585   17.0960
    1.5443    1.6024    1.5733         0    0.0581   17.1998
    1.5736    1.5573    1.5655    1.0000   -0.0162  -61.6151
    1.5550    1.6243    1.5896         0    0.0694   14.4159
    1.5492    1.5962    1.5727         0    0.0469   21.3001
    1.4954    1.6029    1.5492         0    0.1075    9.3044
    1.4745    1.6401    1.5573         0    0.1657    6.0365
    1.5872    1.6124    1.5998    1.0000    0.0252   39.7537
    1.4983    1.5820    1.5401         0    0.0837   11.9420
    1.5404    1.6886    1.6145         0    0.1481    6.7512
    1.5048    1.6602    1.5825         0    0.1553    6.4371
    1.5873    1.5850    1.5862    1.0000   -0.0024 -420.3156
    1.5742    1.6138    1.5940         0    0.0396   25.2487
    1.5258    1.5972    1.5615         0    0.0713   14.0240
    1.5669    1.6110    1.5889         0    0.0441   22.6802
    1.5858    1.5805    1.5831    1.0000   -0.0053 -188.1538
    1.5077    1.6222    1.5650         0    0.1145    8.7343
    1.5759    1.5653    1.5706    1.0000   -0.0106  -94.4542
    1.5302    1.6152    1.5727         0    0.0850   11.7648
    1.5489    1.6324    1.5907         0    0.0835   11.9724
    1.5861    1.6077    1.5969    1.0000    0.0216   46.2511
    1.5828    1.5872    1.5850    1.0000    0.0044  226.5298
    1.5139    1.6292    1.5716         0    0.1154    8.6672
    1.5760    1.5879    1.5819    1.0000    0.0119   84.0775

V =

  7×8 table

     VWB       VWO      VWAMP     OutlierCheck     Spread     Weighting    LiquidityCheck        SnapshotTime    
    ______    ______    ______    ____________    ________    _________    ______________    ____________________

    1.5443    1.6024    1.5733       true          0.05814     0.16786         true          27-Sep-2023 00:58:09
     1.555    1.6243    1.5896       true         0.069368     0.14069         true          27-Sep-2023 00:58:19
    1.5492    1.5962    1.5727       true         0.046948     0.20788         true          27-Sep-2023 00:58:24
    1.5048    1.6602    1.5825       true          0.15535    0.062822         true          27-Sep-2023 00:58:54
    1.5669     1.611    1.5889       true         0.044091     0.22135         true          27-Sep-2023 00:59:14
    1.5302    1.6152    1.5727       true         0.084999     0.11482         true          27-Sep-2023 00:59:34
    1.5139    1.6292    1.5716       true          0.11538    0.084587         true          27-Sep-2023 00:59:54

ICE Swap Rate (full granularity)     = 1.57877 
ICE Swap Rate (3dp for publication)  = 1.57931 
clear
clc

% Load snapshot from the pdf
% save('kk.mat',"snapshot",'-mat')
load('kk.mat');T=transformTable2struct(snapshot);

% Sample dataset of historical ICE Swap Rates
historicalRates = [1.495, 1.496, 1.497 ]; % and so on
% Define constants
PERCENTILE_LOW = 25;
PERCENTILE_HIGH = 75;
SMS = 50; % 50m

% Assuming today is the nth business day
n = length(historicalRates); % or any other day index
W=[];

% j is the number of 5 second buckets
for j=1:24;

    % simulate time
   [ktime(j), orderBooks]=load_snapshot(T,j,snapshot);

    % Create the synthetic order book
    syntheticOrderBook = createSyntheticOrderBook(orderBooks);
    syntheticOrderBook.bids;
    [filledBids, filledOffers,accumulatedBidVolume,accumulatedOfferVolume] = fillSMS(syntheticOrderBook, SMS);
    U.bids=filledBids;
    U.offers=filledOffers;


    % Define the previous day's rate
    previousDayRate = historicalRates(n-1);
    Z=calculateICESwapRate(U,previousDayRate);
    W=[W ;Z];
end

V=array2table(W);
V.Properties.VariableNames = {'VWB','VWO','VWAMP','OutlierCheck','Spread','Weighting'};

% Outliers filters
vwamps=V.VWAMP;   
lowerBound = prctile(vwamps, PERCENTILE_LOW);
upperBound = prctile(vwamps, PERCENTILE_HIGH);
vwampsOutlier = (vwamps >= lowerBound & vwamps <= upperBound);

%Liquidity outliers
V.LiquidityCheck=vwampsOutlier;
V.OutlierCheck=(V.OutlierCheck==0);
V.SnapshotTime=ktime';
idx=(V.OutlierCheck==1).*(V.LiquidityCheck==1);

% removed failled filters
V(idx==0,:)=[];

%Final results
V.Weighting=abs(V.Weighting)./sum(abs(V.Weighting));
fprintf("ICE Swap Rate (full granularity)     = %7.5f \n",mean(V.VWAMP));
fprintf("ICE Swap Rate (3dp for publication)  = %7.5f \n",sum(V.VWAMP.* V.Weighting));


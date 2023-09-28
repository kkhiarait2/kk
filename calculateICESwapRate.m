function Z = calculateICESwapRate(snapshots,previousDayRate)
% Define constants
PERCENTILE_LOW = 25;
PERCENTILE_HIGH = 75;

% ------------------------------------------------------------------------
%
% 1. Calculate VWAMP for each snapshot
% advanced matlab code vwamps = arrayfun(@(s) calculateVWAMP(s), snapshots);

numSnapshots = length(snapshots);
vwamps = zeros(1, numSnapshots); % Pre-allocate memory for efficiency
for i = 1:numSnapshots
    [vwb(i),vwo(i),vwamp(i)] = calculateVWAMP(snapshots(i));
end



% ------------------------------------------------------------------------
%
% 2. Discard illiquid or crossed/zero spread snapshots
validIndices = arrayfun(@(s) isValidSnapshot(s), snapshots);
vwampsIliquid = vwamps(validIndices);
if isempty(vwampsIliquid)
    vwampsIliquid=1;
end
% ------------------------------------------------------------------------
%
% 3. Discard outlier snapshots


vwampsOutlier = [];

% ------------------------------------------------------------------------
%
% 4. Calculate the quality-weighted ICE Swap Rate

if numel(vwamps) >= 2
    %qualityWeights = arrayfun(@(s) calculateQualityWeight(s), snapshots(validIndices));
    % Calculate VWAMP and quality weight for each valid snapshot
    for i = 1:length(validSnapshots)
        snapshot = validSnapshots(i);
        vwb = sum(snapshot.bids(:,1) .* snapshot.bids(:,2)) / sum(snapshot.bids(:,2));
        vwo = sum(snapshot.offers(:,1) .* snapshot.offers(:,2)) / sum(snapshot.offers(:,2));
        vwamp = (vwb + vwo) / 2;
        spread = vwo - vwb;
        weight = 1 / spread; % Assuming tighter spread has higher quality

        vwamps(i) = vwamp;
        qualityWeights(i) = weight;
    end

    iceSwapRate = sum(vwamps .* qualityWeights(1:size(vwamps,2)) ) / sum(qualityWeights(1:size(vwamps,2)));
else
    % 5. Use movement interpolation if not enough liquid snapshots
    iceSwapRate = interpolateMovement(previousDayRate, vwamps);
    i=1;
    vwamp = (vwb(i) + vwo(i)) / 2;
    spread(i) = vwo(i) - vwb(i);
    weight = 1 / spread(i); % Assuming tighter spread has higher quality

    vwamps(i) = vwamp;
    qualityWeights(i) = weight;
end

Z=[vwb vwo vwamp vwampsIliquid spread qualityWeights];

end



function weight = calculateQualityWeight(snapshot)
    % Calculate quality weight for a given snapshot
    vwb = sum(snapshot.bids(:,1) .* snapshot.bids(:,2)) / sum(snapshot.bids(:,2));
    vwo = sum(snapshot.offers(:,1) .* snapshot.offers(:,2)) / sum(snapshot.offers(:,2));
    spread = vwo - vwb;
    weight = 1 / spread; % Assuming tighter spread has higher quality
end
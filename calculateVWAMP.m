
function [vwb,vwo,vwamp] = calculateVWAMP(snapshot)
    % Calculate VWAMP for a given snapshot
    vwb = sum(snapshot.bids(:,1) .* snapshot.bids(:,2)) / sum(snapshot.bids(:,2));
    vwo = sum(snapshot.offers(:,1) .* snapshot.offers(:,2)) / sum(snapshot.offers(:,2));
    vwamp = (vwb + vwo) / 2;
end
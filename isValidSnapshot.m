function isValid = isValidSnapshot(snapshot)
    % Check if snapshot is valid (not illiquid or crossed/zero spread)
    isValid = ~isempty(snapshot.bids) && ~isempty(snapshot.offers) && ...
              (snapshot.offers(1,1) - snapshot.bids(1,1)) > 0;
end
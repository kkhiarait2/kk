function T=transformTable2struct(snapshot)
% bids and offers. Each of these fields is a matrix where the first column represents prices and
% the second column represents volumes.

snapshots=table2struct(snapshot(:,3:4));

oldnames = {'BidPrice','OfferPrice'};
newnames = {'bids','offers'};

for k=1:size((oldnames),2)
  T.(newnames{k}) = snapshots.(oldnames{k}) ;
end
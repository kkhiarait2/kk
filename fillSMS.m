function [filledBids, filledOffers,accumulatedBidVolume,accumulatedOfferVolume] = fillSMS(syntheticOrderBook, SMS)
% Identify price levels that cumulatively fill the Standard Market Size (SMS)
% Identify price levels and volumes that cumulatively fill the Standard Market Size (SMS)
%  Each row in the filledOffers array represents an offer from the synthetic order book.
%     - The first column of each row represents the offer price.
%     - The second column of each row represents the volume at that offer price.
%
% The accumulatedBidVolume helps in determining:
%
% - How much volume has been filled so far.
% - Whether we have reached the desired SMS or if we need to continue accumulating more volume from the next bid levels.


% Initialize
filledBids = [];
filledOffers = [];
accumulatedBidVolume = 0;
accumulatedOfferVolume = 0;

% Traverse bids
for i = 1:size(syntheticOrderBook.bids, 1)
    currentBidVolume = syntheticOrderBook.bids(i, 2);
    if accumulatedBidVolume + currentBidVolume <= SMS
        filledBids = [filledBids; syntheticOrderBook.bids(i, :)];
        accumulatedBidVolume = accumulatedBidVolume + currentBidVolume;
    else
        remainingVolume = SMS - accumulatedBidVolume;
        filledBids = [filledBids; syntheticOrderBook.bids(i, 1), remainingVolume];
        break;
    end
end

% Traverse offers
for i = 1:size(syntheticOrderBook.offers, 1)
    currentOfferVolume = syntheticOrderBook.offers(i, 2);
    if accumulatedOfferVolume + currentOfferVolume <= SMS
        filledOffers = [filledOffers; syntheticOrderBook.offers(i, :)];
        accumulatedOfferVolume = accumulatedOfferVolume + currentOfferVolume;
    else
        remainingVolume = SMS - accumulatedOfferVolume;
        filledOffers = [filledOffers; syntheticOrderBook.offers(i, 1), remainingVolume];
        break;
    end
end
end

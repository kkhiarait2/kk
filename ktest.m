% Define order books for two trading venues
orderBook1.bids   = [1.45, 34; 1.44, 21];
orderBook1.offers = [1.46, 10; 1.47, 20];
orderBook2.bids   = [1.43, 11; 1.42, 32];
orderBook2.offers = [1.48, 15; 1.49, 25];

% Create a cell array of order books
orderBooks = {orderBook1, orderBook2};

% Create the synthetic order book
syntheticOrderBook = createSyntheticOrderBook(orderBooks);
syntheticOrderBook.bids
SMS = 50; % 50m
[filledBids, filledOffers,accumulatedBidVolume,accumulatedOfferVolume] = fillSMS(syntheticOrderBook, SMS)


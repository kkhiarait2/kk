function syntheticOrderBook = createSyntheticOrderBook(orderBooks)
    % Combine order books from different trading venues to create a synthetic order book
    
    % Initialize empty arrays for bids and offers
    allBids = [];
    allOffers = [];
    
    % Loop through all order books and collect all bids and offers
    for i = 1:length(orderBooks)
        allBids = [allBids; orderBooks{i}.bids];
        allOffers = [allOffers; orderBooks{i}.offers];
    end
    
    % Sort all bids in descending order of price (highest price first)
    allBids = sortrows(allBids, -1);
    
    % Sort all offers in ascending order of price (lowest price first)
    allOffers = sortrows(allOffers, 1);
    
    % Create the synthetic order book with combined and sorted bids and offers
    syntheticOrderBook.bids = allBids;
    syntheticOrderBook.offers = allOffers;
end

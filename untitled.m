function    [ktime, orderBooks]=load_snapshot(T,j)


ktime=datetime('27-Sep-2023 00:00:02') +minutes(58)+seconds(2+(j-1)*5);
    % create sevaral snapshot
    T=create_snapshot(snapshot);

    orderBook1.bids   = T(1,1).bids*(1+rand(1)/10);
    orderBook1.offers = T(1,1).offers*(1+rand(1)/10);
    orderBook2.bids   = T(1,2).bids*(1+rand(1)/10);
    orderBook2.offers = T(1,2).offers*(1+rand(1)/10);

    % Create a cell array of order books
    orderBooks = {orderBook1, orderBook2};
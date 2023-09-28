function T=create_snapshot(snapshot)

xrange=1:5;k=1;
T(k).bids  =[table2array(snapshot(xrange,3)) table2array(snapshot(xrange,2))];
T(k).offers=[table2array(snapshot(xrange,4)) table2array(snapshot(xrange,5))];
k=k+1;
xrange=6:10;
T(k).bids  =[table2array(snapshot(xrange,3)) table2array(snapshot(xrange,2))];
T(k).offers=[table2array(snapshot(xrange,4)) table2array(snapshot(xrange,5))];
k=k+1;
xrange=11:15;
T(k).bids  =[table2array(snapshot(xrange,3)) table2array(snapshot(xrange,2))];
T(k).offers=[table2array(snapshot(xrange,4)) table2array(snapshot(xrange,5))];
k=k+1;

xrange=11:15;
T(k).bids  =[table2array(snapshot(xrange,3))*0.578 table2array(snapshot(xrange,2))];
T(k).offers=[table2array(snapshot(xrange,4))*0.575 table2array(snapshot(xrange,5))];
k=k+1;
figure(2)
for i=1:k-1
    y=T(i).bids(:,1);
    plot(y,'--gs',...
        'LineWidth',2,...
        'MarkerSize',10,...
        'MarkerEdgeColor','b',...
        'MarkerFaceColor',[0.5,0.5,0.5])
    if i==1
        hold on
        grid on
        title('Bid prices by snapshot')
    end

end

figure(3)
for i=1:k-1
    y=T(i).offers(:,1);
    plot(y,'--gs',...
        'LineWidth',2,...
        'MarkerSize',10,...
        'MarkerEdgeColor','b',...
        'MarkerFaceColor',[0.5,0.5,0.5])
    if i==1
        hold on
        grid on
        title('Offer prices by snapshot')
    end

end
figure(1)
plot(vwamps,'--gs',...
    'LineWidth',2,...
    'MarkerSize',10,...
    'MarkerEdgeColor','b',...
    'MarkerFaceColor',[0.5,0.5,0.5])
yline(lowerBound,'--r','lower Bound')
yline(upperBound,'--r','upper Bound')



function rate = interpolateMovement(previousRate, vwamps)
    % Interpolate movement for the ICE Swap Rate
    movement = mean(diff(vwamps));
    rate = previousRate + movement;
end
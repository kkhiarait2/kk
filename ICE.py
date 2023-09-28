import pandas as pd
import numpy as np

#  --------------- functions   --------------------


#   -------------------
def isValidSnapshot(snapshot):
    """
    Check if snapshot is valid (not illiquid or crossed/zero spread)
    """
    isValid = bool(snapshot['bids']) and bool(snapshot['offers']) and \
              (snapshot['offers'][0][0] - snapshot['bids'][0][0]) > 0
    return isValid

#   -------------------
def fillSMS(syntheticOrderBook, SMS):
    """
    Identify price levels and volumes that cumulatively fill the Standard Market Size (SMS).
    Each row in the filledOffers list represents an offer from the synthetic order book.
    - The first element of each row represents the offer price.
    - The second element of each row represents the volume at that offer price.
    
    The accumulatedBidVolume helps in determining:
    - How much volume has been filled so far.
    - Whether we have reached the desired SMS or if we need to continue accumulating more volume from the next bid levels.
    """
    
    # Initialize
    filledBids = []
    filledOffers = []
    accumulatedBidVolume = 0
    accumulatedOfferVolume = 0

    # Traverse bids
    for bid in syntheticOrderBook['bids']:
        currentBidVolume = bid[1]
        if accumulatedBidVolume + currentBidVolume <= SMS:
            filledBids.append(bid)
            accumulatedBidVolume += currentBidVolume
        else:
            remainingVolume = SMS - accumulatedBidVolume
            filledBids.append([bid[0], remainingVolume])
            break

    # Traverse offers
    for offer in syntheticOrderBook['offers']:
        currentOfferVolume = offer[1]
        if accumulatedOfferVolume + currentOfferVolume <= SMS:
            filledOffers.append(offer)
            accumulatedOfferVolume += currentOfferVolume
        else:
            remainingVolume = SMS - accumulatedOfferVolume
            filledOffers.append([offer[0], remainingVolume])
            break

    return filledBids, filledOffers, accumulatedBidVolume, accumulatedOfferVolume

#   -------------------
def calculateICESwapRate(snapshots, previousDayRate):
    # Define constants
    PERCENTILE_LOW = 25
    PERCENTILE_HIGH = 75

    # 1. Calculate VWAMP for each snapshot
    numSnapshots = len(snapshots)
    vwamps = [0] * numSnapshots  # Pre-allocate memory for efficiency
    vwb = [0] * numSnapshots
    vwo = [0] * numSnapshots
    vwamp = [0] * numSnapshots

    for i in range(numSnapshots):

    # 2. Discard illiquid or crossed/zero spread snapshots
    validIndices = [isValidSnapshot(s) for s in snapshots]
    vwampsIliquid = [vwamps[i] for i in range(len(vwamps)) if validIndices[i]]
    if not vwampsIliquid:
        vwampsIliquid = [1]

    # 3. Discard outlier snapshots
    vwampsOutlier = []

    # 4. Calculate the quality-weighted ICE Swap Rate
    if len(vwamps) >= 2:
        qualityWeights = [calculateQualityWeight(s) for s in snapshots if isValidSnapshot(s)]
        vwamps = []
        for snapshot in snapshots:
            vwb_val = sum([bid[0] * bid[1] for bid in snapshot['bids']]) / sum([bid[1] for bid in snapshot['bids']])
            vwo_val = sum([offer[0] * offer[1] for offer in snapshot['offers']]) / sum([offer[1] for offer in snapshot['offers']])
            vwamp_val = (vwb_val + vwo_val) / 2
            spread = vwo_val - vwb_val
            weight = 1 / spread  # Assuming tighter spread has higher quality

            vwamps.append(vwamp_val)
            qualityWeights.append(weight)

        iceSwapRate = sum([vwamps[i] * qualityWeights[i] for i in range(len(vwamps))]) / sum(qualityWeights)
    else:
        # 5. Use movement interpolation if not enough liquid snapshots
        iceSwapRate = interpolateMovement(previousDayRate, vwamps)
        vwamp_val = (vwb[0] + vwo[0]) / 2
        spread = vwo[0] - vwb[0]
        weight = 1 / spread  # Assuming tighter spread has higher quality

        vwamps[0] = vwamp_val
        qualityWeights[0] = weight

    Z = [vwb, vwo, vwamp, vwampsIliquid, vwampsOutlier, spread, qualityWeights]
    return Z







#  --------------- main   --------------------


# Sample dataset of historical ICE Swap Rates
historicalRates = [1.495, 1.496, 1.497]  # and so on

# Define constants
PERCENTILE_LOW = 25
PERCENTILE_HIGH = 75
SMS = 50  # 50m
# Assuming today is the nth business day
n = len(historicalRates)  # or any other day index
W = []

# j is the number of 5 second buckets
for j in range(1, 25):

    # simulate time
    ktime[j], orderBooks = load_snapshot(T, j, snapshot)

    # Create the synthetic order book
    syntheticOrderBook = createSyntheticOrderBook(orderBooks)
    syntheticOrderBook.bids
    filledBids, filledOffers, accumulatedBidVolume, accumulatedOfferVolume = fillSMS(syntheticOrderBook, SMS)
    U = {'bids': filledBids, 'offers': filledOffers}

    # Define the previous day's rate
    previousDayRate = historicalRates[n-1]
    Z = calculateICESwapRate(U, previousDayRate)
    W.append(Z)

# Convert array to DataFrame
V = pd.DataFrame(W, columns=['VWB', 'VWO', 'VWAMP', 'LiquidityCheck', 'OutlierCheck', 'Spread', 'Weighting'])

# Outliers filters
vwamps = V['VWAMP']
lowerBound = np.percentile(vwamps, PERCENTILE_LOW)
upperBound = np.percentile(vwamps, PERCENTILE_HIGH)
vwampsOutlier = (vwamps >= lowerBound) & (vwamps <= upperBound)

# Liquidity outliers
V['LiquidityCheck'] = vwampsOutlier
V['OutlierCheck'] = V['OutlierCheck'] == 0
V['SnapshotTime'] = ktime
idx = (V['OutlierCheck'] == 1) & (V['LiquidityCheck'] == 1)

# Remove failed filters
V = V[idx]

# Final results
V['Weighting'] = abs(V['Weighting']) / sum(abs(V['Weighting']))
print(f"ICE Swap Rate (full granularity)     = {V['VWAMP'].mean():.3f}")
print(f"ICE Swap Rate (3dp for publication)  = {(V['VWAMP'] * V['Weighting']).sum():.3f}")

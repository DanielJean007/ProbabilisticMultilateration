Useful commands

repeat position of beacons
allPosBeacon = repmat(posBeacon, [size(pos1,1),1]);
pos1 is all distances given, not only one for each individual beacon.

turn all distances into vector.
pos2 = pos1';
allPos1 = pos2(:);

concatenate posBeacon and distances
posAndBeacons = [allPosBeacon allPos1];

Find zeros and remove them
rowsWithZeros = any(posAndBeacons ==0, 2);
posAndBeacons = posAndBeacons(~rowsWithZeros,:);

Separate data again
allPosBeacon = posAndBeacons(:,1:2);
allPos1 = posAndBeacons(:,3);

remove rows with 0's
pos1(sum((pos1==0),2)>0,:) = []


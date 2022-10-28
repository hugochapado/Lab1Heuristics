set STOPS;
set NONLASTSTOPS within STOPS;
set FLUX;
set NONLASTFLUX within FLUX;


param kilometers {w in STOPS, x in STOPS} ;
param students {w in STOPS};
param limitFlux;
param numberOfBuses;
param busCost;
param kilometerCost;

var road{a in STOPS, b in STOPS} binary;
var flux{a in FLUX, b in FLUX} integer;

   
s.t. Arriving {a in NONLASTSTOPS}: sum{b in STOPS} road[b,a] =1; 
s.t. Leaving {a in NONLASTSTOPS}: sum{b in STOPS} road[a,b] =1;
s.t. SmallerThanLimitBus: sum{a in STOPS} road['Parking',a] <= numberOfBuses;
s.t. LeaveEqArrive: sum{a in STOPS} road['Parking',a] = sum{b in STOPS} road[b,'School'];
s.t. FluxLimit {w in STOPS, x in STOPS}: flux[w,x] <= road[w,x]*limitFlux;
s.t. PositiveFlux {w in STOPS, x in STOPS}: flux[w,x] >= 0;
s.t. FluxSimmetry {a in NONLASTFLUX}: sum{b in FLUX} flux[b,a] + students[a] = sum{b in FLUX} flux[a,b];

minimize Cost:  busCost * sum{a in STOPS} road['Parking',a] + sum{w in STOPS, x in STOPS} kilometers[w,x]*road[w,x]*kilometerCost;

end;

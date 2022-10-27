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

var rode{a in STOPS, b in STOPS} binary;
var flux{a in FLUX, b in FLUX} integer;

   
s.t. Arriving {a in NONLASTSTOPS}: sum{b in STOPS} rode[b,a] =1; 
s.t. Leaving {a in NONLASTSTOPS}: sum{b in STOPS} rode[a,b] =1;
s.t. SmallerThanLimitBus: sum{a in STOPS} rode['S0',a] <= numberOfBuses;
s.t. LeaveEqArrive: sum{a in STOPS} rode['S0',a] = sum{b in STOPS} rode[b,'S4'];
s.t. FluxLimit {w in STOPS, x in STOPS}: flux[w,x] <= rode[w,x]*limitFlux;
s.t. FluxSimmetry {a in NONLASTFLUX}: sum{b in NONLASTFLUX} flux[b,a] + students[a] = sum{b in FLUX} flux[a,b];

minimize Cost:  busCost * sum{a in STOPS} rode['S0',a] + sum{w in STOPS, x in STOPS} kilometers[w,x]*rode[w,x]*kilometerCost;

end;

set STOPS;
set NONLASTSTOPS within STOPS;
set FLUX;
set NONLASTFLUX within FLUX;
set PEOPLE;

param kilometers {w in STOPS, x in STOPS} ;
param limitFlux;
param numberOfBuses;
param busCost;
param kilometerCost;
param posiblestops{a in STOPS, b in PEOPLE};
param siblings{a in PEOPLE, b in PEOPLE};

var road{a in STOPS, b in STOPS} binary;
var flux{a in FLUX, b in FLUX} integer;
var people{a in PEOPLE, b in STOPS} binary;
   
s.t. Arriving {a in NONLASTSTOPS}: sum{b in STOPS} road[b,a] =1; 
s.t. Leaving {a in NONLASTSTOPS}: sum{b in STOPS} road[a,b] =1;
s.t. SmallerThanLimitBus: sum{a in STOPS} road['Parking',a] <= numberOfBuses;
s.t. LeaveEqArrive: sum{a in STOPS} road['Parking',a] = sum{b in STOPS} road[b,'School'];
s.t. FluxLimit {w in STOPS, x in STOPS}: flux[w,x] <= road[w,x]*limitFlux;
s.t. PositiveFlux {w in STOPS, x in STOPS}: flux[w,x] >= 0;
s.t. FluxSimmetry {a in NONLASTFLUX}: sum{b in FLUX} flux[b,a] + sum{c in PEOPLE} people[c,a] = sum{b in FLUX} flux[a,b];
s.t. AssignOnly1Stop { a in PEOPLE}: sum{b in STOPS}people[a,b] = 1;
s.t. PositiveAssign{a in PEOPLE, b in STOPS}: people[a,b] >= 0;
s.t. AssignCorrectStop {a in PEOPLE, b in STOPS}: people[a,b] <= posiblestops[b,a];
s.t. Siblings {a in PEOPLE, b in STOPS,c in PEOPLE}: people[a,b] * siblings[a,c] = people[c,b] * siblings[a,c];

minimize Cost:  busCost * sum{a in STOPS} road['Parking',a] + sum{w in STOPS, x in STOPS} kilometers[w,x]*road[w,x]*kilometerCost;

end;
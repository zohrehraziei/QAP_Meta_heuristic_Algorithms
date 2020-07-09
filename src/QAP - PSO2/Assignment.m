function [assign ,LocationPermutation] = Assignment(PSOOutput , model )

% Assign Facilites to Locations 

n = model . n ;

%Transform Continous Output of PSO into Permutation
[~ , LocationPermutation] = sort(PSOOutput) ;

%Select n Location for n Facilities
assign = LocationPermutation ( 1: n)  ;


end
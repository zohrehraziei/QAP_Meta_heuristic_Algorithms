function [assign ,LocationPermutation] = Assignment(PSOOutput , model )

% Assign Facilites to Locations 

n = model . n ;


[~ , LocationPermutation] = sort(PSOOutput) ;

%Select n Location for n Facilities
assign = LocationPermutation ( 1: n)  ;


end
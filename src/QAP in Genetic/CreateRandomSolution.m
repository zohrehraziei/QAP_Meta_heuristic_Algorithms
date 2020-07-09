function LocationPermutation = CreateRandomSolution (model)

%Create Random Permutation For Locations

m = model.m;

LocationPermutation = randperm(m) ;


end
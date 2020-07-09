function z = ObjectiveFunction(LocationPermutation , model)

global NFE ;

if isempty(NFE)
    NFE = 0
end

NFE = NFE + 1 ;

    assign = Assignment(LocationPermutation , model );
    
    n=model.n;
    w=model.w;
    d=model.d;
    B=model.B;
    
    z=0;
    for i=1:n
       z=z+B(i,assign(i));
        for j=i+1:n
            z=z+w(i,j)*d(assign(i),assign(j));
        end
    end


end
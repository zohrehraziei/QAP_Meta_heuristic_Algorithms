function z= ObjectiveFunction(PSOOutput , model)



    [assign ,~] = Assignment(PSOOutput , model) ;
    
    
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
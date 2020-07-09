function y= PermutationMutation (x)

M=randi([1 4]) ;

%To Select kind of Mutation

switch M
    
    case 1
        % Selecting Swap based Mutation
        y=DoSwap(x) ;
    case 2
        % Selecting Reversion based Mutation
        y=DoInversion(x) ;
        
    case 3
        % Selecting Insersion based Mutation
        y=DoInsertion (x) ;
    case 4
        % Selecting Group Echange Mutation
        y = DoGroupExchange(x);
end

% Definition of swap Mutation 

    function y = DoSwap (x)
        
       n=numel(x);
       i=randsample(n,2);
       i1=i(1);
       i2=i(2);
       y=x;
       y([i1 i2])=x([i2 i1]); % Swap betwean i2 to i1 in x Vector 
       
    end
    
    function y = DoGroupExchange(x)  % Group Ecxhange Mutation
       
        n=numel(x);
        l=randi([1 10] , 1);
        i1=randsample(n/2-l,1);
        i2=i1+l+1;
        y=x;
        y(i1:(i1+l-1))=x(i2:(i2+l-1));
        y(i2:(i2+l-1))=x(i1:(i1+l-1));
        
    end
        
    function y = DoInversion (x)
        
        n=numel(x);
        i=randsample(n,2); 
        i1=min(i(1),i(2));
        i2=max(i(1),i(2));
        y=x;
        y(i1:i2)=x(i2:-1:i1); % Reversion betwean i2 to i1 in x Vector
        
    end

    function y= DoInsertion (x) 
       
        n=numel(x);
        i=randsample(n,2);     %Insertion Mutation 
        i1=i(1);
        i2=i(2);
        if i1<i2 
           y=[x(1:i1-1) x(i1+1:i2) x(i1) x(i2+1:end)];  
           
        else
           y=[x(1:i2) x(i1) x(i2+1:i1-1) x(i1+1:end)];
        end
        
    end
        

end

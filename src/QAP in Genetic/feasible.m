function f = feasible(x1,x2)
  
  
   
  l1 = numel(x1);
  l2 = numel(x2);
  
  f = 1;
  
  if l2 > 1
      for i = 2:l2

          if x2(i) == 1
              if x2(i-1) ~= 1
                  f = 0;
                  break ;
              elseif (x2(i+1) ~= 1 ) && (i~=2||i~=3||i~=4)
                  f = 0;
                  break ;
              end
              
          end
      end
                     
  end
  

end
function PlotSolution (s , model ) 

n=model.n ;
m=model.m ;
x=model.x ;
y=model.y ;

plot (x(s(1:n)) , y(s(1:n)) ,'rd',...  %Plot Assigned Locations
 'MarkerSize',12,...
 'MarkerFaceColor','y');

hold on ;


plot (x(s(n+1:end)) , y(s(n+1:end)) , 'bo',... %Plot not Assigned locations
 'MarkerSize' , 12 ) ;

xlabel('X' , 'FontSize' , 12) ;
ylabel('Y','FontSize' , 12) ;
title('Assignment Diagram','FontSize' , 12) ;

for i=1:n

text(x(s(i))+1 , y(s(i))-2,num2str(i),'FontSize' ,12) ;

end

hold off ;
grid on ;

end
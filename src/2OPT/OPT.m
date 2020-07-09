


function m = OPT()
b=randperm(40) ;% Here we enter the initial assignment
a=b(1:30) ;    
x=[41 67 94 81 48 76 42 98 99 87 39 45 24 79 89 92 56 60 15 90 45 20 90 77 89 28 67 67 12 41 27 72 28 90 83 39 50 70 84 61];
    
    y=[58 32 46 72 89 72 1 68 44 44 11 82 32 24 34 37 55 56 39 40 52 66 96 72 40 84 13 6 8 16 32 30 1 54 9 14 63 86 98 57];
    
    m=numel(x);
    
    d=zeros(m,m);
    
    for p=1:m
        for q=p+1:m
            d(p,q)=sqrt((x(p)-x(q))^2+(y(p)-y(q))^2);
            d(q,p)=d(p,q);
        end
    end
% In this line the distances matrix is given
    w=[
        
0	7	6	7	1	9	7	6	8	6	2	7	2	3	7	8	9	8	6	8	3	9	2	7	8	3	5	1	9	3
7	0	5	6	6	9	8	2	6	2	5	5	9	7	3	5	5	2	8	5	2	2	4	7	6	4	2	5	5	5
6	5	0	5	7	5	5	4	6	9	9	7	3	8	8	5	7	9	7	3	10	8	7	7	0	6	8	4	1	3
7	6	5	0	2	9	2	7	5	7	5	2	4	7	6	8	2	7	9	7	9	5	9	1	9	5	7	4	4	7
1	6	7	2	0	3	6	6	8	2	8	6	5	7	2	6	3	9	3	6	4	5	7	6	4	1	2	2	4	5
9	9	5	9	3	0	4	7	5	8	5	7	8	6	8	5	6	5	2	7	5	7	8	6	6	5	3	4	7	7
7	8	5	2	6	4	0	7	2	6	2	6	4	6	10	2	8	6	4	8	2	2	4	7	8	7	8	3	8	7
6	2	4	7	6	7	7	0	5	7	8	1	3	3	5	4	1	3	3	7	7	6	7	10	6	5	10	6	10	1
8	6	6	5	8	5	2	5	0	4	10	1	7	3	8	2	3	4	5	10	4	6	6	2	1	0	3	7	3	5
6	2	9	7	2	8	6	7	4	0	2	4	8	8	5	4	1	2	7	6	3	7	9	1	4	6	4	3	5	6
2	5	9	5	8	5	2	8	10	2	0	5	3	7	6	9	4	3	1	4	5	3	2	3	7	10	7	1	3	6
7	5	7	2	6	7	6	1	1	4	5	0	9	4	3	5	5	9	2	7	8	7	3	7	8	7	4	7	8	8
2	9	3	4	5	8	4	3	7	8	3	9	0	5	5	2	5	7	5	4	2	5	5	3	6	7	8	6	5	6
3	7	8	7	7	6	6	3	3	8	7	4	5	0	6	5	5	3	9	1	3	2	5	4	4	4	9	4	3	4
7	3	8	6	2	8	10	5	8	5	6	3	5	6	0	6	3	3	3	5	8	5	5	4	8	5	6	5	5	7
8	5	5	8	6	5	2	4	2	4	9	5	2	5	6	0	4	3	9	9	0	2	5	6	1	3	6	0	7	2
9	5	7	2	3	6	8	1	3	1	4	5	5	5	3	4	0	5	5	6	5	6	6	3	6	3	5	7	5	4
8	2	9	7	9	5	6	3	4	2	3	9	7	3	3	3	5	0	6	10	3	4	6	8	6	3	10	5	4	6
6	8	7	9	3	2	4	3	5	7	1	2	5	9	3	9	5	6	0	4	1	5	1	7	4	6	6	4	4	8
8	5	3	7	6	7	8	7	10	6	4	7	4	1	5	9	6	10	4	0	7	8	4	6	3	3	5	5	5	7
3	2	10	9	4	5	2	7	4	3	5	8	2	3	8	0	5	3	1	7	0	1	6	6	3	3	5	1	7	7
9	2	8	5	5	7	2	6	6	7	3	7	5	2	5	2	6	4	5	8	1	0	5	5	3	8	7	4	7	7
2	4	7	9	7	8	4	7	6	9	2	3	5	5	5	5	6	6	1	4	6	5	0	3	6	7	2	8	9	4
7	7	7	1	6	6	7	10	2	1	3	7	3	4	4	6	3	8	7	6	6	5	3	0	2	5	5	4	5	5
8	6	0	9	4	6	8	6	1	4	7	8	6	4	8	1	6	6	4	3	3	3	6	2	0	5	7	2	6	6
3	4	6	5	1	5	7	5	0	6	10	7	7	4	5	3	3	3	6	3	3	8	7	5	5	0	2	5	4	6
5	2	8	7	2	3	8	10	3	4	7	4	8	9	6	6	5	10	6	5	5	7	2	5	7	2	0	5	6	8
1	5	4	4	2	4	3	6	7	3	1	7	6	4	5	0	7	5	4	5	1	4	8	4	2	5	5	0	5	8
9	5	1	4	4	7	8	10	3	5	3	8	5	3	5	7	5	4	4	5	7	7	9	5	6	4	6	5	0	5
3	5	3	7	5	7	7	1	5	6	6	8	6	4	7	2	4	6	8	7	7	7	4	5	6	6	8	8	5	0

        ];

% w is the weights matrix
maxDTC=1;
% a positive  number. This will be updated in every iteration 
h=0;% Initial number of iterations. We give it a positive value so that
%  the initial condition in while loop is matched
while maxDTC>0 && h<100 
    % The algorithm is continued till all the elements of
    % DTC are zero
 for u=1:numel(a)
  for v=u+1:numel(a)
      % because the matrix is symmetric, only the half of the matrix
      % is searched. This leads to lower run time
   DTCsum=0;
   for i=1:numel(a)
    DTCI=((w(i,u)-w(i,v))*(d(a(i),a(u))-d(a(i),a(v))));
    DTCsum=DTCsum+DTCI;
   end
   DTC(u,v)=DTCsum-(2*w(u,v)*d(a(u),a(v)));%This few lines compute the
   % element(u,v)of DTC
  end
 end% Here we have DTC(u,v)
maxDTC=0;% resetting maxDTC 
% Next we compare the computed DTC(u,v) with 0
 for u=1:numel(a)
   for v=u+1:numel(a)
    if DTC(u,v)>maxDTC
      maxDTC=DTC(u,v);% if DTC(u,v) id greater than maxDTC, then put maxDTC
      %equal to it and save the indices
      U=u;%save the indices
      V=v;
    end
   end
 end
h=h+1;% one iteration is complete
% In case we want to compute the number of iteration that algorithm 
%reaches the solution, this numerator is updated
 if maxDTC<=0% ask whether the condition for the algorithm to continue is 
     % matched. 
  break;
 end
temp=a(U);% Exchanging the assigned ones to reduce the cost
a(U)=a(V);
a(V)=temp;
TC=zeros(numel(a));
for i=1:numel(a)
  for j=1:numel(a)
   TC(i,j)=.5*w(i,j)*d(a(i),a(j));% The cost matrix
  end
end
% displaying the cost matrix
Z=sum (sum (TC));% Total Cost
m=Z;
disp(['Best Cost:' num2str(Z) ' ;Assignment:' num2str(a)] )

%New assigned jobs(or whatever)
figure(1) ;
PlotSolution(a )

end
end

%% Plot function
function PlotSolution (s) 

n=30;
m=40;
x=[41 67 94 81 48 76 42 98 99 87 39 45 24 79 89 92 56 60 15 90 45 20 90 77 89 28 67 67 12 41 27 72 28 90 83 39 50 70 84 61];
    
y=[58 32 46 72 89 72 1 68 44 44 11 82 32 24 34 37 55 56 39 40 52 66 96 72 40 84 13 6 8 16 32 30 1 54 9 14 63 86 98 57];

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
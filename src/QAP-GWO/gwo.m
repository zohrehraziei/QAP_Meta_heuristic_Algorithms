clear ;
clc ;
close all ;

%% Problem Definition (Insert Functions)



model= ModelAttribute () ; % insert QAP model in Gray Wolf

%Define Objective Function :
CostFunction = @(PSOOutput)  ObjectiveFunction(PSOOutput,model); 


nVar = model.m ; % number of locations (Number of decision variables)

VarSize = [1 nVar] ; % size of decision variables matrix

VarMin = 0 ; %Lower Bound of Variables in PSO
VarMax = 1 ; %Upper Bound of Variables in PSO

%% PSO Parameters 

MaxIt = 200 ;  %Maximum number of Iteration 

npop = 100 ;  % Population Size or Swarm Size

% definition of Gray Wolf Parameters 

% a  = ones(3,nVar)*2;
% r1 = rand(3,nVar); 
% r2 = rand(3,nVar);
% adamp = ones(3,nVar)*2/MaxIt;
cc = 1.5;
a  = ones(1,nVar)*cc;
r1 = rand(1,nVar); 
r2 = rand(1,nVar);
adamp = ones(1,nVar)*cc/(MaxIt);

%Coefficient Vectors:
% A = ones(3,nVar).*2.*a.*r1 - a;
% C = ones(3,nVar).*2.*r2;

%encircling behaviour
D_alpha = [];
D_beta  = [];
D_delta = [];

pause (0.1) ;

%% Initialization

%Create empty preys with this attributes
empty_prey.Position = [] ;
empty_prey.Cost=[] ;

%prey position
X_alpha = empty_prey;
X_beta  = empty_prey;
X_delta = empty_prey;

%create prey matrix
prey = repmat(empty_prey , npop ,1 ) ;
new_prey = empty_prey;

for i=1:npop

    %Create Initial Position for preys
    prey(i).Position = unifrnd(VarMin , VarMax , VarSize ) ;
   

    prey(i).Cost = CostFunction(prey(i).Position) ;
    
end

BestCost=zeros(MaxIt,1);
WorstCost=zeros(MaxIt,1);
AverageCost=zeros(MaxIt,1);

Sum = 0 ;
CpuTime = zeros(MaxIt,1);
iter=zeros(MaxIt,1);



%% PSO Main Loop

tic
it=1 ;
while it<MaxIt
   
    Costs = [prey.Cost];
    [Costs ,sortorder] = sort (Costs) ;
    prey=prey(sortorder) ; 
    
     %prey position
    X_alpha = prey(1);
    X_beta  = prey(2);
    X_delta = prey(3);
    
    
   for i=1:npop
       
     
      % Apply X1
      r1 = rand(1,nVar); 
      r2 = rand(1,nVar);
      D_alpha = abs(ones(1,nVar).*1.*r2.*X_alpha.Position - prey(i).Position);
      X1 = X_alpha.Position - ones(1,nVar).*2.*a.*r1 - a.*D_alpha;
      
      % Apply X2
      r1 = rand(1,nVar); 
      r2 = rand(1,nVar);      
      D_beta = abs(ones(1,nVar).*1.*r2.*X_beta.Position - prey(i).Position);
      X2 = X_beta.Position - ones(1,nVar).*2.*a.*r1 - a.*D_beta;
      
      % Apply X3
      r1 = rand(1,nVar); 
      r2 = rand(1,nVar);      
      D_delta = abs(ones(1,nVar).*1.*r2.*X_delta.Position - prey(i).Position);
      X3 = X_delta.Position - ones(1,nVar).*2.*a.*r1 - a.*D_delta;      
      
      % Mean
      new_prey.Position = (X1 + X2 + X3)/3;
      
      %Apply Position Limit 
      new_prey.Position = max(new_prey.Position , VarMin);
      new_prey.Position = min(new_prey.Position ,VarMax );
      
      %Evaluation 
      new_prey.Cost = CostFunction(new_prey.Position) ;
      
      if new_prey.Cost < prey(i).Cost
          prey(i) = new_prey;
      end
    
    end
           
    Costs = [prey.Cost];
    [Costs ,sortorder] = sort (Costs) ;
    prey=prey(sortorder) ; 
%      BestCost(it)    = prey(1).Cost ;
     %prey position
     if X_alpha.Cost < prey(1).Cost
         prey(1) = X_alpha;
     end
     if X_beta.Cost < prey(2).Cost
         prey(2) = X_beta;
     end   
     if X_delta.Cost < prey(3).Cost
         prey(3) = X_delta;
     end      
     BestCost(it)    = X_alpha.Cost ;
    WorstCost(it)   = prey(end).Cost;
    AverageCost(it) = mean(Costs);
      
      
      % Result in each iteration
      disp([ num2str(BestCost(it)) ]) ;
       

       
        if it ==1 
            CpuTime(it) = toc ;
        else 
            for i=1:it-1
                Sum = Sum + CpuTime(i) ;
            end
            CpuTime (it) = toc - Sum ;
            Sum = 0 ;
        end
      

       iter (it) = it ;
       


 a = a - adamp;
 
 it = it+1 ;  
end

      MeanBest = mean(BestCost);
      MeanWorst = mean(WorstCost);
      MeanAverage = mean(AverageCost);
      
      VarBest = var(BestCost);
      VarWorst = var(WorstCost);
      VarAverage = var(AverageCost);

toc

    BestCost(it)    = X_alpha.Cost ;
    WorstCost(it)   = prey(end).Cost;
    AverageCost(it) = mean(Costs);

%% Convergence

figure(1) ;
plot(1:MaxIt-1 , BestCost(1:MaxIt-1) , 'LineWidth' , 4) ;
xlabel ('Iteration') ;
ylabel ('Objective Function') ;
title ('Best Solution & Worst Cost & Average Cost') ;
hold on; 
plot(1:MaxIt-1 , WorstCost(1:MaxIt-1) , 'LineWidth' , 3,'Color','r') ;
plot(1:MaxIt-1 , AverageCost(1:MaxIt-1) , 'LineWidth' , 2,'Color','g') ;


figure(2) ;
plot ( iter , CpuTime , 'bo' , 'MarkerSize' , 2) ;
xlabel ('Iteration') ;
ylabel('Cpu Time ') ;
title ('Efficiency ') ;

hold off



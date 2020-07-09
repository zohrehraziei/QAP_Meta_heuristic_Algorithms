clear ;
clc ;
close all ;

%% Problem Definition (Insert Functions)



model= ModelAttribute () ; % insert QAP model in HSA

%Define Objective Function :
CostFunction = @(PSOOutput)  ObjectiveFunction(PSOOutput,model); 


nVar = model.m ; % number of locations (Number of decision variables)

VarSize = [1 nVar] ; % size of decision variables matrix

VarMin = 0 ; %Lower Bound of Variables 
VarMax = 1 ; %Upper Bound of Variables 

%% PSO Parameters 

MaxIt =200 ;  %Maximum number of Iteration 

HMS = 100 ;  % Harmony Memory Size in HSA

% definition of HSA 

HMCR = 0.2; %Harmony Memory Coefficient
PAR  = 0.1; % Pitch Coefficient
BW   = 0.05;%Band Width


pause (0.1) ;

%% Initialization

%Create empty harmonys with this attributes
empty_harmony.Position = [] ;
empty_harmony.Cost=[] ;

%New Harmony
X_New   = empty_harmony;

%create harmony matrix
harmony = repmat(empty_harmony , HMS ,1 ) ;


for i=1:HMS

    %Create Initial Position for harmonys
    harmony(i).Position = unifrnd(VarMin , VarMax , VarSize ) ;
   

    harmony(i).Cost = CostFunction(harmony(i).Position) ;
    
end

Costs = [harmony.Cost];
[Costs ,sortorder] = sort (Costs) ;
harmony=harmony(sortorder) ;
%Worst Harmony
X_Worst = harmony(1);

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
   

    
        
   for i=1:nVar
       if rand()< HMCR
           X_New.Position(i) = harmony(randi(HMS,1,1)).Position(i);
           if rand() < PAR
               X_New.Position(i) = X_New.Position(i) + rand()*BW - rand()*BW;
           end
       
       else
           X_New.Position(i) = unifrnd(VarMin , VarMax , 1 ) ;
       end
   end
      
      %Apply Position Limit 
      X_New.Position = max(X_New.Position , VarMin);
      X_New.Position = min(X_New.Position ,VarMax );
      
      %Evaluation 
      X_New.Cost = CostFunction(X_New.Position) ;  
   
      if X_New.Cost < X_Worst.Cost
          X_Worst = X_New;
      end
      
      BestCost(it)  = X_Worst.Cost ;
      harmony(1)    = X_Worst;
      WorstCost(it) = harmony(HMS).Cost;
      Costs = [harmony.Cost];
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
       

 
 it = it+1 ;  
end

      BestCost(it)  = X_Worst.Cost ;
      harmony(1)    = X_Worst;
      WorstCost(it) = harmony(HMS).Cost;
      Costs = [harmony.Cost];
      AverageCost(it) = mean(Costs);
      
      MeanBest = mean(BestCost);
      MeanWorst = mean(WorstCost);
      MeanAverage = mean(AverageCost);
      
      VarBest = var(BestCost);
      VarWorst = var(WorstCost);
      VarAverage = var(AverageCost);

toc

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


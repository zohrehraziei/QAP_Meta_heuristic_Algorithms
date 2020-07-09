clear ;
clc ;
close all ;

%% Problem Definition (Insert Functions)

global NFE;
NFE=0;

model= ModelAttribute () ; % insert QAP model in GA

%Define Objective Function :
Costfunction = @(LocationPermutation)  ObjectiveFunction(LocationPermutation , model) ; 


nVar = model.m ; % number of locations (Number of decision variables)

Varsize = [1 nVar] ; % size of decision variables matrix

%% GA Parameters

MaxIt = 100 ; % maximum number of iterations

npop = 100 ; % population size

pc = 0.8 ; %Crossover Percentage

pm = 0.3 ; %mutation Percentage

nc = 2*round(pc * npop/2) ; %number of parents

nm = round ( pm*npop ) ; % number of mutants

beta = 10 ; %selection Pressure

pause (0.1) ;

%% Initialization 

%each individual has two attribute 
empty_individual.Position = [] ; %first attribute is position
empty_individual.Cost = [] ;%2nd attribute is cost due to objective function

% create population matrix
pop = repmat(empty_individual , npop , 1) ;

%initial population attribute

for i=1:npop
   
    %initialize position
    pop(i).Position = CreateRandomSolution (model) ;
    
    %Evaluation
    pop(i).Cost = Costfunction (pop(i).Position) ;
    
end

%sort population subject to Costs
Costs = [pop.Cost] ;
[Costs sortorder] = sort (Costs) ;
pop=pop(sortorder) ;

%Store Best Solution
BestSol = pop(1) ;

%Arraye to hold best cost values
BestCost = zeros(MaxIt , 1 ) ;

% Update Worst Cost
WorstCost=max(Costs);

% Array to Hold NFEs(Number of Function Evaluation)
nfe=zeros(MaxIt,1);

%% Main Loop 

tic

for it=1:MaxIt
   
      % Calculate Selection Probabilities for Roulettewheelselection
        P=exp(-beta*Costs/WorstCost);
        P=P/sum(P);
        
        %Crossover population(two vertical vector of offsprings)
        popc = repmat(empty_individual , nc/2 , 2) ;
        
        %Crossover loop
        for k=1:nc/2
           
            %select parents with Roulette wheel selection
            i1=RouletteWheelSelection(P);
            i2=RouletteWheelSelection(P);
            p1=pop(i1) ; %first Parent
            p2=pop(i2) ; %Second parent
            
            %Apply MOXCrossover
            [popc(k,1).Position popc(k,2).Position] = ...
                MOXCrossover(p1.Position , p2.Position) ;
            
            %Evaluate offspring output from croosover
            popc(k,1).Cost = Costfunction(popc(k,1).Position) ;
            popc(k,2).Cost = Costfunction(popc(k,2).Position) ;
        end
        popc=popc(:) ;
        
        %Mutation Population
        popm = repmat(empty_individual , nm , 1) ;
       
        %Mutation Loop
        for k=1:nm

            % select paret inex
            i=randi([1 npop]) ;
            
            %Select Parent with index i
            p = pop(i) ;
            
            %Apply mutation
            popm(k).Position = PermutationMutation(p.Position) ;
            
            %Mutation Output Evaluation 
            popm(k).Cost = Costfunction(popm(k).Position) ;
            
        end
        
        %Merge population 
        pop=[pop
             popc
             popm];
         
         %Sort Subject to Costs
         Costs=[pop.Cost] ;
         [Costs sortorder] = sort(Costs) ;
         pop=pop(sortorder) ;
         
         %Elimitate Worse solutions
         pop=pop(1:npop) ;
         Costs=Costs(1:npop);
         
         %store best solution ever found
         BestSol = pop(1) ;
         
         %store best cost ever found
         BestCost(it) = BestSol.Cost ;
         
         % Update Worst Cost
         WorstCost=max(WorstCost,max(Costs));
         
         % Update NFE
         nfe(it)=NFE;
    
         %Show iteration Information
         disp(['Iteration: ' num2str(it) ' NFE:' ...
             num2str(nfe(it)) ' Best Cost:' num2str(BestCost(it)) ]);
         
        %Plot Solution
        figure (1) ;
        PlotSolution(BestSol.Position , model ) ;
    
    
end

toc 

%% Convergence Figure

figure;
plot(nfe , BestCost , 'LineWidth' , 2) ;
xlabel('NFE') ;
ylabel('Best Cost') ;
title('Convergence') ;





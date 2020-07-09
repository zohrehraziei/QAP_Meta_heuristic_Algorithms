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


%% ACO Parameters

MaxIt = 100 ; %Maximum number of iterations

nAnt = 100 ; %Number of Ants

tau0 = 1 ; %initial phromone
rho = 0.05 ; %evaporation rate

alpha = 1 ; %phromone exponential weight

beta = 1 ; %heuristic exponential weight

Q = 1 ;

%% Initialization

eta = 1./model.d  ;%heuristic information
tau = tau0 * ones(nVar , nVar) ; %phromone Matrix

BestCost = zeros (MaxIt , 1) ; %array to hold best cost

%create empty ant
empty_ant.Tour = [] ;
empty_ant.Cost =[] ;

%Ant clony matrix
ant = repmat (empty_ant , nAnt ,1 ) ;

%BestAnt
BestAnt.Cost = inf ;


%% ACO Main Loop 

tic 
for it = 1 :MaxIt
    
   for k=1:nAnt 
      
       ant(k).Tour = randi([1 nVar]) ;
       
       for l=2:nVar 
          
           i = ant(k).Tour(end);
           
           p=tau(i,:).^alpha.*eta(i,:).^beta ;
           
          p(ant(k).Tour) = 0 ;
          
          p=p/sum(p) ;
          
          j=RouletteWheelSelection(p) ;
          ant(k).Tour = [ant(k).Tour j] ;
       end
       
       ant(k).Cost = Costfunction(ant(k).Tour) ;
       
       if ant(k).Cost < BestAnt.Cost 
          
           BestAnt = ant(k) ;
           
       end
       
   end
   
   %Update Phromone 
   for k=1:nAnt
      
       tour = ant(k).Tour ;
      
       
       for l=1:nVar-1
          
           i=tour(l) ;
           j=tour(l+1) ;
           tau(i,j) = tau(i,j) + Q/ant(k).Cost ;
       end
           %Evaporation
           tau = (1-rho)*tau ;

            
   end
         %Store Best Cost
         BestCost(it) = BestAnt.Cost ;
         % Update NFE
         nfe(it)=NFE;
    
         %Show iteration Information
         disp(['Iteration: ' num2str(it) ' NFE:' ...
             num2str(nfe(it)) ' Best Cost:' num2str(BestCost(it)) ]);
         
        %Plot Solution
        figure (1) ;
        PlotSolution(BestAnt.Tour , model ) ;
    
    
end

toc 

       
 %% Convergence Figure

figure;
plot(nfe , BestCost , 'LineWidth' , 2) ;
xlabel('NFE') ;
ylabel('Best Cost') ;
title('Convergence') ;


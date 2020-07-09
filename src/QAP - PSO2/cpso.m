clear ;
clc ;
close all ;

%% Problem Definition (Insert Functions)



model= ModelAttribute () ; % insert QAP model in PSO

%Define Objective Function :
CostFunction = @(PSOOutput)  ObjectiveFunction(PSOOutput,model); 


nVar = model.m ; % number of locations (Number of decision variables)

VarSize = [1 nVar] ; % size of decision variables matrix

VarMin = 0 ; %Lower Bound of Variables in PSO
VarMax = 1 ; %Upper Bound of Variables in PSO

%% PSO Parameters 

MaxIt = 10000 ;  %Maximum number of Iteration 

npop = 100 ;  % Population Size or Swarm Size

% definition of PSO Parameters with respect to Clerc&Kennedy Formula
phi1 = 2.05 ; 
phi2 = 2 ;
phi = phi1 + phi2 ;
chi = 2/(phi -2 + sqrt(phi^2 -4*phi)) ;
w = chi ;           %Inertia Weight
wdamp=0.6;
c1 = chi * phi1 ;   %Personal Learning Coefficient
c2 = chi * phi2 ;   %Social Learning Coefficient


%Velocity Limit
VelMax = 0.1 * (VarMax - VarMin) ;
VelMin = -VelMax ;

%% Initialization

%Create empty Particles with this attributes
empty_particle.Position = [] ;
empty_particle.Cost=[] ;
empty_particle.Velocity=[] ;
empty_particle.Best.Position=[] ;
empty_particle.Best.Cost=[] ;



%create particle matrix
particle = repmat(empty_particle , npop ,1 ) ;

GlobalBest.Cost = inf ;
%GlobalBest.Position =zeros(1,nVar) ;

for i=1:npop

    %Create Initial Position for Particles
    particle(i).Position = unifrnd(VarMin , VarMax , VarSize ) ;
    
    %Create initial Velocity for each Particle
    particle(i).Velocity = zeros(VarSize) ;

    particle(i).Cost = CostFunction(particle(i).Position) ;
    
    %Update Personal Best
    particle(i).Best.Position = particle(i).Position ;
    particle(i).Best.Cost = particle(i).Cost ;
    
    %Update Golbal Best
    if particle(i).Best.Cost < GlobalBest.Cost 
        GlobalBest = particle(i).Best ;
       
    end
    
end

BestCost=[];

Sum = 0 ;
CpuTime = [];
iter=[];
AVG = [] ;
VarianceBest=[];
Mean=[];
MaxCoefficientofVariation=100;
MinCoefficientofVariation=0;
GapCoefficientofVariation = 100 ;

%% PSO Main Loop

tic
k=0;
it = 1 ;
while k<50
    
   for i=1:npop
       
        % Update Velocity
            particle(i).Velocity = w*particle(i).Velocity ...
            +c1*rand(VarSize).*(particle(i).Best.Position-particle(i).Position) ...
            +c2*rand(VarSize).*(GlobalBest.Position-particle(i).Position);

      %Apply Velocity Limits
      particle(i).Velocity = max(particle(i).Velocity,VelMin) ;
      particle(i).Velocity = min(particle(i).Velocity , VelMax) ;
      
      %Update Position in Space
      particle(i).Position = particle(i).Position + particle(i).Velocity ;
      
      
      %Apply Position Limit 
      particle(i).Position = max(particle(i).Position , VarMin);
      particle(i).Position = min(particle(i).Position ,VarMax );
      
      %Evaluation 
      particle(i).Cost = CostFunction(particle(i).Position) ;
      
     % Use Mutation
%       NewSol.Position = PermutationMutation(particle(i).Position);
%       NewSol.Cost = CostFunction(NewSol.Position) ;
%       
%       if NewSol.Cost < particle(i).Cost
%          
%           particle(i).Position = NewSol.Position ;
%           particle(i).Cost = NewSol.Cost ;
%           
%       end
     
      %Update Personal Best 
      if particle(i).Cost < particle(i).Best.Cost 
         
          particle(i).Best.Position = particle(i).Position ;
          particle(i).Best.Cost = particle(i).Cost ;
          
      
      
      %Update Global Best
      if particle(i).Best.Cost < GlobalBest.Cost 
         
          GlobalBest = particle(i).Best ;
          
      end
      
      end
           
   end
   
      %Use Mutation
%       NewSol.Position = PermutationMutation(GlobalBest.Position);
%       NewSol.Cost = CostFunction(NewSol.Position) ;
%       
%       if NewSol.Cost < GlobalBest.Cost
%          
%           GlobalBest.Position = NewSol.Position ;
%           GlobalBest.Cost = NewSol.Cost ;
%           
%       end
      
      BestCost(it) = GlobalBest.Cost ;
      AVG(it) = mean([particle.Cost]) ;
      
      
      % Result in each iteration
      disp(['Iteration : ' num2str(it) ...
           ' ; Best : ' num2str(BestCost(it)) ]) ;
       

       figure(1) ;
       
       PlotSolution(GlobalBest.Position , model) ;
       
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
       VarianceBest(it) = var(BestCost) ;
       Mean (it) = mean(BestCost) ;

       
       if it>50 
               MaxCoefficientofVariation=max(VarianceBest(it-50:it))/Mean(mean(it-50:it));
               MinCoefficientofVariation=min(VarianceBest(it-50:it))/Mean(mean(it-50:it));
               GapCoefficientofVariation=MaxCoefficientofVariation-MinCoefficientofVariation ;
           if GapCoefficientofVariation<0.02
               k=k+1 ;
           end
       end
       
       if it > 100
          disp(['Break']) ;
           break 
       end


 w=w*wdamp;
 
  it = it + 1 ;  
end

toc

%% Convergence

figure ;
plot(iter , BestCost , 'LineWidth' , 2) ;
hold on ;
plot(iter , AVG , '+' , 'LineWidth' ,2) ;
xlabel ('Iteration') ;
ylabel ('Best Cost & Average Cost') ;
title ('Best Solution vs Average Solution in each iteration') ;
hold off ;

figure ;
plot ( iter , CpuTime , 'bo' , 'MarkerSize' , 2) ;
xlabel ('Iteration') ;
ylabel('Cpu Time ') ;
title ('Efficiency ') ;




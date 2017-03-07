close all

start = cputime;
assets = 500;
scenarios = 5000;
expected_return = rand(1, assets);
ret = 0.2;
alpha = 0.90;
y = rand(1, assets);
b = randperm(assets, assets);    %[1 2 3 4 5 6 7 8 9 10];
%loss_function = b-y;


 cvar_min_opt(assets, scenarios, expected_return, ret, alpha, b);
 end_ = cputime;
 
 fprintf('CPU Time: %g\n', end_ - start);

%%fprintf('Minimun expected return : %f\n', ret);
%%fprintf('Asset returns : %f\n', ScenRets);
%%fprintf('Confidence level : %f\n', alpha);
%%fprint('Weights : %f\n', weights);



function  cvar_min_opt(assets, scenarios, expected_return, ret, alpha, b)

try
    f = [zeros(1, assets) 1 ones(1, scenarios)/scenarios/(1-alpha)]';
    
%     % Inequalities on the dummy variables z 
     Aineq = [];
     for i=1:scenarios  
     loss_function = b - rand(1, assets);
     Aineq(i,:) = [loss_function -1];
     %Aineq = vertcat(Aineq);
%     %Aineq(:,:) = [loss_function -ones(1, scenarios) ones(1, scenarios-1)]
%     Aineq = vertcat(Aineq, [loss_function -ones(1, scenarios) ones(1, scenarios-1)])
%     %Aineq = kron(A,ones(assets,1))
     end
     Aineq = [Aineq -eye(scenarios)];
     %Aineq = [Aineq; zeros(scenarios, assets) zeros(1, scenarios)' -eye(scenarios)] 
     %Aineq=  [Aineq; -eye(assets) zeros(1, scenarios)' zeros(scenarios, assets)] 
     Aineq = [Aineq; -expected_return 0 zeros(1, scenarios)];
     %Aineq
     bineq = [zeros(scenarios, 1); -ret]; % zeros(scenarios, 1); zeros(scenarios, 1); -ret]
%     
%     % Inequality on expected return
%     Aineq = [Aineq; [expected_return zeros(1, scenarios) zeros(1, scenarios-1)]]  
%     bineq(2+scenarios,1) = -ret
%     %bineq = bineq'
%     
%     %lower bounds
      lb = zeros(1+assets+scenarios,1);
      %lb(1,1) = -100
      %lb = lb'
%     
%     Equality (portfolio consistency)
      Aeq = [ones(1, assets), 0, zeros(1, scenarios)];
      beq = (1);
%     
%     % Toolbox options are set with the function cplexoptimset
     options = cplexoptimset;
     options.Display = 'on';
%     
     [x, fval, exitflag, output] = cplexlp(f, Aineq, bineq, Aeq, beq, lb, [], [], options);
%     
     fprintf('\nSolution status = %s\n', output.cplexstatusstring);
     fprintf('Solution value = %f\n', fval);
     fprintf('VaR = %f\n', x(assets+1));
     %disp('Values =');
     %disp(x');
catch m
    disp(m.message)
end
%pweights = x(2:assets+1)';
end





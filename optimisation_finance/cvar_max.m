close all

assets = 500;
scenarios = 1000;
indices = 3;
expected_return = rand(1, assets);
ret = 0.1;
alpha = 0.9;
y = rand(1, assets);
b = randperm(assets, assets); 

cvar_max_opt(assets, scenarios, expected_return, ret, alpha, b)

function  cvar_max_opt(assets, scenarios, expected_return, ret, alpha, b);

try
    f = [expected_return 0 zeros(1, scenarios)]';
    
    Aineq = [];
    for i=1:scenarios
        loss_function = b - rand(1, assets);
        Aineq(i,:) = [loss_function -1];
    end
    Aineq = [Aineq -eye(scenarios)];
    Aineq = [Aineq; zeros(scenarios, assets) ones(scenarios, 1) ((scenarios*(1 - alpha))^(-1))*ones(scenarios)]; 
    %Aineq = [Aineq; zeros(scenarios, assets) zeros(scenarios, 1) -eye(scenarios)];
    
    bineq = [zeros(scenarios, 1); ones(scenarios, 1) * 2];%; zeros(scenarios, 1)]
    
     Aeq = [ones(1, assets), 0, zeros(1, scenarios)];
     beq = (1);
     
     %lower bounds
     lb = zeros(1+assets+scenarios,1);
     
     %Toolbox options are set with the function cplexoptimset
     options = cplexoptimset;
     options.Display = 'on';
     
     [x, fval, exitflag, output] = cplexlp(f, Aineq, bineq, Aeq, beq, lb, [], [], options);
     
     fprintf('\nSolution status = %s\n', output.cplexstatusstring);
     fprintf('Solution value = %f\n', fval);
     fprintf('VaR = %f\n', x(assets+1));
     %disp('Values =');
     %disp(x');
    
catch m
    disp(m.message);    
end

end
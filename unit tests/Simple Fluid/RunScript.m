% In this example, we look at the convergence rate of 
% an exact solution to the Navier-Stokes Equation with 
% no immersed boundary.

% Add PATH reference in order to run solver
addpath('../../solver/Peskin-TwoStep');
addpath('../../solver/utils');

% Set Figure settings
set(0,'defaultaxesfontsize',20);
set(0,'defaultaxeslinewidth',0.75);
set(0,'defaultlinelinewidth',2);
set(0,'defaultpatchlinewidth',1);
set(0,'defaultlinemarkersize',10);

% The number of grid points.
N = 2*round(2.^(5:7)); 


% Parameter values.
mu = 0.001;        % Viscosity.
rho = 2;       % Density.

% Time step and final time.
Tfinal = 1.00;
dt = 1e-3;
NTime = floor(Tfinal./dt)+1;

% Run Simulation for a simple fluid
[SupErrorU, SupErrorV, L2ErrorU, L2ErrorV] = SimpleFluid(mu, rho, L, NTime, Tfinal, N);

% Plot the errors.
figure;
loglog(N,SupErrorU,'bo-');
hold on;
loglog(N,L2ErrorU,'rx--');
loglog(N,SupErrorV,'kx-.');
loglog(N,L2ErrorV,'gd-.');
hold off;
xlabel('N');
ylabel('Error in Fluid Velocity');
legend('u - L^\infty','u - L^1', 'v - L^\infty','v - L^1');

p = polyfit(log(1.0./N),log(SupErrorU),1);
fprintf('Sup Convergence Rate (U): %f\n',p(1));
p = polyfit(log(1.0./N),log(SupErrorV),1);
fprintf('Sup Convergence Rate (V): %f\n',p(1));
p = polyfit(log(1.0./N),log(L2ErrorU),1);
fprintf('L2 Convergence Rate (U): %f\n',p(1));
p = polyfit(log(1.0./N),log(L2ErrorV),1);
fprintf('L2 Convergence Rate (V): %f\n',p(1));

% Remove PATH reference to avoid clutter
rmpath('../../solver/Peskin-TwoStep');
rmpath('../../solver/utils');

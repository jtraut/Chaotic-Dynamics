
dataPath = 'ps9_chaotic_data.txt';
%dataPath = 'ps9_non_chaotic_data.txt';

%Q2 algorithm
wolf(dataPath);

%Q4 alternative method for computing Lyapunov exponents
x{1} = [-13 -12 52 1 0 0 0 1 0 0 0 1]; %Initial condition
h = .001;
n = 10000;
%components = variational_eqns(0, h, n, x, @lorenz_variational);

%comp = components{n};
%varMatrix = [comp(1), comp(4), comp(7); 
%             comp(2), comp(5), comp(8);
 %            comp(3), comp(6), comp(9)];
  
%eigen = eig(varMatrix); 
t = h*n;

%lambda = lyapunov_exponents(eigen,t)


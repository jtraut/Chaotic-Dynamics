x{1} = [0 0 0 0 0 0 1 0 0 0 1 0 .5 22.3 0 0 -.15 0]; %Initial conditions

three_body_system(x, 10000, @three_body_equations); 
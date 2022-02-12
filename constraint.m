function constraints = constraint()
%max load in KW
constraints.MAX_LOAD = 5;

%allowed types
constraints.ALLOWED_TYPE = 'shiftable';

%allowed dissatisfaction level
constraints.ALLOWED_DISS_LEVEL = 1;
end
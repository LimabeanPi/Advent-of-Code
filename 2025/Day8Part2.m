clc; clear; close all;

inputs = input('Input: ','s');
% pairs = input('Pairs: ');

raw = fileread(inputs);          % read entire file as text
lines = splitlines(raw);         % split into lines
lines = string(lines);           % convert to string array
data = lines;

points = split(data, ",");
points = str2double(points);
[numpoints, ~] = size(points);
shortest = zeros(numpoints);

for i = 1:numpoints
    for j = 1:numpoints
        if i <= j
            shortest(i,j) = NaN;
        else
            xdist = ( points(i,1) - points(j,1) )^2;
            ydist = ( points(i,2) - points(j,2) )^2;
            zdist = ( points(i,3) - points(j,3) )^2;
            totdist = sqrt(xdist + ydist + zdist);
            shortest(i,j) = totdist;
        end
    end
end

parent = 1:numpoints;
circuitsize = ones(1,numpoints);
longbois = [];

longest = 0;
while longest < numpoints
    [M,I] = min(shortest);
    [M,J] = min(M);
    shortest(I(J),J) = NaN;
    I1 = I(J);
    while parent(I1) ~= I1
        parent(I1) = parent(parent(I1));
        I1 = parent(I1);
    end
    r2 = I1;
    J1 = J;
    while parent(J1) ~= J1
        parent(J1) = parent(parent(J1));
        J1 = parent(J1);
    end
    r1 = J1;

    if r1 ~= r2
        parent(r2) = r1;
        circuitsize(r1) = circuitsize(r1) + circuitsize(r2);
    end
    longbois = [];
    for i = 1:numpoints
        if parent(i) == i
            longbois = [longbois, circuitsize(i)];
        end
    end
    longbois = sort(longbois, 'descend');
    longest = longbois(1);

end
x1 = points(I(J), 1);
x2 = points(J,1);
xmult = x1 * x2;
fprintf('Part 2: %d\n', xmult);
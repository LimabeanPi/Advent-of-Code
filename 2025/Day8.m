clc; clear; close all;

inputs = input('Input: ','s');
pairs = input('Pairs: ');

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

for k = 1:pairs
    [M,I] = min(shortest);
    [M,J] = min(M);
    shortest(I(J),J) = NaN;

    while parent(I(J)) ~= I(J)
        parent(I(J)) = parent(parent(I(J)));
        I(J) = parent(I(J));
    end
    r2 = I(J);
    while parent(J) ~= J
        parent(J) = parent(parent(J));
        J = parent(J);
    end
    r1 = J;

    if r1 ~= r2
        parent(r2) = r1;
        circuitsize(r1) = circuitsize(r1) + circuitsize(r2);
    end

end

longbois = [];

for i = 1:numpoints
    if parent(i) == i
        longbois = [longbois, circuitsize(i)];
    end
end

longbois = sort(longbois, 'descend');
summers = longbois(1) * longbois(2) * longbois(3);
fprintf('Part 1: %d\n', summers);
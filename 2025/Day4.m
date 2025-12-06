clc; clear; close all;

inputs = input('input: ','s');
tic
data = char(readlines(inputs));

[a,b] = size(data);
matr = zeros(a,b);
kernel = [1,1,1;1,0,1;1,1,1];

for i = 1:a
    for j = 1:b
        if data(i,j) == '@'
            matr(i,j) = 1;
        end
    end
end
summers = 1;
bigsum = 0;
while summers >0
    surr = conv2(matr, kernel, 'same');
    summers = 0;
    for i = 1:a
        for j = 1:b
            if surr(i,j) < 4 && matr(i,j) == 1
                summers = summers + 1;
                matr(i,j) = 0;
            end
        end
    end
    if bigsum == 0
        fprintf('Part 1: %d\n', summers);
    end
    imagesc(matr);
    pause(0.5);
    bigsum = bigsum + summers;
end
fprintf('Part 2: %d\n', bigsum);
toc

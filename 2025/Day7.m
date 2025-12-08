clc; clear; close all;

inputs = input('input: ','s');
data = char(readlines(inputs));

[l,w] = size(data);
memory = zeros(l,w);
beams = zeros(1,w);
beamspt2 = zeros(1,w);
for i = 1:w
    if data(1,i) == 'S'
        beams(i) = 1;
        beamspt2(i) = 1;
        xloc = i;
        memory(1,i) = 1;
        break
    end
end

summers = 0;
yval = 2;
while yval <= l
    for xval = 2:w-1
        if data(yval,xval) == '^' && beams(xval) == 1
            beams(xval-1) = 1;
            beams(xval) = 0;
            beams(xval+1) = 1;
            summers = summers + 1;
        elseif data(yval,xval) ~= '^'
            memory(yval,xval) = memory(yval, xval) + memory(yval-1, xval);
            if data(yval,xval-1) == '^' 
                memory(yval,xval) = memory(yval,xval) + memory(yval - 1, xval - 1);
            end
            if data(yval, xval+1) == '^'
                memory(yval,xval) = memory(yval,xval) + memory(yval - 1, xval + 1);
            end
        end
    end
    yval = yval + 1;
end
fprintf('Part 1: %d\n', summers);

timelines = sum(memory(end,:));
timelines = timelines + 2;                      % Edge Cases
fprintf('Part 2: %d\n', timelines);

clc; clear; close all;

inputs = input('Input: ', 's');

raw = fileread(inputs);          % read entire file as text
lines = splitlines(raw);         % split into lines
lines = string(lines);           % convert to string array
data = lines;

blankline = find(data == "");
range = data(1:blankline-1);
IDs = data(blankline+1:end);

range = split(range, "-");
range = str2double(range);
IDs = str2double(IDs);
[rangelen, ~] = size(range);

summers = 0;
freshids = 0;


for IDnum = 1:length(IDs)
    for rangenum = 1:rangelen
        if IDs(IDnum) >= range(rangenum, 1) && IDs(IDnum) <= range(rangenum, 2)
            summers = summers + 1;
            IDs(IDnum) = 0;
            break
        end
        freshdig = range(rangenum, 1);
    end
end

fprintf('Part 1: %d\n', summers);


[~, sortIdx] = sort(range(:,1));
range = range(sortIdx, :);

highestend = 0;

for i = 1:rangelen
    endval = range(i, 2);
    startval = range(i, 1);
    if highestend >= endval
        addedids = 0;
    else
        if startval <= highestend
            startval = highestend + 1;
        end
        highestend = endval;
        addedids = endval - startval + 1;
    end

    freshids = freshids + addedids;
end
fprintf('Part 2: %d\n', freshids);

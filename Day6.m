clc; clear; close all;

inputs = input('input: ','s');
tic
raw = fileread(inputs);          % read entire file as text
lines = splitlines(raw);         % split into lines
lines = string(lines);           % convert to string array
data = lines;

[a,~] = size(data);

mathnums = readmatrix(inputs);
mathnums(end,:) = [];

funct = split(data(end,:))';
funct(funct == "") = [];         % remove empty lines

[factors,eqnnum] = size(mathnums);
totsum = 0;


for numnum = 1:eqnnum
    if funct(numnum) == "*"
        summers = 1;
        for b = 1:a-1
            summers = summers * mathnums(b,numnum);
        end
    else
        summers = 0;
        for b = 1:a-1
            summers = summers + mathnums(b,numnum);
        end
    end
    totsum = totsum + summers;
end
fprintf('Part 1: %d\n', totsum);





functstr = char(data(end,:));

charlen = 0;
factors2 = [];
for i = 2:length(functstr)
    if functstr(i) == " "
        charlen = charlen + 1;
    else
        factors2 = [factors2, charlen];
        charlen = 0;
    end
end
factors2 = [factors2, charlen + 1];




lengtha = strlength(data(1));
newdata = char(zeros(lengtha, a-1));
for i = 1:a-1
    stringa = char(data(i));
    for j = 1:lengtha
        charchar = char(stringa(j));
        newdata(j,i) = charchar;
    end
end
newdata = str2double(string((newdata)));

newdataprime = newdata(~isnan(newdata));             % Removes NaN's
pt2 = 0;
startingfactor = 0;

for numnum = 1:eqnnum
    if funct(numnum) == "*"
        summers = 1;
        for b = 1:factors2(numnum)
            summers = summers * newdataprime(startingfactor + b);
        end
    else
        summers = 0;
        for b = 1:factors2(numnum)
            summers = summers + newdataprime(startingfactor + b);
        end
    end
    startingfactor = startingfactor + factors2(numnum);
    pt2 = pt2 + summers;
end

fprintf('Part 2: %d\n', pt2);
toc
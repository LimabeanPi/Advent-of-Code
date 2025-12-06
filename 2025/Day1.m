clc; clear; close all;

file = input('Input: ','s'); 
tic
start = 50;
raw = fileread(file);
lines = splitlines(raw);
Megalist = lines(lines ~= "");

letters = extract(Megalist, 1);
numbers =  str2double(extractAfter(Megalist, 1));

i = 1;
new = start;
zerocount = 0;
extratot = 0;
bonus = 0;
bonusup = 0;
while i <= length(Megalist)
    value = mod(numbers(i),100);
    
    extras = floor(numbers(i)/100);
    
    extratot = extratot + extras; 
    
    if letters(i) == "R"
        if value + new > 100
            bonusup = bonusup +1;
        end
        new = mod(new + value, 100);
    else
        if new > 0 && new - value < 0
            bonus = bonus + 1;
        end
        new = mod(new - value, 100);
        
    end
    i = i+1;
    if new == 0
        zerocount = zerocount + 1;
    end
end
fprintf('Part 1: %d\n', zerocount);
%disp(bonus);
%disp(bonusup); 
%disp(extratot);
totalzeros = zerocount + bonus + bonusup + extratot; 
fprintf('Part 2: %d\n', totalzeros);
   toc
            
        

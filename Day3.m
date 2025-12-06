clc; clear; close all;

% Part 1: Joltage Digits = 2
% Part 2: Joltage Digits = 12

inputs = input('input: ', 's');
totdigits = input('Joltage Digits: ');
tic

raw = fileread(inputs);          % read entire file as text
lines = splitlines(raw);         % split into lines
lines = string(lines);           % convert to string array
lines(lines == "") = [];         % remove empty lines
data = lines;                    % each row is now a pure string

batteryno = 1;
summers = 0;
while batteryno <= height(data)
    current = data(batteryno);

    next = 0;
    hiloc = 0;
    digstring = "";

    for digit = 1:totdigits
        batpos = hiloc + 1;
        highest = "0";

        while batpos <= strlength(current) - totdigits + digit
            next = extractBetween(current, batpos, batpos);

            if next > highest
                highest = next;
                hiloc = batpos;
            end

            batpos = batpos + 1;
        end
        digstring = digstring + highest;
    end

    batteryno = batteryno + 1;
    summers = summers + str2double(digstring);
    % disp(digstring)
end

fprintf('Sum: %d\n', summers);
toc
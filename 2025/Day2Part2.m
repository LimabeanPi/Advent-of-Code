clc; clear; close all;

inputs = input('input: ','s');
tic
datasets = {};
inout = [];
lowhigh = zeros(2,1);
for i = 1:length(inputs)

    if inputs(i) == '-'
        lowhigh(1,1) = string(inout);
        inout = [];

    elseif inputs(i) == ','
        lowhigh(2,1) = string(inout);
        datasets{end+1} = lowhigh;
        inout = [];

    else
        inout = [inout, inputs(i)];
    end
end
lowhigh(2,1) = string(inout);
datasets{end+1} = lowhigh;

realinvalids = 0;
for j = 1:length(datasets)
    invalids = [];
    current = string(datasets{1,j});

    numlength = strlength(current(1,1));
    workspaceval = current(1,1);
    startnum = 1;


    firstset = "1";
    doublefirsthalf = firstset + firstset;
    while strlength(doublefirsthalf) < strlength(current(2,1))
        doublefirsthalf = doublefirsthalf + firstset;
    end
    doubledouble = str2double(doublefirsthalf);

    while doubledouble <= str2double(current(2,1))
        if doubledouble >= str2double(current(1,1))
            invalids = [invalids, doubledouble];
        end
        firstset = str2double(firstset) + 1;
        firstset = string(firstset);
        doublefirsthalf = firstset + firstset;

        while strlength(doublefirsthalf) < strlength(current(2,1))
            doublefirsthalf = doublefirsthalf + firstset;
        end
        doubledouble = str2double(doublefirsthalf);
    end

    while startnum <= ceil(numlength/2)
        firstset = extractBetween(workspaceval, 1, startnum);
        doublefirsthalf = firstset + firstset;
        while strlength(doublefirsthalf) < strlength(current(1,1))
            doublefirsthalf = doublefirsthalf + firstset;
        end
        doubledouble = str2double(doublefirsthalf);

        while doubledouble <= str2double(current(2,1))
            if doubledouble >= str2double(current(1,1))
                invalids = [invalids, doubledouble];
            end
            firstset = str2double(firstset) + 1;
            firstset = string(firstset);
            doublefirsthalf = firstset + firstset;

            while strlength(doublefirsthalf) < strlength(current(1,1))
                doublefirsthalf = doublefirsthalf + firstset;
            end
            doubledouble = str2double(doublefirsthalf);
        end
        startnum = startnum + 1;
    end

    workspacea = "1" + join(repmat("0",1,ceil(strlength(current(2,1))/2)-1),"");
    doubleworkspace = workspacea+workspacea;
    while strlength(workspacea) <= ceil(strlength(current(2,1))/2)
        double2workspace = str2double(doubleworkspace);
        while double2workspace <= str2double(current(2,1))
            if double2workspace >= str2double(current(1,1))
                invalids = [invalids, double2workspace];
            end
            workspacea = str2double(workspacea) + 1;
            workspacea = string(workspacea);
            doubleworkspace = workspacea + workspacea;


            double2workspace = str2double(doubleworkspace);
        end
        workspacea = workspacea + "0";
    end

    realinvalids = realinvalids + sum(unique(invalids));
end

fprintf('Part 2: %d\n', realinvalids);
toc
% 11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124
% 82853534-82916516,2551046-2603239,805115-902166,3643-7668,4444323719-4444553231,704059-804093,32055-104187,7767164-7799624,25-61,636-1297,419403897-419438690,66-143,152-241,965984-1044801,1-19,376884-573880,9440956-9477161,607805-671086,255-572,3526071225-3526194326,39361322-39455443,63281363-63350881,187662-239652,240754-342269,9371-26138,1720-2729,922545-957329,3477773-3688087,104549-119841

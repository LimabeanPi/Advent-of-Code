clc; clear; close all;

inputs = input('input: ','s');
tic
data = readmatrix(inputs);

[l,~] = size(data);
maxi = 0;
for i = 1:l
    for k = 1:l
        if i > k
            xdist = abs(data(i,1) - data(k,1)) + 1;
            ydist = abs(data(i,2) - data(k,2)) + 1;
            square = xdist * ydist;
            if square > maxi
                maxi = square;
            end
        end
    end
end
fprintf('Part 1: %d\n', maxi);

pt2 = 0;
for i = 1:l
    for k = 1:l
        if i > k
            xdist = abs(data(i,1) - data(k,1)) + 1;
            ydist = abs(data(i,2) - data(k,2)) + 1;
            square = xdist * ydist;

            if square > pt2

                xmin = min(data(i,1), data(k,1));
                ymin = min(data(i,2), data(k,2));
                xmax = max(data(i,1), data(k,1));
                ymax = max(data(i,2), data(k,2));

                ispossible = true;
                x = xmin;
                while x >= xmin && x <= xmax && ispossible == 1   % Check all area/peri
                    loc = find(data(:,1) == x);
                    for a = 1:length(loc)
                        if data(loc(a),2) >= ymin && data(loc(a),2) <= ymax
                            if (data(loc(a),1) == xmax && data(loc(a),2) == ymax) || ...
                                    (data(loc(a),1) == xmax && data(loc(a),2) == ymin) || ...
                                    (data(loc(a),1) == xmin && data(loc(a),2) == ymax) || ...
                                    (data(loc(a),1) == xmin && data(loc(a),2) == ymin)

                            else
                                ispossible = false;
                            end

                        end
                    end
                    x = x + 1;
                end

                b = ymin;
                while b <= ymax && ispossible == 1              % Check pokey bits
                    loc = find(data(:,2) == b);
                    for c = 1:length(loc)
                        if (data(loc(c),1) < xmin && data(mod(loc(c),l) + 1, 1) > xmax) || ...
                                (data(loc(c),1) > xmax && data(mod(loc(c),1) + 1, 1) < xmin)
                            ispossible = false;
                        end
                    end
                    b = b + 1;
                end

                if ispossible == 1
                    % fprintf('new best acquired! %d\n', square); % pretty animations!
                    % close all;
                    % plot(data(:,1),data(:,2));
                    % hold on;
                    % plot([data(i,1), data(k,1), data(k,1), data(i,1), data(i,1)], ...
                    %     [data(i,2), data(i,2), data(k,2), data(k,2), data(i,2)], 'r-');
                    % drawnow;
                    pt2 = square;
                end
            end
        end
    end
end
fprintf('Part 2: %d\n', pt2);
toc

tran = tran(abs(tran(:,1)) >= 10, :);
clustercount = max(tran(:,4));
actclusters = zeros(clustercount,1);
tmp_tran = tran;

% Parameters
threshold = 1e-1;

% tran
%   1 - P
%   2 - Q
%   3 - ON (+1) or OFF (-1)
%   4 - cluster

% Separate each cluster in a different cell
% cp
%   1 - timestamp
%   2 - simultaneous appliances
%   3 - P
%   4 - Q
%   5 - ON (+1) or OFF (-1)

% List of points belonging to each cluster
cp = cell(clustercount, 1);
% List of indices of events where the appliances turned ON/OFF twice
twiceONOFF = cell(clustercount, 1);
% Covariance matrix of cluster
covPQ = zeros( 2,2, clustercount);
% Mean of cluster
mPQ = zeros(clustercount, 2);
% Assymmetry factor
afPQ = zeros(clustercount, 1);
% Cluster choice ranking
ccr = zeros(clustercount,1);
for i = 1:clustercount
    % Select all events that belong to cluster i
    ind = (tran(:,4) == i);
    % Select all events from cluster i that could be mixing events    
    aux = diff(tran(ind,3));
    if ~isempty(aux)        
        idx = find(ind);
        twiceONOFF{i} = idx( find(aux == 0)+1);
        % Calculates the number of simultaneous appliances
        app = cumsum(tran(ind,3));
        % Put all these points and their features in cp
        cp{i} = [ find(ind) app tran(ind, 1:3)];
        PQ = [cp{i}(:,5).*cp{i}(:,3) cp{i}(:,5).*cp{i}(:,4)];
        covPQ(:,:,i) = cov(PQ);
        mPQ(i,:) = mean(PQ);
        afPQ(i) = app(end)/numel(app);
        ccr(i) = app(end)*numel(app);
    end
end

% Order Cluster choice ranking
[~,Iccr] = sort(abs(ccr), 1, 'descend');
% Order Asymmetry factor
[~,Iaf] = sort(abs(afPQ), 1, 'descend');

timestamps = [];
figure;
% for each cluster, starting with one with most asymetry and more points
for i = Iccr'
    if abs(ccr(i)) > 0        
        % for each consecutive turn ON/OFF event
        for j = twiceONOFF{i}'         
            % get start and end of the window
            tsto = j;
            idx = find(cp{i}(:,1) == j,1);
            % If the point was removed somewhere in the process
            if isempty(idx)
                % Jump to next point
                continue;
            end
            tsfrom = cp{i}(idx-1,1);
            % Search for events within window by order of AF of cluster
            candidates = [];
            thechosenone = 0;
            thechosenonemetric = 0;
            for k = Iaf'
                % If the cluster is symmetric, don't touch it
                if (afPQ(k) == 0) || isempty(cp{k})
                    break;
                end;
                ind = find((cp{k}(:,1) > tsfrom) & (cp{k}(:,1) < tsto));
                if ~isempty(ind)
                    % Add these events to a list                    
                    candidates = [ candidates; [ind repmat(k, length(ind),1)] ];
                end
            end
            % For each candidate event, calculate the metrics            
            for cand = candidates'
                idx = cand(1);
                k = cand(2);                
                event = cp{k}(idx,3:4);
                                                
                % Find probability that the combination of the mixing event
                % more the missing event will produce another event close
                % to some cluster
                                                                                                           
                % Is a missing event an ON or an OFF?
                ONOFF1 = -tran(j, 3);
                % The missing ON/OFF event must be subtracted/summed from the
                % mixing event to find the other missing event
                PQ2 = event - ONOFF1*mPQ(i,:);
                % Then it must be flipped as ON to match with cluster
                ONOFF2 = sign(PQ2(1));
                PQ2 = ONOFF2*(PQ2);
                
                Lm = mPQ(k,:);
                LcovPQ = covPQ(:,:,k);                                
                event = sign(event(1))*(event);
                % The probability of the mixing event belongs to the
                % cluster it is
                Pc1 = exp(-1/2*(event - Lm)*(LcovPQ^-1)*(event - Lm)');
                
                Pc2 = 0;                
                for l = Iccr'
                   % if we are looking for an ON(OFF) event and the cluster
                   % only has more ON(OFF) events than OFF(ON) events, jump to next cluster 
                   if sign(afPQ(l))*sign(PQ2(1)) > 0
                       continue;
                   end;
                   
                   % if this cluster is different from the original and the
                   % one considered to be the mixing event
                   if (l ~= i) && (l ~= k)
                       Lm = mPQ(l,:,:);
                       LcovPQ = covPQ(:,:,l);
                       Pc2 = exp(-1/2*(PQ2 - Lm)*(LcovPQ^-1)*(PQ2 - Lm)');
                                             
                       Metric = abs(afPQ(k)*afPQ(l)*Pc2/Pc1);
                       % if sign of missing event ONOFF2 and the sign of the
                       % AF of the corresponding cluster match, put metric
                       % 0
                       Metric = Metric*( 1 - sign(ONOFF2)*sign(afPQ(l)) )/2;
                       
                       if (Metric > thechosenonemetric)
                           thechosenonemetric = Metric;
                           % The chosen one should contain the three cluster
                           % that get an extra point, the point that
                           % should be removed and the sign of the missing
                           % events of cluster i and l
                           thechosenone = [i l k idx ONOFF1 ONOFF2];
                       end
                   end                       
                end
            end
            % See if it is a valid metric
            if thechosenonemetric > threshold
                % Split candidate idx in cluster k into cluster i and l
                c1 = thechosenone(1);
                c2 = thechosenone(2);
                csplit = thechosenone(3);
                m1PQ = mPQ(c1, :);
                m2PQ = mPQ(c2, :);                
                tobesplit = cp{csplit}(thechosenone(4),3:4); 
                ONOFF1 = thechosenone(5);
                ONOFF2 = thechosenone(6);
                timestamp = cp{csplit}(thechosenone(4),1);
                timestamps = [timestamps; timestamp];
                
                e = tobesplit - (ONOFF1*m1PQ + ONOFF2*m2PQ);
                p1 = m1PQ + e/2;
                p2 = m2PQ + e/2;
                
                % Add points to clusters and remove from the other
                cp{c1} = [cp{c1}; timestamp 0 ONOFF1*p1 ONOFF1];
                cp{c2} = [cp{c2}; timestamp 0 ONOFF2*p2 ONOFF2];
                cp{csplit}(thechosenone(4),:)= [];
                
                % Update asymmetry factors of changed clusters
                asym = afPQ(c1)*(size(cp{c1},1)-1);
                afPQ(c1) = (asym + ONOFF1)/size(cp{c1},1);
                
                asym = afPQ(c2)*(size(cp{c2},1)-1);
                afPQ(c2) = (asym + ONOFF1)/size(cp{c2},1);
                
                asym = afPQ(csplit)*(size(cp{csplit},1)+1);
                afPQ(csplit) = (asym - sign(tobesplit(1)))/size(cp{csplit},1);
                                
                if isempty(cp{csplit})                    
                    Iccr(Iccr == thechosenone(3)) = [];
                    Iaf(Iaf == thechosenone(3)) = [];                    
                end
                % Remove events that were switched as 
                
                % Plot changes                
                hold on
                scatter(p1(1), p1(2));
                scatter(tobesplit(1), tobesplit(2), '*');
                scatter(p2(1), p2(2), '+');
                hold off
                
            end
        end
    end
end

figure;
colors = 'rgbkmyrgbkmyrgbkmyrgbkmyrgbkmyrgbkmyrgbkmy';
hold on
tran = [];
for i = 1:clustercount
    cpoints = sortrows(cp{i}, 1);
    tran = [tran; cpoints(:, 3:4) cpoints(:,5) repmat(i, size(cpoints,1), 1)]; 
    scatter(abs(cpoints(:,3)), cpoints(:,5).*cpoints(:,4), colors(i));    
end
hold off
load weekGaurav;

%plot((Gaurav(:,1) - Gaurav(1,1))*10^-9, Gaurav(:,2), (Gaurav(:,1) - Gaurav(1,1))*10^-9, Gaurav(:,3));
g = fspecial('gaussian', [21,1], 3);
Gaurav(:,2) = convn(Gaurav(:,2), g, 'same');
Gaurav(:,3) = convn(Gaurav(:,3), g, 'same');
Gaurav = Gaurav(20:end-20, :);

%Params
s = [10 10];
mincount = 20;

m = Gaurav(1,2:3);
t = Gaurav(1,1);
count = 1;

prem = [];
precount = [];
pret = [];
for i = 2:length(Gaurav)
    % If new sample is within limits of current plateau
    if abs(Gaurav(i, 2:3) - m) < s 
        m = m*count + Gaurav(i, 2:3);       
        count = count + 1;
        m = m/count;
    % Else if sample is within limits of previous plateau 
    elseif (~isempty(prem)) && (sum(abs(Gaurav(i, 2:3) - prem(end,:)) < s)) && (count < mincount)
        count = precount(end); precount(end) = [];
        m = prem(end,:); prem(end,:) = [];
        t = pret(end); pret(end) = [];
        m = m*count + Gaurav(i, 2:3);       
        count = count + 1;
        m = m/count;
    else
        % if last plateau lasted for mincount samples, register it
        if count >= mincount
            prem = [prem; m];
            precount = [precount; count];            
            pret = [pret; t];
        end
        m = Gaurav(i,2:3);
        t = Gaurav(i,1);
        count = 1;
    end    
end

tran = diff(prem);
scatter(abs(tran(:,1)), sign(tran(:,1)).*tran(:,2))
figure
plot(Gaurav(:,1), Gaurav(:,2:3), pret, prem, '*');

save('eventdetection');
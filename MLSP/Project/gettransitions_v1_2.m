load weekGaurav;

%plot((Gaurav(:,1) - Gaurav(1,1))*10^-9, Gaurav(:,2), (Gaurav(:,1) - Gaurav(1,1))*10^-9, Gaurav(:,3));
g = fspecial('gaussian', [13,1], 1.5);
Gaurav(:,2) = convn(Gaurav(:,2), g, 'same');
Gaurav(:,3) = convn(Gaurav(:,3), g, 'same');
Gaurav = Gaurav(20:end-20, :);
Gaurav(:,1) = (Gaurav(:,1) - Gaurav(1,1))*1e-9 ;
%Params
s = 0.6;
mincount = 10;
window = 40;

m = Gaurav(1,2:3);
t = Gaurav(1,1);
count = 1;

prem = [];
precount = [];
pret = [];
for i = 2:length(Gaurav)
    % If new sample is within limits of current plateau
    if norm(Gaurav(i, 2:3) - m) < s*sqrt(norm(m,1))
        % Limit average window to "window" 
        m = m*min(count, window) + Gaurav(i, 2:3);       
        count = count + 1;
        m = m/min(count, window + 1);        
    % Else if sample is within limits of previous plateau 
    elseif (~isempty(prem)) && (norm(Gaurav(i, 2:3) - prem(end,:)) < s*sqrt(norm(prem(end,:),1))) && (count < mincount)
        count = precount(end); precount(end) = [];
        m = prem(end,:); prem(end,:) = [];
        t = pret(end); pret(end) = [];
        m = m*min(count, window) + Gaurav(i, 2:3);       
        count = count + 1;
        m = m/min(count, window + 1);
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
tran = [tran sign(tran(:,1))];
hold on
scatter(abs(tran(tran(:,3) == 1,1)), tran(tran(:,3) == 1,2))
scatter(abs(tran(tran(:,3) == -1,1)), -tran(tran(:,3) == -1,2))
hold off
figure
plot(Gaurav(:,1), Gaurav(:,2:3), pret , prem, '*' );
figure
% Remove events with norm lower than 3
%pret = pret(sqrt(prem(:,1).^2 + prem(:,1).^2) > 3);
%precount = precount(sqrt(prem(:,1).^2 + prem(:,1).^2) > 3);
%prem = prem(sqrt(prem(:,1).^2 + prem(:,1).^2) > 3);
signs = tran(:,3);
P = tran(:,1);
Q = tran(:,2);
if size(tran,2) == 3
    tran = [tran zeros(length(tran),1)];
end;


tran( (abs(P) < 200) & (signs.*Q < -100)   ,4 ) = 1;

tran( (abs(P) < 200) & (signs.*Q > 100)    ,4) = 2;

tran( (abs(P) > 140) & (abs(P) < 200) & (signs.*Q > 0)      ,4) = 3;

tran( (abs(P) > 400) & (abs(P) < 600)      ,4) = 4;

tran( (abs(P) > 600) & (abs(P) < 700)      ,4) = 5;

tran( (abs(P) > 700) & (signs.*Q > 0)      ,4) = 6;

tran( (abs(P) > 800) & (signs.*Q < 0)      ,4) = 7;

% Low power
tran( (abs(P) < 20) & (signs.*(Q) < -20)      ,4) = 8;

tran( (abs(P) > 20) & (abs(P) < 40) & (signs.*Q > -40) & (signs.*Q < -10)      ,4) = 9;

tran( (abs(P) > 5) & (abs(P) < 16) & (signs.*Q > -20) & (signs.*Q < 20)        ,4) = 10;

tran( (abs(P) > 16) & (abs(P) < 30) & (signs.*Q > -10) & (signs.*Q < 10)      ,4) = 11;

tran( (abs(P) > 16) & (abs(P) < 40) & (signs.*Q > 10) & (signs.*Q < 30)       ,4) = 12;

tran( (abs(P) > 35) & (abs(P) < 56) & (signs.*Q > -10) & (signs.*Q < 10)     ,4) = 13;

tran( (abs(P) > 40) & (abs(P) < 50) & (signs.*Q > -40) & (signs.*Q < -10)      ,4) = 14;

tran( (abs(P) < 5)      ,4) = 15;

colors = 'rgbkmyrgbkmyrgbkmyrgbkmyrgbkmyrgbkmyrgbkmy';
hold on

for i = 1:max(tran(:,4))
    ind = ( tran(:, 4) == i ); 
    scatter(abs(P( ind ) ), signs(ind).*Q( ind ), colors(i));
end
hold off

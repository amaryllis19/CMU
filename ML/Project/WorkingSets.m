% %ambiguous data as negative = 0
ambiguous_context1 = [0;3003;5199;5101];
ambiguous_context2 = [0;5103;2901;2902];
working_set_1 = train_set;
for i=ambiguous_context1'
[m,n]=find(working_set_1(:,2)==i);
working_set_1(m,2)=0;
end

[m,n]=find(working_set_1(:,2)==3004);
working_set_1(m,2)=1;

[m,n]=find(working_set_1(:,2)~=1);
working_set_1(m,2)=0;

working_set_2 = train_set;
for i=ambiguous_context2'
[m,n]=find(working_set_2(:,2)==i);
working_set_2(m,2)=0;
end

[m,n]=find(working_set_2(:,2)==5102);
working_set_2(m,2)=1;

[m,n]=find(working_set_2(:,2)~=1);
working_set_2(m,2)=0;

% %%%%%for random positive negative labels of ambiguous data
working_set_3 = train_set;
for i=ambiguous_context1'
[m,n]=find(working_set_3(:,2)==i);
Index = shuffle(m,2);
s = round(size(Index,1)/2);
working_set_3(Index(1:s),2)=1;
working_set_3(Index(s+1:end),2)=0;
end

[m,n]=find(working_set_3(:,2)==3004);
working_set_3(m,2)=1;

[m,n]=find(working_set_3(:,2)~=1);
working_set_3(m,2)=0;

working_set_4 = train_set;
for i=ambiguous_context2'
[m,n]=find(working_set_4(:,2)==i);
Index = shuffle(m,2);
s = round(size(Index,1)/2);
working_set_4(Index(1:s),2)=1;
working_set_4(Index(s+1:end),2)=0;
end

[m,n]=find(working_set_4(:,2)==5102);
working_set_4(m,2)=1;

[m,n]=find(working_set_4(:,2)~=1);
working_set_4(m,2)=0;

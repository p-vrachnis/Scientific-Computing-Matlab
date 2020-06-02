function [blas_2]=polyvalm_MV(p,A,b)
% Author : Pavlos. Vrachnis , AM: 236010 , Date : 09/01/2020
%run before program A=rand(n); p=[1 14 71 154 120]; b=ones(n,1);

%thelw me blas-2 kai eksetazw an einai swsto me blas-3: polyvalm (p,A)*b
result=0;
for i=1:length(p)
    %reset to temp 
    temp=b;
    %pol/zw to mhtrwo A oses fores einai h dynamh tou
    for j=1:(length(p)-i) 
    temp=A*temp;
    end
    %pol/zw me ton syntelesth 
    temp=p(i)*temp;
    %prosthetw kathe fora to apotelesma tou temp sto result
    result= result+ temp;
end
blas_2=result;
end

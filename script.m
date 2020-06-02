%function [error,timer]=script(A)
% Author : Pavlos. Vrachnis , AM: 236010 , Date : 10/01/2020

%A=bcsstm07;
%A=C;
%A=P1;
%A=P2;
%A=P3;

%syntelestes p
p=[1 14 71 154 120];
%rizes
r=roots(p);
%vriskw ton arithmo twn grammwn kai twn sthlwn
rows=size(A,1);
columns=size(A,2);
n=rows;
%xrhsimopoiw to prohgoumeno erwthma anti gia polyvalm
b = polyvalm_MV(p,A,ones(n,1));
C = polyvalm(p,A);

%thetw to d ws mhtrwwo me 1 sth kyria diagwnio
d=zeros(n); 
for i=1:n
  d(i,i) = 1;
end

%backslash explicit
tic
for time=1:50
    result=C\b; 
end
temp=toc;
timer(1)=temp/50;
error(1)=norm(result-ones(n,1));

%serial + backslash
tic
for time=1:50
    result=b;
    for i=1:length(r)
        result=(A-r(length(r)-i+1)*d)\b;  
    end
end
toc
temp=toc;
timer(2)=temp/50;
error(2)=norm(result-ones(n,1));

tol=1e-7;
%serial + pcg 
tic 
for time=1:50
    result=b;
    for i=1:length(r)
        C=A-r(length(r)-i+1)*d;
        result=pcg(C,b,tol,50);
    end
end
toc
temp=toc;
timer(3)=temp/50;
error(3)=norm(result-ones(n,1));

%serial + pcg me prorithmisi block Jacobi dld thn diagonio toy A se mitrwo
tic
for t=1:50
    result=b;
    for i=1:length(r)
        C=A-r(length(r)-i+1)*d;
        result=pcg(C,b,tol,50,diag(diag(C)));
    end
end
toc
temp=toc;
timer(4)=temp/50;
error(4)=norm(result-ones(n,1));
%end
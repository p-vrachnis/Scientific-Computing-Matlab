
% Author : Pavlos. Vrachnis , AM: 236010 , Date : 07/01/2020
%Arxikopoiw to C mhtrwwo me mhdenika stoixeia
C=zeros(1000);
%ftiaxnw to C mhtrwo 
for i=1:1000
  C(i,i)=1+i^(1/2);
  for j=1:1000
    %an den einai sthn kyria diagwnio
    if not(i==j)
        C(i,j)=1/abs(i-j)^2;
    end
  end
 end
%ftianxw ta 3 Tk kai Sk
T1=toeplitz([30 -16 1 zeros(1,100-3)]);
S1=toeplitz([24 -12 zeros(1,10-2)]);
T2=toeplitz([30 -16 1 zeros(1,10-3)]);
S2=toeplitz([24 -12 zeros(1,100-2)]);
T3=toeplitz([30 -16 1 zeros(1,100-3)]);
S3=toeplitz([24 -12 zeros(1,100-2)]);

%ftianxw ta P(m,n)
d1=kd(100);
d2=kd(10);
P1=sparse(kron(d2,T1)+kron(S1,d1));
P2=sparse(kron(d1,T2)+kron(S2,d2));
P3=sparse(kron(d1,T3)+kron(S3,d1));

%fortwnw ta mhtrwa pairnontas to mtrwo A tou kathe mat file pou yparxei
%mesa sto problem
bcsstm07=load('bcsstm07.mat');
bcsstm07=bcsstm07.Problem.A;
email=load('email.mat');
email=email.Problem.A;

%ftianxw to alpha poy tha xreiastw gia epomeno erwthma opws 
%kai to p kai to b
alpha=(0.01:0.01:1);
%syntelestes p
p=[1 14 71 154 120];
b=ones(1133,1);

%ftiaxnw mhtrwo me 1 sth diagwnio 
function d = kd(n)
d=zeros(n); 
for i=1:n 
    d(i,i) = 1; 
end
end
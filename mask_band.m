function P=mask_band(n,type,p,q)
% Author : Pavlos. Vrachnis , AM: 236010 , Date : 02/01/2020

%run
%mask_band(5,"band",3,2)

%ean exei typo band
if type=="band"
%thetw ton pinaka me mhdenika stoxeia
P= zeros(n);    
%thetw thn kyria diagwnio 1
 for i=1:n
  P(i,i) = 1;
 %ean exei 3 orismata
  if nargin==3
   for j=(i+1):(i+p)
   P(i,j)= 1; 
   end
  else
   %yperdiagwnia stoxeia
   for j=(i+1):(i+q)
    P(i,j)= 1; 
   end
  end
  %ypodiagwnia stoxeia
  for j=(i-p):(i-1)
      if j>0
   P(i,j)= 1;
      end
  end
 end
%an exei typo btdr
elseif type=='btdr'
  r=mod(n,p);
  if r==n 
    P=ones(n);
  end 
  %limit=floor(n/p);
  limit = n/p;
  limit = round(limit);
  for i=1:limit
    %kyrio blok
    for j=p*(i-1)+1:p*i
       for z=p*(i-1)+1:p*i
           P(j,z)=1;
        end
    end
    %yperdiagwnio block
    for j=p*(i-1)+1:p*i
        for z=(p*i+1):p*i+p
           P(j,z)=1;
        end
    end
    %ypodiagwnio block
    for j=p*i+1:p*i+p
        for z=p*(i-1)+1:p*i
           P(j,z)=1;
        end
    end   
  end    
  %prosthetei ta ypoloipa
  for j=p*i+1:n
    for z=p*i+1:n
       P(j,z)=1;
    end
  end     
end
%krataw ta stoixeia pou thelw
P =P(1:n,1:n);
end









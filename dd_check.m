function [dflag,discrC,discrR] = dd_check(A)
% Author : Pavlos. Vrachnis , AM: 236010 , Date : 05/01/2020

%gia ton pinaka 2 allazw thn function se 
%function [N,dflag,reversable,symetric,dk,zone,checkz] = dd_check(A)
%gia na vrw ta zhtoumena

%vriskw to megethos se grammes kai sthles antistoixa
rows=size(A,1);
columns=size(A,2);

%lysh gia to erwthma 1.2 

%DK metavlhtes
discrR=0;
discrC=0;
%ADK metavlhtes
adk_R=1;
adk_C=1;
checkR=1;
checkC=1;
% %eksetazw gia ADK kai DK gia grammes
for i=1:rows
    sum=0;
    for j=1:rows
        if not(j==i)
        %vriskw to sum xwris to stoixeio ths kyrias diagwniou
        sum=sum+abs(A(i,j));
        end
    end
    %eksetazw gia ADK kai DK
    if abs(A(i,i))>=sum
         discrR=discrR+1;
         if checkR==1
          checkR=1;
         end
    else
        checkR=0;
        end
     if abs(A(i,i))>sum
         if adk_R==1   
            adk_R=1;
         end
     else
       adk_R=0;      
     end
    
end     
%eksetazw gia ADK kai DK gia sthles
  for i=1:columns
    sum=0;
    for j=1:columns
        if not(j==i)
         %vriskw to sum xwris to stoixeio ths kyrias diagwniou
        sum=sum+abs(A(j,i));
        end
    end
    %eksetazw gia ADK kai DK
    if abs(A(i,i))>=sum
        discrC=discrC+1;
        if checkC==1
        checkC=1;
        end
    else
        checkC=0;
    end
    if abs(A(i,i))>sum
            
        if adk_C==1
          adk_C=1;
        end
    else
        adk_C=0;
    end
  end
    
  if checkC && checkR ==1
    dflag=1;
    if adk_R==0
    discrR=0;
    end
    if adk_C==0  
    discrC=0;
    end
  else
    dflag=0;
    discrC=0;
    discrR=0;
  end
  
  
 %------------------------------%
 
%lysh gia ta zhtoumena tou pinaka 2
%symetrikothta
if rows ==columns
    symetric=1;
end
%N
N=rows;
%deikths katastash
dk = condest(A);

if not(det(A)==0)
    reversable=1;
else 
    reversable=0;
end

%{ 
elegxw an einai mhtrwo zwnhs:
dhladh an ta stoixeia ths kyrias diagwniou einai diafiora tou mhdenos kai meta
poses yperdiagwnous exei
poses yypodiagwnious exei
kai an ta loipa ektos autwn einai 0
%} 

zone(1)=1; %yperdiagwnios estw mh mhdenika
zone(2)=1; %ypodiagwnios estw mh mhdenika
zone(3)=0; %loipa stoixeia ektos diagwniou esto oti den einai 0
checkz=1; %estw oti einai band matrix
%checkdiag=1;
%eksetazw ta stoixeia thd kyrias diagwniou
for i=1:rows
   for j =1:rows
     if A(i,j)==0
         checkz=0;
         %checkdiag=0;
     end
   end
end

%an diagwnia diafora tou mhden
if checkz==1
%ypologizw to poses ypodiagwnioys kai yperdiagwnious exei
 zone(1)=1;
 zone(2)=1;
 zcount1=1;
 zcount2=1;
 for i=1:rows
   for j=1:rows
    if j==i+zcount1
        if A(i,j)==0
            zcount1=0;
        else
            if not(zcount1==0)
             zcount1=zcount1+1;
             zone(1)=zone(1)+1;
            end
        end
    elseif j==i-zcount2
        if A(i,j)==0
            zcount2=0;
        else
            if  not(zcount2==0)
             zcount2=zcount2+1;
             zone(2)=zone(2)+1;
            end
        end       
     end
   end
 end
 zone(1)=zone(1)-1;
 zone(2)=zone(2)-1;

 %eksetazw an ta stoixeia ektos diagwniou kai yper/ypodiagwnious einai 0  
 for i=1:rows
   for j =[1:i-zone(2),i+zone(1):rows]
        if not(A(i,j)==0)
            zone(3)=1;     
        end
   end
 end
   
 %an einai 0 tote einai band matrix
 if zone(3)==1
    checkz=1;
 else 
   checkz=0;
 end   
 end
if checkz==0
    zone(1)=0;
    zone(2)=0;
end 

end


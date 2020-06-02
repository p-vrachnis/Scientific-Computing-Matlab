function [X]=multiKatz(A,alpha,mth,pcg__parms)
% Author : Pavlos. Vrachnis , AM: 236010 , Date : 13/01/2020

%function [X,A,time,values,max_A,count,y,it0]=multiKatz(A,alpha,mth,pcg__parms)

%run before program alpha=(0.01:0.01:1);
%multiKatz(email,alpha,"direct")
%multiKatz(email,alpha,"pcg",{10^(-7),50})
%run after 
%norm((b-A*X),2)

%arxizw to metrhma
tic
b=ones(length(A),1);
r=size(A,1);
e=ones(r,1);
I=zeros(r); 
for i=1:r
  I(i,i) = 1;
end

X=[];
count=0;

    %backslash
    if mth=="direct"
        for i=1:length(alpha)
         temp=(I-alpha(i)*A);  
         %tsekarw an einai antistrepsimo meta tis prwtes prakseis
        if not(det(temp))==0 
            temp=temp\e;
           %tsekarw an ola ta stoixeia einai thetika meta thn 2h praksi
           if any(temp<0)
           else
               %an einai tote
               %metraw poses epanalhpseis kanei
               count=count+1;
               %krataw tis times
               values(:,count)=alpha(i);
               %kai prosthetw sto apotelesma
               X(:,count)=temp;  
           end    
        end  
        end
        
    %pcg
    elseif mth=="pcg" && length(pcg__parms)==2
        j=0;
        for i=1:length(alpha)
         temp=(I-alpha(i)*A); 
        %tsekarw an einai antistrepsimo meta tis prwtes prakseis
        if not(det(temp))==0    
             j=j+1;
            [temp,fl0,rr0,it0,rv0] = pcg(sparse(temp),e,pcg__parms{1},pcg__parms{2});
            %tsekarw an ola ta stoixeia einai thetika meta thn 2h praksi
            if any(temp)<=0
            else
                %an einai tote
                %metraw poses epanalhpseis kanei
                count=count+1;
                %krataw tis times
                values(:,count)=alpha(i);
                %kai prosthetw sto apotelesma
                X(:,count)=temp;   
               % y1(count)= norm(b-A*result,2);
            end         
        end 
        end
       
    %pcg + ichol
    else
        X2=[];
        count2=0;
         for i=1:length(alpha)
         temp2=(I-alpha(i)*A);
         %L=ichol(sparse(temp2));
        %tsekarw an einai antistrepsimo meta tis prwtes prakseis
        if not(det(temp2))==0    
            if size(pcg__parms)==4
            [temp2,fl2,rr2,it2,rv2] = pcg(sparse(temp2),e,pcg__parms{1},pcg__parms{2},pcg__parms{3},pcg__parms{4});
             else
               [temp2,fl2,rr2,it2,rv2] = pcg(sparse(temp2),e,pcg__parms{1},pcg__parms{2},pcg__parms{3});
            end
        end
            %tsekarw an ola ta stoixeia einai thetika meta thn 2h praksi
            if any(temp2)<=0
            else
                %an einai tote
                %metraw poses epanalhpseis kanei
                count2=count2+1;
                %krataw tis times
                values2(:,count2)=alpha(i);
                %kai prosthetw sto apotelesma
                X2(:,count2)=temp2;   
            end         
         end
    end     
  
toc
time=toc; %xronos
 
  
% gia ta apotelesmata    
if nargin >3
if length (pcg__parms) > 2
        rv0=rv2;
        it0=it2;
        X=X2;
        count=count2;
        values=values2;
        max_A=values2(count2); 
        [x,y]=sort(X2(:,1));
        y=y(1129:1133);
else

     max_A=values(count);
     [x,y]=sort(X(:,1));
     y=y(1129:1133);
end
else 
     max_A=values(count);
     [x,y]=sort(X(:,1));
     y=y(1129:1133);
end
%}

%gia to diagramma
%{ 
figure;
semilogy(0:it0,rv0,'-*b');
hold on;
semilogy(0:it2,rv2,'-Xr');
legend('No Preconditioner','Prec Ichol)');
xlabel('iteration number');
ylabel('| b-A*x |');
hold off;
%}

end



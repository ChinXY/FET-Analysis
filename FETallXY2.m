function [LF,LB,SF,SB] = FETallXY2(folder,CHLarray,type,Vds,Ids_col,Vgs_col,smFAC)
format short e;

%L=80e-6;
W=10e-3;
Ci=6e-5;

LF=zeros(2*size(CHLarray,2)+1,2+3*size(Vds,2));
LB=LF;
SF=LF;
SB=LB;

for y=1:size(Vds,2);
    LF(1,3*y)=Vds(1,y);   LF(1,3*y+1)=Vds(1,y); LF(1,3*y+2)=Vds(1,y);
    LB(1,3*y)=Vds(1,y);   LB(1,3*y+1)=Vds(1,y); LB(1,3*y+2)=Vds(1,y);
    SF(1,3*y)=Vds(1,y);   SF(1,3*y+1)=Vds(1,y); SF(1,3*y+2)=Vds(1,y);
    SB(1,3*y)=Vds(1,y);   SB(1,3*y+1)=Vds(1,y); SB(1,3*y+2)=Vds(1,y);
    
end
    
%DevPar(1)=L;
DevPar(2)=W;
DevPar(3)=Ci;

    for i=1:size(CHLarray,2)
        for j=1:3
            if j==1
                file=['L' num2str(CHLarray(1,i)) 'W10_trans_' type '1_a.csv'];
                %L20W10_trans_n1_a
                %D02C_L80W20_a_trans_n1
                %file=['D01B_L' num2str(CHLarray(1,i)) 'W20_a_trans_' type '.csv'];
                %file=['D01B_L' num2str(CHLarray(1,i)) 'W20_a_trans_p1.csv'];
            elseif j==2
                file=['L' num2str(CHLarray(1,i)) 'W10_trans_' type '1_b.csv'];
                %file=['D01B_L' num2str(CHLarray(1,i)) 'W20_b_trans_' type '.csv'];
                %file=['D01B_L' num2str(CHLarray(1,i)) 'W20_b_trans_p1.csv'];
            else
                file=['L' num2str(CHLarray(1,i)) 'W10_trans_' type '1_c.csv'];
                %file=['D01B_L' num2str(CHLarray(1,i)) 'W20_c_trans_' type '.csv'];
                %file=['D01B_L' num2str(CHLarray(1,i))
                %'W20_b_trans_p1.csv'];
            end
               
        DevPar(1)=CHLarray(1,i)*1e-6;
        [Mu_lin,Vth_lin,Vgs_lin,Mu_sat,Vth_sat,Vgs_sat] = FETanalysisXY(folder,file,Vds,Ids_col,Vgs_col,smFAC,DevPar);
        %[Mu_lin,Vth_lin,Vgs_lin,Mu_sat,Vth_sat,Vgs_sat] = FETxy_Analysis(folder,file,Vds,Ids_col,Vgs_col,smFAC,DevPar);
        display(['analysed ' num2str(2*i+j-2) ' / ' num2str(size(CHLarray,2)*3)]);%for displaying progress purpose
             
        LF(2*i-1+j,2)=j;LF(2*i-1+j,1)=DevPar(1);
        LB(2*i-1+j,2)=j;LB(2*i-1+j,1)=DevPar(1);
        SF(2*i-1+j,2)=j;SF(2*i-1+j,1)=DevPar(1);
        SB(2*i-1+j,2)=j;SB(2*i-1+j,1)=DevPar(1);    
            
            for x=1:size(Mu_lin,2)
                LF(2*i-1+j,3*x)=Mu_lin(1,x);  LF(2*i-1+j,3*x+1)=Vth_lin(1,x);   LF(2*i-1+j,3*x+2)=Vgs_lin(1,x);
                LB(2*i-1+j,3*x)=Mu_lin(2,x);  LB(2*i-1+j,3*x+1)=Vth_lin(2,x);   LB(2*i-1+j,3*x+2)=Vgs_lin(2,x);
                SF(2*i-1+j,3*x)=Mu_sat(1,x);  SF(2*i-1+j,3*x+1)=Vth_sat(1,x);   SF(2*i-1+j,3*x+2)=Vgs_sat(1,x);
                SB(2*i-1+j,3*x)=Mu_sat(2,x);  SB(2*i-1+j,3*x+1)=Vth_sat(2,x);   SB(2*i-1+j,3*x+2)=Vgs_sat(2,x);
                                
            end
        end
    end
end
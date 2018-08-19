function [LF,LB,SF,SB] = FETseriesXY(folder,rep,type,Vds,Ids_col,Vgs_col,smFAC)
format short e;
L=100e-6;
W=20e-3;
Ci=6e-5;

%[MAT1] = FETdataARR(folder,rep,Vds,Ids_col,Vgs_col,Vgs_size);
%[MAT2] = FETdataARR2(folder,rep,Vds,Ids_col,Vgs_col,Vgs_size);

LF=zeros(rep+1,1+3*size(Vds,2));
LB=LF;
SF=LF;
SB=LB;

for y=1:size(Vds);
    LF(1,3*y-1)=Vds(1,y);     LF(1,3*y)=Vds(1,y);   LF(1,3*y+1)=Vds(1,y);
    LB(1,3*y-1)=Vds(1,y);     LB(1,3*y)=Vds(1,y);   LB(1,3*y+1)=Vds(1,y);
    SF(1,3*y-1)=Vds(1,y);     SF(1,3*y)=Vds(1,y);   SF(1,3*y+1)=Vds(1,y);
    SB(1,3*y-1)=Vds(1,y);     SB(1,3*y)=Vds(1,y);   SB(1,3*y+1)=Vds(1,y);
    
DevPar(1)=L;
DevPar(2)=W;
DevPar(3)=Ci;

    for i=1:rep
        file=['L100W20_a_trans_' type num2str(i) '_-50V_RT.txt'];
        %L100W20_b_trans_n1_50V
        %file=['L100W20_b_trans_' type num2str(i) '_-50V.txt'];
        %file=['L80W20_FET1_trans_n' num2str(i) '_50V.txt'];
        %L80W20_FET1_trans_p15_-50V
        %[Mu_lin,Vth_lin,Vgs_lin,Mu_sat,Vth_sat,Vgs_sat] = FETxy_Analysis(folder,file,Vds,Ids_col,Vgs_col,smFAC,DevPar);
        [Mu_lin,Vth_lin,Vgs_lin,Mu_sat,Vth_sat,Vgs_sat] = FETanalysisXY(folder,file,Vds,Ids_col,Vgs_col,smFAC,DevPar);
        display(['analysed ' num2str(i) ' / ' num2str(rep)]);%for displaying progress purpose
             
        LF(i+1,1)=i;    LB(i+1,1)=i;    SF(i+1,1)=i;    SB(i+1,1)=i;    
            
            for x=1:size(Mu_lin,2)
                LF(i+1,3*x-1)=Mu_lin(1,x);    LF(i+1,3*x)=Vth_lin(1,x);    LF(i+1,3*x+1)=Vgs_lin(1,x);
                LB(i+1,3*x-1)=Mu_lin(2,x);    LB(i+1,3*x)=Vth_lin(2,x);    LB(i+1,3*x+1)=Vgs_lin(2,x);
                SF(i+1,3*x-1)=Mu_sat(1,x);    SF(i+1,3*x)=Vth_sat(1,x);    SF(i+1,3*x+1)=Vgs_sat(1,x);
                SB(i+1,3*x-1)=Mu_sat(2,x);    SB(i+1,3*x)=Vth_sat(2,x);    SB(i+1,3*x+1)=Vgs_sat(2,x);
            end
    end
    
    
end
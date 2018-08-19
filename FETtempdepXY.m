function [LF,LB,SF,SB] = FETtempdepXY(folder,TempDep,type,Vds,Ids_col,Vgs_col,smFAC)
format short e;

L=100e-6;
W=20e-3;
Ci=6e-5;

DevPar(1)=L;
DevPar(2)=W;
DevPar(3)=Ci;

LF=zeros(size(TempDep,2)+1,2+3*size(Vds,2));
LB=LF;
SF=LF;
SB=LB;

for y=1:size(Vds,2);
    LF(1,3*y)=Vds(1,y);   LF(1,3*y+1)=Vds(1,y);     LF(1,3*y+2)=Vds(1,y);
    LB(1,3*y)=Vds(1,y);   LB(1,3*y+1)=Vds(1,y);     LB(1,3*y+2)=Vds(1,y);
    SF(1,3*y)=Vds(1,y);   SF(1,3*y+1)=Vds(1,y);     SF(1,3*y+2)=Vds(1,y);
    SB(1,3*y)=Vds(1,y);   SB(1,3*y+1)=Vds(1,y);     SB(1,3*y+2)=Vds(1,y);
end
    
    for i=1:size(TempDep,2)
        file=['D10A_L100W20b_trans_' type '_' num2str(TempDep(1,i)) 'degC.csv'];
        %D10A_L100W20b_trans_n1_5degC
        %[Mu_lin,Vth_lin,Vgs_lin,Mu_sat,Vth_sat,Vgs_sat] = FETxy_Analysis(folder,file,Vds,Ids_col,Vgs_col,smFAC,DevPar);
        [Mu_lin,Vth_lin,Vgs_lin,Mu_sat,Vth_sat,Vgs_sat] = FETanalysisXY(folder,file,Vds,Ids_col,Vgs_col,smFAC,DevPar);
        display(['analysed ' num2str(i) ' / ' num2str(size(TempDep,2))]);%for displaying progress purpose
        
        LF(i+1,2)=273+TempDep(1,i);   LF(i+1,1)=TempDep(1,i);
        LB(i+1,2)=273+TempDep(1,i);   LB(i+1,1)=TempDep(1,i);
        SF(i+1,2)=273+TempDep(1,i);   SF(i+1,1)=TempDep(1,i);
        SB(i+1,2)=273+TempDep(1,i);   SB(i+1,1)=TempDep(1,i);    
            
            for x=1:size(Mu_lin,2)
                %LF(2*i-1+j,2*x+1)=Mu_lin(1,x);  LF(2*i-1+j,2*x+2)=Vth_lin(1,x);
                %LB(2*i-1+j,2*x+1)=Mu_lin(2,x);  LB(2*i-1+j,2*x+2)=Vth_lin(2,x);
                %SF(2*i-1+j,2*x+1)=Mu_sat(1,x);  SF(2*i-1+j,2*x+2)=Vth_sat(1,x);
                %SB(2*i-1+j,2*x+1)=Mu_sat(2,x);  SB(2*i-1+j,2*x+2)=Vth_sat(2,x);
                
                LF(i+1,3*x)=Mu_lin(1,x);  LF(i+1,3*x+1)=Vth_lin(1,x);   LF(i+1,3*x+2)=Vgs_lin(1,x);
                LB(i+1,3*x)=Mu_lin(2,x);  LB(i+1,3*x+1)=Vth_lin(2,x);   LB(i+1,3*x+2)=Vgs_lin(2,x);
                SF(i+1,3*x)=Mu_sat(1,x);  SF(i+1,3*x+1)=Vth_sat(1,x);   SF(i+1,3*x+2)=Vgs_sat(1,x);
                SB(i+1,3*x)=Mu_sat(2,x);  SB(i+1,3*x+1)=Vth_sat(2,x);   SB(i+1,3*x+2)=Vgs_sat(2,x);
                                
            end
        %end
    end
end
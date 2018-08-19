function [Mu_sat,Vth_sat,Mu_sat_SE,Vth_sat_SE,Vgs_sat,rsq_sat]=FETsaturationFIT(dir,Vgs,Ids,sqrtIds,Vds,smFAC,DevPar)
    
    L=DevPar(1);W=DevPar(2);Ci=DevPar(3);
    col=size(Vds,2);
    row=size(Vgs,1);
    
    %dummy parameters
    MSAT=zeros(1,col);
    VSAT=MSAT;
    MSAT_SE=MSAT;
    VSAT_SE=MSAT;
    VG_sat=MSAT;
    rsqSAT=MSAT; 
    
    %display parameters
    Mu_sat=zeros(1,col);
    Vth_sat=Mu_sat;
    Mu_sat_SE=Mu_sat;
    Vth_sat_SE=Mu_sat;
    Vgs_sat=Mu_sat;
    rsq_sat=Mu_sat; 
    
    % for plotting
    M_sat=zeros((size(Vgs,1)-smFAC+1),col);
    Vt_sat=M_sat;
    M_sat_SE=M_sat; 
    Vt_sat_SE=M_sat;
    rsq_0=M_sat;
    
        for j=1:col
            for i=1:(row-smFAC+1)
                xdata=squeeze(Vgs(i:(i+smFAC-1),1))';
                ydata=squeeze(sqrtIds(i:(i+smFAC-1),j))';
                y0=squeeze(Ids(i:(i+smFAC-1),j))';
                
                par0=polyfit(xdata,y0,1);
                par=polyfit(xdata,ydata,1);
                
                yfit=polyval(par,xdata);
                yresid  = yfit - ydata;
                SSresid = sum(yresid.^2);
                SStotal = (length(yfit)-1) * var(yfit);
                %SStotal = var(yfit);
                rsq     = 1 - SSresid/SStotal;
                MSE     = SSresid/(size(xdata,2)-2);
                SXX     = sum (xdata.^2);
                SE(1)   = sqrt(MSE)/sqrt(SXX);
                SE(2)   = sqrt(MSE)*sqrt(1/size(xdata,2));
                SEP(1)  =SE(1)/par(1);
                SEP(2)  =SE(2)/par(2);
        
        % for plotting
                M_sat(i,j)     =    (par(1)^2)*2*L/(Ci*W)*10000*sign(par0(1))*sign(Vds(1,j));    
                Vt_sat(i,j)    =    -par(2)/par(1);
                M_sat_SE(i,j)  =    sqrt(2)*SEP(1)*M_sat(i,j);
                Vt_sat_SE(i,j) =    Vt_sat(i,j)*sqrt(SEP(1)^2+SEP(2)^2);
                rsq_0(i,j)     =    rsq;
        
            if M_sat(i,j) > MSAT(1,j)
           % update output and display parameters
                Mu_sat(1,j)   = M_sat(i,j);
                Vth_sat(1,j)  = Vt_sat(i,j);
                Mu_sat_SE(1,j)= M_sat_SE(i,j);
                Vth_sat_SE(1,j)= Vt_sat_SE(i,j);
                Vgs_sat(1,j)  = Vgs(i+((smFAC-1)/2),1);
                rsq_sat(1,j)  = rsq_0(i,j);
           % update dummy parameters
                MSAT(1,j)=M_sat(i,j);
                VSAT(1,j)=Vt_sat(i,j);
                MSAT_SE(1,j)=M_sat_SE(i,j);
                VSAT_SE(1,j)=Vt_sat_SE(i,j);
                VG_sat(1,j)=Vgs(i+((smFAC-1)/2),1);
                rsqSAT(1,j)=rsq_0(i,j);
            else
           %update output and display = dummy parameters 
           %Mu_lin(dir,j)=MLIN(1,j);
           %Vth_lin(dir,j)=VLIN(1,j);
           %Mu_lin_SE(dir,j)= MLIN_SE(1,j);
           %Vth_lin_SE(dir,j)= VLIN_SE(1,j);
           %Vgs_lin(dir,j)=VG_lin(1,j);
           %rsq_lin(dir,j)=rsqLIN(1,j);
            end
            end
            
            
            if dir==1
                display (' ');
                display (['for saturation forward at Vds=' num2str(Vds(1,j)) ' V']);
                display (['Mu_sf  = ' num2str(Mu_sat(1,j)) ' cm2V-1s-1 and Vth_sf = ' num2str(Vth_sat(1,j)) ' V']);
                display (['at Vgs = ' num2str(Vgs_sat(1,j)) ' V and ' 'Rsquare= ' num2str(rsq_sat(1,j))]);
                                
                %display (['Mu_sf  = ' num2str(Mu_sat(1,j)) ' +/- ' num2str(Mu_sat_SE(1,j)) ' cm2V-1s-1']);
                %display (['Vth_sf = ' num2str(Vth_sat(1,j)) ' +/- ' num2str(Vth_sat_SE(1,j)) ' V'  ]);
                %display (['at Vgs = ' num2str(Vgs_sat(1,j)) ' V' ]);
                %display (['Rsquare= ' num2str(rsq_sat(1,j))]);
                elseif dir==2
            display (' ');
                display (['for saturation backward at Vds=' num2str(Vds(1,j)) ' V']);
                display (['Mu_sb  = ' num2str(Mu_sat(1,j)) ' cm2V-1s-1 and Vth_sb = ' num2str(Vth_sat(1,j)) ' V']);
                display (['at Vgs = ' num2str(Vgs_sat(1,j)) ' V and ' 'Rsquare= ' num2str(rsq_sat(1,j))]);
                %display (['Mu_sb  = ' num2str(Mu_sat(1,j)) ' +/- ' num2str(Mu_sat_SE(1,j)) ' cm2V-1s-1']);
                %display (['Vth_sb = ' num2str(Vth_sat(1,j)) ' +/- ' num2str(Vth_sat_SE(1,j)) ' V'  ]);
                %display (['at Vgs = ' num2str(Vgs_sat(1,j)) ' V' ]);
                %display (['Rsquare= ' num2str(rsq_sat(1,j))]);
            else
                display ('define direction of sweeping in FETsaturationFIT');
            end
            
            
        end

end
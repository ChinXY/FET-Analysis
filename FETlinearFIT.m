function [Mu_lin,Vth_lin,Mu_lin_SE,Vth_lin_SE,Vgs_lin,rsq_lin]=FETlinearFIT(dir,Vgs,Ids,Vds,smFAC,DevPar)
    
    L=DevPar(1);W=DevPar(2);Ci=DevPar(3);
    col=size(Vds,2);
    row=size(Vgs,1);
    
    %dummy parameters
    MLIN=zeros(1,col);
    VLIN=MLIN;
    MLIN_SE=MLIN;
    VLIN_SE=MLIN;
    VG_lin=MLIN;
    rsqLIN=MLIN; 
    
    %display parameters
    Mu_lin=zeros(1,col);
    Vth_lin=Mu_lin;
    Mu_lin_SE=Mu_lin;
    Vth_lin_SE=Mu_lin;
    Vgs_lin=Mu_lin;
    rsq_lin=Mu_lin; 
    
    % for plotting
    M_lin=zeros((size(Vgs,1)-smFAC+1),col);
    Vt_lin=M_lin;
    M_lin_SE=M_lin; 
    Vt_lin_SE=M_lin;
    rsq_0=M_lin;
    
        for j=1:col
            for i=1:(row-smFAC+1);
                xdata=squeeze(Vgs(i:(i+smFAC-1),1))';
                ydata=squeeze(Ids(i:(i+smFAC-1),j))';
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
        
        %for plotting
                M_lin(i,j)     =    par(1)*L/(Ci*W*Vds(j))*10000;    
                Vt_lin(i,j)    =    -par(2)/par(1);
                M_lin_SE(i,j)  =    SEP(1)*M_lin(i,j);
                Vt_lin_SE(i,j) =    Vt_lin(i,j)*sqrt(SEP(1)^2+SEP(2)^2);
                rsq_0(i,j)     =    rsq;
        
            if M_lin(i,j) > MLIN(1,j)
           % update output and display parameters
                Mu_lin(1,j)   = M_lin(i,j);
                Vth_lin(1,j)  = Vt_lin(i,j);
                Mu_lin_SE(1,j)= M_lin_SE(i,j);
                Vth_lin_SE(1,j)= Vt_lin_SE(i,j);
                Vgs_lin(1,j)  = Vgs(i+((smFAC-1)/2),1);
                rsq_lin(1,j)  = rsq_0(i,j);
           % update dummy parameters
                MLIN(1,j)=M_lin(i,j);
                VLIN(1,j)=Vt_lin(i,j);
                MLIN_SE(1,j)=M_lin_SE(i,j);
                VLIN_SE(1,j)=Vt_lin_SE(i,j);
                VG_lin(1,j)=Vgs(i+((smFAC-1)/2),1);
                rsqLIN(1,j)=rsq_0(i,j);
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
                display (['for linear forward at Vds=' num2str(Vds(1,j)) ' V']);
                display (['Mu_lf  = ' num2str(Mu_lin(1,j)) ' cm2V-1s-1 and Vth_lf = ' num2str(Vth_lin(1,j)) ' V']);
                display (['at Vgs = ' num2str(Vgs_lin(1,j)) ' V and ' 'Rsquare= ' num2str(rsq_lin(1,j))]);
                %display (['Mu_lf  = ' num2str(Mu_lin(1,j)) ' +/- ' num2str(Mu_lin_SE(1,j)) ' cm2V-1s-1']);
                %display (['Vth_lf = ' num2str(Vth_lin(1,j)) ' +/- ' num2str(Vth_lin_SE(1,j)) ' V'  ]);
                %display (['at Vgs = ' num2str(Vgs_lin(1,j)) ' V' ]);
                %display (['Rsquare= ' num2str(rsq_lin(1,j))]);
                elseif dir==2
            display (' ');
                display (['for linear backward at Vds=' num2str(Vds(1,j)) ' V']);
                display (['Mu_lb  = ' num2str(Mu_lin(1,j)) ' cm2V-1s-1 and Vth_lb = ' num2str(Vth_lin(1,j)) ' V']);
                display (['at Vgs = ' num2str(Vgs_lin(1,j)) ' V and ' 'Rsquare= ' num2str(rsq_lin(1,j))]);
                %display (['Mu_lb  = ' num2str(Mu_lin(1,j)) ' +/- ' num2str(Mu_lin_SE(1,j)) ' cm2V-1s-1']);
                %display (['Vth_lb = ' num2str(Vth_lin(1,j)) ' +/- ' num2str(Vth_lin_SE(1,j)) ' V'  ]);
                %display (['at Vgs = ' num2str(Vgs_lin(1,j)) ' V' ]);
                %display (['Rsquare= ' num2str(rsq_lin(1,j))]);
            else
                display ('define direction of sweeping in FETlinFIT');
            end
            
            
        end

end
    %figure('Units','pixels','Position',[100 100 1000 500]);
    %subplot(2,3,1)
    
    %subplot(2,2,1);errorbar(x,mu,sigma,'x');
    %xlabel('R2','FontSize',12,'FontWeight','bold');
    %ylabel('mu(deg)','FontSize',12,'FontWeight','bold');
    %xlim([-0.05 1]);
    
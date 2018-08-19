function [Mu_lin,Vth_lin,Vgs_lin,Mu_sat,Vth_sat,Vgs_sat] = FETxy_Analysis(folder,file,Vds,Ids_col,Vgs_col,smFAC,DevPar)
    format short e;
    filename = [folder '\' file];
    
    display(' ');
    display(' ');
    display(['For ' file]);
    display(['L  = ' num2str(DevPar(1)) ' m, ' 'W  = ' num2str(DevPar(2)) ' m, ' 'Ci = ' num2str(DevPar(3)) ' Fm-2']);
    %display(['W  = ' num2str(DevPar(2)) ' m']);
    %display(['Ci = ' num2str(DevPar(3)) ' Fm-2']);
    display(['smFAC = ' num2str(smFAC)]);
    
    A   = importdata(filename); 
    col = size(Vds,2);
    row = size(A.data,1);
    %row = size(A,1);
    Ids      = zeros(row,col);
    Vgs      = Ids; 
    absIds   = Ids;
    sqrtIds  = Ids;
    
    %L=DevPar(1);W=DevPar(2);Ci=DevPar(3);
    
    for j=1:col
        for i=1:row
            Ids(i,j)=A.data(i,Ids_col+j-1);
            %Ids(i,j)=A(i,Ids_col+j-1);
            absIds(i,j)=abs(Ids(i,j));
            sqrtIds(i,j)=sqrt(absIds(i,j));
        end
    end
    for j=1:col
        for i=1:row
            Vgs(i,j)=A.data(i,Vgs_col+j-1);
            %Vgs(i,j)=A(i,Vgs_col+j-1);
        end
    end

    
    if mod(row,2)==0;
        %Ids_f=Ids(1:(row/2),:);
        %Ids_b=Ids((row/2+1):row,:);
        absIds_f=absIds(1:(row/2),:);
        absIds_b=absIds((row/2+1):row,:);
        sqrtIds_f=sqrtIds(1:(row/2),:);
        sqrtIds_b=sqrtIds((row/2+1):row,:);
        
        Vgs_f=Vgs(1:(row/2),col);
        Vgs_b=Vgs((row/2+1:row),col);
    else
        %Ids_f=Ids(1:((row+1)/2),:);
        %Ids_b=Ids(((row+1)/2+1):row,:);
        absIds_f=absIds(1:((row+1)/2),:);
        absIds_b=absIds(((row+1)/2+1):row,:);
        sqrtIds_f=sqrtIds(1:((row+1)/2),:);
        sqrtIds_b=sqrtIds(((row+1)/2+1):row,:);
        
        Vgs_f=Vgs(1:((row+1)/2),col);
        Vgs_b=Vgs(((row+1)/2+1):row,col);

    end
    
    [Mu_linf,Vth_linf,~,~,Vgs_linf,~]=FETlinearFIT(1,Vgs_f,absIds_f,Vds,smFAC,DevPar);
    [Mu_linb,Vth_linb,~,~,Vgs_linb,~]=FETlinearFIT(2,Vgs_b,absIds_b,Vds,smFAC,DevPar);
    
    Mu_lin(1,:)=Mu_linf;     Mu_lin(2,:)=Mu_linb;
    Vth_lin(1,:)=Vth_linf;   Vth_lin(2,:)=Vth_linb;
    Vgs_lin(1,:)=Vgs_linf;   Vgs_lin(2,:)=Vgs_linb;
    
    [Mu_satf,Vth_satf,~,~,Vgs_satf,~]=FETsaturationFIT(1,Vgs_f,absIds_f,sqrtIds_f,Vds,smFAC,DevPar);
    [Mu_satb,Vth_satb,~,~,Vgs_satb,~]=FETsaturationFIT(2,Vgs_b,absIds_b,sqrtIds_b,Vds,smFAC,DevPar);
    
    Mu_sat(1,:)=Mu_satf;    Mu_sat(2,:)=Mu_satb;
    Vth_sat(1,:)=Vth_satf;  Vth_sat(2,:)=Vth_satb;
    Vgs_sat(1,:)=Vgs_satf;  Vgs_sat(2,:)=Vgs_satb;  
end
function [Vgs,Ids,absIds,sqrtIds] = FETdataimport1(folder,file,Vds,Ids_col,Vgs_col)
    format short e;
    filename = [folder '\' file];
    
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

    
end
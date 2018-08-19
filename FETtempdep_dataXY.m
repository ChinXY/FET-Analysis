function [MAT1,MAT2] = FETtempdep_dataXY(folder,TempDep,type,Vds,Ids_col,Vgs_col,Vgs_size)
    format short e;
    MAT1=zeros(Vgs_size+3,2*size(TempDep,2)*size(Vds,2));
    MAT2=MAT1;
    for i=1:size(TempDep,2)
        file=['D10A_L100W20b_trans_' type '_' num2str(TempDep(1,i)) 'degC.csv'];
        %file=['D10A_L100W20b_trans_n2_' num2str(TempDep(1,i)) 'degC.csv'];
        %
        display(['importing data from ' file]);
        [Vgs,~,absIds,~] = FETdataimport1(folder,file,Vds,Ids_col,Vgs_col);
        %[Vgs,~,absIds,~] = FETdataimport2(folder,file,Vds,Ids_col,Vgs_col);
        for j=1:size(Vds,2)
            for k=1:size(Vgs,1)
            MAT1(1,2*(i-1)*size(Vds,2)+2*j-1)       = TempDep(1,i);
            MAT1(1,2*(i-1)*size(Vds,2)+2*j)         = TempDep(1,i);
            MAT1(2,2*(i-1)*size(Vds,2)+2*j-1)       = TempDep(1,i)+273;
            MAT1(2,2*(i-1)*size(Vds,2)+2*j)         = TempDep(1,i)+273;
            MAT1(3,2*(i-1)*size(Vds,2)+2*j-1)       = Vds(1,j);
            MAT1(3,2*(i-1)*size(Vds,2)+2*j)         = Vds(1,j);
            MAT1(k+3,2*(i-1)*size(Vds,2)+2*j-1)     = Vgs(k,1);
            MAT1(k+3,2*(i-1)*size(Vds,2)+2*j)       = absIds(k,j);
            
            MAT2(1,2*(j-1)*size(TempDep,2)+2*i-1)   = TempDep(1,i);
            MAT2(1,2*(j-1)*size(TempDep,2)+2*i)     = TempDep(1,i);
            MAT2(2,2*(j-1)*size(TempDep,2)+2*i-1)   = TempDep(1,i)+273;
            MAT2(2,2*(j-1)*size(TempDep,2)+2*i)     = TempDep(1,i)+273;
            MAT2(3,2*(j-1)*size(TempDep,2)+2*i-1)   = Vds(1,j);
            MAT2(3,2*(j-1)*size(TempDep,2)+2*i)     = Vds(1,j);
            MAT2(k+3,2*(j-1)*size(TempDep,2)+2*i-1) = Vgs(k,1);
            MAT2(k+3,2*(j-1)*size(TempDep,2)+2*i)   = absIds(k,j);
            end
        end
    end    
end
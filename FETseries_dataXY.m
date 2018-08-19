function [MAT1, MAT2] = FETseries_dataXY(folder,rep,type,Vds,Ids_col,Vgs_col,Vgs_size)
    format short e;
    MAT1=zeros(Vgs_size+2,2*rep*size(Vds,2));
    MAT2=MAT1;
     
    for i=1:rep
        file=['L100W20_a_trans_' type num2str(i) '_-50V_RT.txt'];
        %file=['L80W20_FET1_trans_n' num2str(i) '_50V.txt'];
        %file=['L80W20_FET1_trans_p' num2str(i) '_-50V.txt'];
        display(['importing data from ' file]);
        [Vgs,~,absIds,~] = FETdataimport1(folder,file,Vds,Ids_col,Vgs_col);
        %[Vgs,~,absIds,~] = FETdataimport2(folder,file,Vds,Ids_col,Vgs_col);
        for j=1:size(Vds,2)
            for k=1:size(Vgs,1)
            MAT1(1,2*(i-1)*size(Vds,2)+2*j-1)  = i;
            MAT1(1,2*(i-1)*size(Vds,2)+2*j)    = i;
            MAT1(2,2*(i-1)*size(Vds,2)+2*j-1)  = Vds(1,j);
            MAT1(2,2*(i-1)*size(Vds,2)+2*j)    = Vds(1,j);
            MAT1(k+2,2*(i-1)*size(Vds,2)+2*j-1)= Vgs(k,1);
            MAT1(k+2,2*(i-1)*size(Vds,2)+2*j)  = absIds(k,j);
            
            MAT2(1,2*(j-1)*rep+2*i-1)  = i;
            MAT2(1,2*(j-1)*rep+2*i)    = i;
            MAT2(2,2*(j-1)*rep+2*i-1)  = Vds(1,j);
            MAT2(2,2*(j-1)*rep+2*i)    = Vds(1,j);
            MAT2(k+2,2*(j-1)*rep+2*i-1)= Vgs(k,1);
            MAT2(k+2,2*(j-1)*rep+2*i)  = absIds(k,j);
            end
        end
    end



            
            
end

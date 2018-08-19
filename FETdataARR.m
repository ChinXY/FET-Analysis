function [MAT] = FETdataARR(folder,rep,Vds,Ids_col,Vgs_col,Vgs_size)
    format short e;
    MAT=zeros(Vgs_size+2,2*rep*size(Vds,2));
        
    for i=1:rep
        file=['L80W20_FET1_trans_n' num2str(i) '_50V.txt'];
        %file=['L80W20_FET1_trans_p' num2str(i) '_-50V.txt'];
        display(['importing data from ' file]);
        [Vgs,~,absIds,~] = FETdataimport1(folder,file,Vds,Ids_col,Vgs_col);
        %[Vgs,~,absIds,~] = FETdataimport2(folder,file,Vds,Ids_col,Vgs_col);
        for j=1:size(Vds,2)
            for k=1:size(Vgs,1)
            MAT(1,2*(i-1)*size(Vds,2)+2*j-1)  = i;
            MAT(1,2*(i-1)*size(Vds,2)+2*j)    = i;
            MAT(2,2*(i-1)*size(Vds,2)+2*j-1)  = Vds(1,j);
            MAT(2,2*(i-1)*size(Vds,2)+2*j)    = Vds(1,j);
            
            MAT(k+2,2*(i-1)*size(Vds,2)+2*j-1)= Vgs(k,1);
            MAT(k+2,2*(i-1)*size(Vds,2)+2*j)  = absIds(k,j);
            
            end
        end
    end
    
    
end

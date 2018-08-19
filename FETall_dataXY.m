function [MAT1,MAT2] = FETall_dataXY(folder,CHLarray,type,Vds,Ids_col,Vgs_col,Vgs_size)
    format short e;
    MAT1=zeros(Vgs_size+3,4*size(CHLarray,2)*size(Vds,2));
    MAT2=MAT1;
    for i=1:size(CHLarray,2)
        for x=1:2
            if x==1
                file=['PCBM_FET_L' num2str(CHLarray(1,i)) 'W10_trans_' type '1_c.csv'];
                %file=['D01B_L' num2str(CHLarray(1,i)) 'W20_a_trans_p1.csv'];
                else
                file=['PCBM_FET_L' num2str(CHLarray(1,i)) 'W10_trans_' type '1_c.csv'];
                %file=['D01B_L' num2str(CHLarray(1,i)) 'W20_b_trans_p1.csv'];
            end
            display(['importing data from ' file]);
            [Vgs,~,absIds,~] = FETdataimport1(folder,file,Vds,Ids_col,Vgs_col);
            %[Vgs,~,absIds,~] = FETdataimport2(folder,file,Vds,Ids_col,Vgs_col);
            for j=1:size(Vds,2)
                for k=1:size(Vgs,1)
                MAT1(1,4*(i-1)*size(Vds,2)+2*(x-1)*size(Vds,2)+2*j-1)       = x;
                MAT1(1,4*(i-1)*size(Vds,2)+2*(x-1)*size(Vds,2)+2*j)         = x;
                MAT1(2,4*(i-1)*size(Vds,2)+2*(x-1)*size(Vds,2)+2*j-1)       = CHLarray(1,i);
                MAT1(2,4*(i-1)*size(Vds,2)+2*(x-1)*size(Vds,2)+2*j)         = CHLarray(1,i);
                MAT1(3,4*(i-1)*size(Vds,2)+2*(x-1)*size(Vds,2)+2*j-1)       = Vds(1,j);
                MAT1(3,4*(i-1)*size(Vds,2)+2*(x-1)*size(Vds,2)+2*j)         = Vds(1,j);
                MAT1(k+3,4*(i-1)*size(Vds,2)+2*(x-1)*size(Vds,2)+2*j-1)     = Vgs(k,1);
                MAT1(k+3,4*(i-1)*size(Vds,2)+2*(x-1)*size(Vds,2)+2*j)       = absIds(k,j);
            
                MAT2(1,4*(j-1)*size(CHLarray,2)+2*x+4*i-3-2)      = x;
                MAT2(1,4*(j-1)*size(CHLarray,2)+2*x+4*i-2-2)      = x;
                MAT2(2,4*(j-1)*size(CHLarray,2)+2*x+4*i-3-2)      = CHLarray(1,i);
                MAT2(2,4*(j-1)*size(CHLarray,2)+2*x+4*i-2-2)      = CHLarray(1,i);
                MAT2(3,4*(j-1)*size(CHLarray,2)+2*x+4*i-3-2)      = Vds(1,j);
                MAT2(3,4*(j-1)*size(CHLarray,2)+2*x+4*i-2-2)      = Vds(1,j);
                MAT2(k+3,4*(j-1)*size(CHLarray,2)+2*x+4*i-3-2)    = Vgs(k,1);
                MAT2(k+3,4*(j-1)*size(CHLarray,2)+2*x+4*i-2-2)    = absIds(k,j);
                end
            end
        end
    end    
end
function [ruido, coords] = create_ruido(h, percentil)
[tamx tamy] = size(h);
vezes= round(tamx*tamy*percentil);
%disp(['Quantidade de ruído: ' num2str(vezes) ]);
%disp(['TamX: ' num2str(tamx)]);
%disp(['TamY: ' num2str(tamy)]);


%função recebe a matriz que será alterada e o número de vezes que será
%alterada
    ruido = h;
    coords= zeros(vezes, 2);
    for i = 1:vezes
        x = randi([1 tamx]);
        y = randi([1 tamy]);
        coords(i,:)=[ x y ];
        if h(x, y) == 0
            ruido(x, y) =1;
        else
           ruido(x, y) =0;
        end
    end
end

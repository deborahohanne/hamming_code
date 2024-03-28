function ruido = criar_ruido(h, vezes)
%função recebe a matriz que será alterada e o número de vezes que será
%alterada
    ruido = h;
    [tamx tamy] = size(h);

    for i = 1:vezes
        x = randi([1 tamx]);
        y = randi([1 tamy]);
        if h(x, y) == 0
            ruido(x, y) =1;
        else
           ruido(x, y) =0;
        end
    end

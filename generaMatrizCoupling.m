%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%                      Script: CompruebaNorma                       %%%%
%%%%                                                                   %%%%
%%%%            En esta funci�n se va a generar la matriz              %%%%
%%%%      de correlaci�n o coupling entre los diferentes elementos     %%%%
%%%%      del array en transmisi�n. Para ello se generar�n numeros     %%%%
%%%%     aleatorios entre 0 y 1 siendo 1 la mayor de las correlaciones %%%%
%%%%      entre antenas. La salida de esta fuciu�n es una mtriz de     %%%%
%%%%               acoplamiento de orden [ntx X ntx].                  %%%%
%%%%                                                                   %%%%
%%%%          Para hacerlo algo m�s realista el vector aleatorio de    %%%% 
%%%%          correlaciones entre  antenas ser� ordenado de mayor a    %%%%
%%%%           menor para que refleje la mayor  correlaci�n entre      %%%%
%%%%                     mas antenas cercanas.                         %%%%
%%%%                                                                   %%%%
%%%%     Esta matriz ser� utilizada en la funci�n generaCanalQuadriga  %%%%
%%%%                                                                   %%%%
%%%%                                                                   %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



function [matriz_coupling] = generaMatrizCoupling(ntx)

N = 4;  % Numero de antenas que afectan a la correlaciu�n de una dada;

% Generamos la matriz identidad (matriz en la que se supone que no hay
% correlaci�n entre antenas)

matriz_coupling_inicial = eye(ntx);

for i = 1:ntx
    
    vector_acoplamiento = rand(1,N/2);  % Se va a suponer acoplamiento s�lo para las 10 antenas colindantes con la antena en cuesti�n;
    vector_acoplamiento2 = rand(1,N/2);
    
    vector_acoplamiento_ordenado = sort(vector_acoplamiento);
    vector_acoplamiento_ordenado2 = sort(vector_acoplamiento2,'descend');

    if N/2 < i
        matriz_coupling_inicial((i-N/2):i-1,i) = vector_acoplamiento_ordenado;
    else
        matriz_coupling_inicial(1:i,i) = vector_acoplamiento_ordenado(1:i);
    end
    
    if N/2 > (ntx-i)
        matriz_coupling_inicial(i+1:end,i) = vector_acoplamiento_ordenado2(1:(ntx-i));
    else
        matriz_coupling_inicial(i+1:(i+N/2) ,i) = vector_acoplamiento_ordenado2;
    end
    
    matriz_coupling_inicial(i,i) = 1;
    
end

matriz_coupling = matriz_coupling_inicial;

end
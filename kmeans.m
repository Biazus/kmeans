pkg load geometry

matrixData = dlmread("dist2.txt"); %converte arquivo de entrada para matriz 100 por 2
ndims (matrixData);
nRows = size(matrixData,1);
k=2;
rand_rows = randperm(nRows, k); %seleciona dois pontos aleatoriamente
randPoints = matrixData(rand_rows,:);

matrixOfClusters=zeros(100, 1);
matrixOfDistances=zeros(100, 1);
matrixOfSums=zeros(k,1);
numberOfInstances=zeros(k,1);
continuar=1;

while(continuar==1) %continua até que nao haja mudança nos centros
  for i = 1:rows(matrixData)
    lowestDistance=10000;
    for j = 1:k
      d=distancePoints([matrixData(i,1),matrixData(i,2)], [randPoints(j,1),randPoints(j,2)]);
      if(d<lowestDistance)
          lowestDistance=d;
          matrixOfClusters([i,1])=j;
          matrixOfDistances([i,1])=d;
      endif
    endfor
  endfor

  % redefinindo o centro
  for l = 1:k
    numberOfInstances=0;
    sumOfX=0; %soma total dos valores de x na instancia k
    sumOfY=0; %soma total dos valores de y na instancia k
    for m = 1:size(matrixOfClusters,1)
      if(matrixOfClusters(m,1)==l)
        numberOfInstances++;
        sumOfX += matrixData(m,1);
        sumOfY += matrixData(m,2);
      endif
    endfor
    newX=sumOfX/numberOfInstances;
    newY=sumOfY/numberOfInstances;
    continuar=0;   
    if(newX!=randPoints(l,1) || newY!=randPoints(l,2))%checa se houve mudanças nos centros
      continuar=1;
    endif
    randPoints(l,1)=newX;  %define novos centros
    randPoints(l,2)=newY;
  endfor
endwhile

scatter(matrixData(:,1),matrixData(:,2),6,matrixOfClusters(:,1),'filled'); 
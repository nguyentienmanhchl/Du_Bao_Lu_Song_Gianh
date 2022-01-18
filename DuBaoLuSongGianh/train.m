%x01=xlsread('DataTrain.xlsx','E478:G8716');
%x02 =xlsread('DataTrain.xlsx','D478:D8716');
x01=xlsread('DataTrain.xlsx','E478:G7308');
x02 =xlsread('DataTrain.xlsx','D478:D7308');
x03=fillmissing(x02,'previous');
for i =1:12
    x04(i,:)=[0,0,0];
end
for i = 13:length(x01)
    x04(i,:) = [0,0,0];
    for j = 1:12
        x04(i,:)=x04(i,:)+x01(i-j,:);
    end
   
end
for i = 1:length(x01)
    x05(i) = x04(i,1)+x04(i,2)+x04(i,3);
end
max5 = max(x05);
min5 = min(x05);
x06 = xlsread('Htrieu.xlsx','B3:B6833');
%x06 = xlsread('Htrieu.xlsx','B3:B8241');
%x = [x03,x01,x05'];

x= [x03,x01,x06];
y0=xlsread('DataTrain.xlsx','C479:C7309');
y =fillmissing(y0,'previous');

n=5;
%histogram(x(:,1),10);
%plot(x(:,1),y,'o');
y2 = log(1+y-min(y));


for i = 1:n
   
  x2(:,i) = (x(:,i)-min(x(:,i)))/(max(x(:,i))-min(x(:,i)));
end
%histogram(x2(:,n),10);
%plot(x2(:,1),y2,'o');
xt =x2';
yt=y2';
hiddenLayerSize = 8;
net = fitnet(hiddenLayerSize);
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 30/100;
net.divideParam.testRatio = 0/100;
[net,tr] = train(net,xt,yt);
%determine the error of the ANN
yTrain = exp(net(xt(:,tr.trainInd)))-1+min(y);
yTrainTrue = exp(yt(tr.trainInd))-1+min(y);

yVal = exp(net(xt(:,tr.valInd)))-1+min(y);
yValTrue = exp(yt(tr.valInd))-1+min(y);



dem = 0;
for i=1:length(yVal)
    if abs(yVal(i)-yValTrue(i))< 30
        dem =dem + 1;
    end
end
H = dem/ length(yVal);


%du doan 12h
%xt(:,8239)=[];
xt(:,6831)=[];
x07=x2(:,5);
xt(5,:)=[];
x07(1)=[];
xt2=[xt',x07];
yt(:,1)=[];
net1 = fitnet(hiddenLayerSize);
net1.divideParam.trainRatio = 70/100;
net1.divideParam.valRatio = 30/100;
net1.divideParam.testRatio = 0/100;
[net1,tr] = train(net1,xt2',yt);
x12=xt2';
yTrain12 = exp(net1(x12(:,tr.trainInd)))-1+min(y);
yTrainTrue12 = exp(yt(tr.trainInd))-1+min(y);

yVal12 = exp(net1(x12(:,tr.valInd)))-1+min(y);
yValTrue12 = exp(yt(tr.valInd))-1+min(y);



dem12 = 0;
for i=1:length(yVal12)
    if abs(yVal12(i)-yValTrue12(i))< 30
        dem12 =dem12 + 1;
    end
end
H2 = dem/ length(yVal12);

%du doan 18h

xt(:,6830)=[];


x07(1)=[];
xt18=[xt',x07];
yt(:,1)=[];
net2 = fitnet(hiddenLayerSize);
net2.divideParam.trainRatio = 70/100;
net2.divideParam.valRatio = 30/100;
net2.divideParam.testRatio = 0/100;
[net2,tr] = train(net2,xt18',yt);

%du doan 24h

xt(:,6829)=[];
x07(1)=[];
xt24=[xt',x07];
yt(:,1)=[];
net3 = fitnet(hiddenLayerSize);
net3.divideParam.trainRatio = 70/100;
net3.divideParam.valRatio = 30/100;
net3.divideParam.testRatio = 0/100;
[net3,tr] = train(net3,xt24',yt);


%du doan 72h

xt(:,6821:6828)=[];
x07(1:8)=[];
xt72=[xt',x07];
yt(:,1:8)=[];
net4 = fitnet(hiddenLayerSize);
net4.divideParam.trainRatio = 70/100;
net4.divideParam.valRatio = 30/100;
net4.divideParam.testRatio = 0/100;
[net4,tr] = train(net4,xt72',yt);
x72=xt72';
yTrain72 = exp(net4(x72(:,tr.trainInd)))-1+min(y);
yTrainTrue72 = exp(yt(tr.trainInd))-1+min(y);

yVal72 = exp(net1(x72(:,tr.valInd)))-1+min(y);
yValTrue72 = exp(yt(tr.valInd))-1+min(y);



dem72 = 0;
for i=1:length(yVal72)
    if abs(yVal72(i)-yValTrue72(i))< 30
        dem72 =dem72 + 1;
    end
end
H72 = dem/ length(yVal72);
%plot(yTrainTrue72);
%hold on;
%plot(yTrain72);
%legend('original values','predicted values');
%hold off;       

function plotEthanol(data)
% function plotEthanol(data)


x=[0:1e-3:12-1e-3];  
clf
hold on


 
boxc = boxcar(10)/10;
for i=1:length(data)
  
  filtV = filtfilt(boxc, 1, data(i).data);


  p=plot(x,filtV,'k-','linewidth',0.5);  
  if i==1 | i==4
    set(p,'color','r')
  end
  
end
hold off
  

box on
xlabel('time [s]')
ylabel('PID Voltage')

grid

print -dtiff -r150 ethanol.tiff

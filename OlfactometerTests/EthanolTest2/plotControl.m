function plotControl(data)
% function plotControl(data)


x=[0:1e-3:12-1e-3];  
clf
hold on


 
boxc = boxcar(10)/10;
clf
J=jet(24);
for i=1:length(data)
  
  filtV = filtfilt(boxc, 1, data(i).data);

  if data(i).valve<2
    subplot(1,2,1)
  else
    subplot(1,2,2)
    title('Control Vial [4]')
  end
  

  hold on
  plot(x,filtV,'-','linewidth',0.5,'color',J(ceil(i/2),:));  

  
end
hold off
  
subplot(1,2,1)
title('Control Vial [1]')
box on
xlabel('Time [s]')
ylabel('PID Voltage')

subplot(1,2,2)
title('Control Vial [4]')
box on
xlabel('Time [s]')



set(gcf,'paperposition',[0,0,12,5])
print -dtiff -r150 control.tiff

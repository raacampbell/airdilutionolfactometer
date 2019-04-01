function plotAlternating(data)
% function plotAlternating(data)


x=[0:1e-3:12-1e-3];  
clf
hold on


 
boxc = boxcar(10)/10;
clf
J=jet(6);
n=1;
for i=2:length(data)
  
  filtV = filtfilt(boxc, 1, data(i).data);

  if data(i).valve==16
    subplot(2,3,n)
    hold on
    y=1;
    n=n+1;
    continue
%    plot(x,filtV,'k-','linewidth',0.5)


  end
  

  
  plot(x,filtV,'-','linewidth',0.5,'color',J(y,:));  
  y=y+1;


  
end



set(gcf,'paperposition',[0,0,12,5])
print -dtiff -r150 alternating.tiff

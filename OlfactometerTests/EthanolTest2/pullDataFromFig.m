function data=pullDataFromFig
chil=get(gcf,'children');

for i=1:length(chil)  
     tmp=get(get(chil(i),'children'));
     data(i).data=tmp.YData;     
     data(i).valve=str2num(get(get(chil(i),'title'),'string'));
     data(i).time=nan;
end

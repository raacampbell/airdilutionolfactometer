function data=pullDataFromFig
chil=get(gcf,'children');

for i=1:length(chil)  
     tmp=get(get(chil(i),'children'));
     data{i,1}=str2num(get(get(chil(i),'title'),'string'));
     data{i,2}=tmp.YData;     
end

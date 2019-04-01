function plotagain(data)
%clf
col='rbgk';
for i=1:length(data)
    hold on
%    subplot(2,3,data(i).valve)
    subplot(2,3,i)
    p=plot(data(i).data);
    set(p,'color',col(length(get(gca,'children'))))
    
    hold off, xlim([8000,10000]),title(data(i).valve)
end 
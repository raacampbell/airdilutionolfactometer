
function plotResponseStability(data,manyPlots,pltParams)

if nargin<2 | isempty(manyPlots), manyPlots=0; end
if nargin<3, pltParams={'ok', 'markerfacecolor',[1,1,1]*0.65};end

%work out means
for ii=1:length(data.data)
    data.mu(ii)=mean(data.data{ii}(1:5E3));
end

if manyPlots
  clf
  U=unique(data.odours);
  ns=numSubplots(length(U));
  for ii=1:length(U)
    f=find(data.odours==U(ii));
    subplot(ns(1),ns(2),ii)
    hold on

    col=jet(length(f));
    for jj=1:length(f)
      plot(data.data{f(jj)},'color',col(jj,:))      
    end
    hold off
  %  ylim([4.5,5.5])
    xlim([0,5000])
    box
%    set(gca,'xtick',[],'ytick',[])
  end
else
    plot(data.odours,data.mu,pltParams{:})  
    set(gca,'xtick',1:12)
    xlabel('#Vial')
end





function showResponses(stim)
% function showResponses(stim)
% 

  
r=reshape([stim(:,1:end).valve],29,size(stim,2));

U=unique(r(:));

COL='rbgk';
clf
for i=1:length(U)
  
  f=find(r==U(i));
  [I,J]=ind2sub(size(r),f);
  
  subplot(5,6,i)
  hold on
  for n=1:length(I)
    plot(stim(I(n),J(n)).data(:),'color',COL(n))    
  end
  hold off
  xlim([8000,10000])
  box on
  set(gca,'XTick',[])
  grid on
  title(U(i))
end





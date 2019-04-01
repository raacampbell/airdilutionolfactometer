function plotCalib100728

  load calibration_100728 

% 05,octanol
% 06,T-octanol
% 07,MCH
% 08,T-MCH

odours=5:8;
ranges=[0,0.3; 0.25,1; 0,0.15; 0.05,1];
names={'oct','t-oct','mch','t-mch'};
tMazeVal=[0.5, 0.5, 3.5, 3.5];
for ii=1:length(odours)
  f=find([calib1.odour]==odours(ii));
  tmp=calib1(f);
  
  flows=[tmp.flow];
  f=find(flows>=ranges(ii,1) & flows<=ranges(ii,2));
  tmp=tmp(f);
  
  for jj=1:length(tmp)
    tmp(jj).mu=mean(tmp(jj).data);
  end
  
  subplot(2,2,ii)
  plot([tmp.flow],[tmp.mu],'ok')  
  xlim([0,1])
  stats=addFitLine;
  val=regSolveForX(stats,tMazeVal(ii));
  title(sprintf('%s - %2.2f lpm', names{ii},val))
end

function compareDilutions(A,B)
% function compareDilutions(A,B)
%
% Compare odour response magnitudes of simpleOdourTest series A and
% B. 
%
%

plot([A.respMag],[B.respMag],'ok','markerfacecolor',[1,1,1]*0.5);

stats=addFitLine;
title(sprintf('slope=%2.2f',stats.b(2)),'fontsize',12)


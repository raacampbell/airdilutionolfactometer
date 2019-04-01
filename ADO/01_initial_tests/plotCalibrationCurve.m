
function plotCalibrationCurve(varargin)

% If one input argument, then simply plot the data. If two input
% arguments, we plot one against the other
error(nargchk(1,2,nargin))

if nargin==1
  data=varargin{1};
  
  for ii=1:length(data)
    data(ii).mu=mean(data(ii).data(2000:end));
  end
  
  subplot(2,1,1)
  plot([data.flow],[data.mu]-data(1).mu,'ok')
  xlabel('flow')
  grid
  
  subplot(2,1,2)
  plot(log10([data.flow]),[data.mu]-data(1).mu,'ok')
  xlabel('log10(flow)')

elseif nargin==2

  for ii=1:length(varargin{1})
    varargin{1}(ii).mu=mean(varargin{1}(ii).data);
  end
  for ii=1:length(varargin{2})
    varargin{2}(ii).mu=mean(varargin{2}(ii).data);
  end
  
  plot([varargin{1}.mu],[varargin{2}.mu],'ok')
  
end



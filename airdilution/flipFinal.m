function flipFinal(state,verbose)

if nargin<2
  verbose=0;
end

dio=digitalio('nidaq','dev1');
hwlines=addline(dio,0,'out');

putvalue(dio.line,state)

if verbose
  disp(state)
end

delete(dio)

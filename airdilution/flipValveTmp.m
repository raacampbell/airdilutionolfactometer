function flipValveTmp(NI,state)
%  function flipValveTmp(NI,state)


switch lower(state)    
    case 'clean'
        putvalue(NI.line(2),0)  
        putvalue(NI.line(1),0)
        putvalue(NI.line(3),1)
    case 'odour'
        putvalue(NI.line(2),1)        
        putvalue(NI.line(3),0)
        putvalue(NI.line(1),1)                       
end

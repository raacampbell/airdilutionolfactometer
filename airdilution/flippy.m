function NI=connectDIO

NI=digitalio('nidaq','dev1');
hwlines = addline(NI,0:3,'out');

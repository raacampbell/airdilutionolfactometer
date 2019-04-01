function makeAllPlots

%Loop through all params.mat files and make EPS files out of them
%and generate a Latex Document.


dataDir='paramsFiles/';
D=dir(sprintf('%sparams*.mat',dataDir));

fid=fopen('emptyLatexDoc.tex','w');
fprintf(fid,...
        ['\\documentclass[a4paper]{report}\n\\usepackage{epsfig}\n',...
         '\\usepackage[bf,footnotesize]{caption}\n\\addtocounter{chapter}{1}\n',...
         '\\graphicspath{{./figFiles/}}\n\n\\begin{document}\n\n\n']);
%        '\\usepackage[a4paper,margin=2.7cm,tmargin=2.5cm,bmargin=2.5cm]\n',...

for ii=35:length(D)
    fname=D(ii).name;
    tmp=load([dataDir,fname]);
    
    PID_tracesByOdour(tmp.params,[7.5,12.5],[0.3,4])
    set(gcf, 'InvertHardCopy', 'off');
    print('-depsc',sprintf('./figFiles/%s.eps',fname(1:end-4)))
    

    fprintf(fid,['\\begin{figure}\n\\centering\n',...
                 '\\includegraphics[width=5in]{%s}\n',...
                 '\\caption{\\textbf{%s}:}\n\\end{figure}\n\n\n'],...
            [fname(1:end-4),'.eps'],strrep(fname(1:end-4),'_','\_'));
end


fprintf(fid,'\\end{document}\n');
fclose(fid);

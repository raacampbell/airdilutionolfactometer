function processParams(fname,tLimit,baseLine)   
% function processParams(fname,tLimit,baseLine)  
%
% does the following
% load params file
% remove odour names
% save
% run PID plot with tLimit and baseLine applied if neede
% save image in ../figFiles
%
% print latex code to screen

tmp=load(fname);
params=tmp.params;
%for i=1:32; params.odourNames(i).odour=num2str(i);end,save(fname,'params')

if nargin<2, tLimit=[]; end
if nargin<3, baseLine=[]; end
PID_tracesByOdour(params,tLimit,baseLine)

print('-depsc',['../figFiles/',fname(1:end-4)])

fprintf(['\n\\begin{figure}[h]\n\\centering\n',...
         '\\includegraphics[width=4in]{%s.eps}\n',...
         '\\caption{\\textbf{%s}:}\n\\end{figure}\n\n'],...
        fname(1:end-4), strrep(fname(1:end-4),'_','\_'))

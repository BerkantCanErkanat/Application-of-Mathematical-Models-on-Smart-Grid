function [] = makePlot(data,tit,xxlabel,yylabel,id)
figure (id)
plot(data);
title(tit);
xlabel(xxlabel);
ylabel(yylabel);
grid on
end
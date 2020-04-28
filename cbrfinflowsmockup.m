path="http://www.cbr.ru/Collection/Collection/File/27842/finflows_20200427.pdf";
ch=Import[path,{"Pages",4}];
jc=Cases[ch,_JoinedCurve,Infinity];
ln = jc[[5,2,1,;;,2]];
ListPlot[ln,Joined->True,Filling->Axis,FillingStyle->HatchFilling[],PlotStyle->Red]

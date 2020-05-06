path="http://www.cbr.ru/Collection/Collection/File/27842/finflows_20200427.pdf";

h = Import[path, "Pages"];
jc = Cases[h, Style[{___, _JoinedCurve, ___}, ___, RGBColor[0.933`, 0.06670000000000001`, 0.2`, 1.`], ___], Infinity]
noleg = jc[[;; ;; 2]];
ln = noleg[[;; , 1, 1, 2, 1, ;; , 2]];
Export["cbrflow.xlsx", ln]

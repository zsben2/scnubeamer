## 2023 年华南师范大学数学科学学院硕士毕业论文答辩自用简易模板

TeX 发行版： TeXLive 2021

编译命令
```
xelatex --synctex=1 beamer.tex
biber beamer.bcf
xelatex --synctex=1 beamer.tex
xelatex --synctex=1 beamer.tex
```

或

```
latexmk -xelatex -synctex=1 beamer.tex
```

又或者直接双击附带的 `makefile.bat` 文件编译。

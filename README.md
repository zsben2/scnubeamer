## 2023 年华南师范大学数学科学学院硕士毕业论文答辩自用简易模板 (v1.0)

如果想预览编译后的 PDF， 可以从右侧的 Releases 里下载。

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

\NeedsTeXFormat{LaTeX2e}
\RequirePackage{expl3}
\ProvidesExplClass{scnubeamer}{2023-03-27}{0.6}{Typesetting thesis for South China Normal University}
\RequirePackage { xparse, xtemplate, l3keys2e }
\keys_define:nn { scnu / option }
  {
    logoopacity .tl_set:N = \l__scnu_logo_opacity_tl,
    logoopacity .initial:n = { 0.2 }
  }
\ProcessKeysOptions { scnu / option }
\LoadClass [ usepdftitle = false ] { ctexbeamer }
\usetheme { Singapore }
\usefonttheme { serif }
\setlength { \parindent } { 2\ccwd }
\setmainfont { Times ~ New ~ Roman }

% 使调用 allowframebreaks 允许帧断页时，帧标题仅在第一页出现一次
% 参考自 https://tex.stackexchange.com/a/156644
\setbeamertemplate
  { frametitle ~ continuation }
  { \cs_gset:Npn \beamer@frametitle { } }

% 定理环境携带编号
\setbeamertemplate { theorems } [ numbered ]
\numberwithin { theorem } { section }
\setbeamertemplate { caption } [ numbered ]
\numberwithin { figure } { section }
\numberwithin { table } { section }
\numberwithin { equation } { section }

%%%%%%%%%%%%%%%%%%%%%%%%% 允许证明环境在 beamer 中拆分为多个帧
\setbeamertemplate { proof ~ begin }
  {%
    \par\vskip\medskipamount%
    \begin{beamercolorbox}[colsep*=.75ex]{block ~ title}
      \usebeamerfont*{block ~ title}%
        \insertproofname
    \end{beamercolorbox}%
    {\parskip0pt\par}%
    \ifbeamercolorempty[bg]{block ~ title}
    {}
    {\ifbeamercolorempty[bg]{block ~ body}{}{\nointerlineskip\vskip-0.5pt}}%
    \usebeamerfont{block ~ body}%
  }
\setbeamertemplate { proof ~ end } { }
%%%%%%%%%%%%%%%%%%%%%%%%%

% 限制 \AtEndEnvironment 的作用域仅一次生效
\NewDocumentCommand { \LocalAtNextEndEnvironment } { m m }
  {
    \cs_set_eq:cc { oldend#1 } { end#1 }
    \cs_set:cpn { end#1 } { #2 \use:c { oldend#1 } }
  }

\NewDocumentCommand { \hyperlabel } { m }
  {
    \label {#1}
    \LocalAtNextEndEnvironment { proposition } { \gotoproof {#1} }
    \LocalAtNextEndEnvironment { theorem } { \gotoproof {#1} }
  }
\NewDocumentCommand { \gotolabel } { m m }
  {
    \hspace * { 0em plus 1fill }
    \hyperlink {#1} { \beamergotobutton {#2} }
  }
\NewDocumentCommand { \gotoproof } { m }
  { \gotolabel { proof@ #1 } { 证明 } }
\NewDocumentCommand { \proofof } { m }
  {
    \Cref {#1} ~ 的证明%
    \hypertarget { proof@ #1 } { }
  }

\RequirePackage { xeCJKfntef, array, booktabs }
\newcolumntype { s } [ 1 ]
  {
    > { \CJKfilltwosides {#1} }
    l
    < { \endCJKfilltwosides }
  }

% 两端对齐
\RequirePackage { ragged2e }
\justifying
\cs_set_eq:NN \raggedright \justifying
\addtobeamertemplate { block ~ begin } { } { \justifying }
\addtobeamertemplate { block ~ example ~ begin } { } { \justifying }

% 生成多重脚注
% 参考自 https://tex.stackexchange.com/a/609412
% ---------------------------------------------------------------
\RequirePackage { manyfoot }
% For convenience, put footnotemark/footnotetext commands in a wrapper macro:
\NewDocumentCommand { \footendcitetext } { m }
  {
    \Footnotetext
      { \quad }
      { \parencite{#1} \nobreakspace \fullcite{#1} }
  }
\NewDocumentCommand { \footendcitemark } { m }
  { \Footnotemark { \parencite {#1} } }
\NewDocumentCommand { \footendcite } { m }
  {
    \footendcitemark {#1}
    \footendcitetext {#1}
  }

\cs_undefine:N \Bbbk
\RequirePackage [ lite ] { mtpro2 }
\RequirePackage { mathtools, mathrsfs }
\allowdisplaybreaks [ 4 ]
\RequirePackage { amsthm }

% 定理名汉化
\RequirePackage { cleveref }
\crefformat { equation }  { (#2#1#3)式 }
\crefformat { chapter }   { 第\ #2#1#3~章 }
\crefname { table }       { 表 }   { 表 }
\crefname { figure }      { 图 }   { 图 }
\crefname { proposition } { 命题 } { 命题 }
\crefname { lemma }       { 引理 } { 引理 }
\crefname { corollary }   { 推论 } { 推论 }
\crefname { theorem }     { 定理 } { 定理 }
\crefname { definition }  { 定义 } { 定义 }
\crefname { conjecture }  { 猜想 } { 猜想 }
\crefname { example }     { 例 }   { 例 }

% 为 beamer 中的 \Cref 恢复超链接
% 参考自 https://tex.stackexchange.com/a/266109
\cs_set_eq:NN \Chyperref \Cref % Save the orginal command under a new name
\renewcommand { \Cref } [ 1 ]
  { % Redefine the \Cref command and explictely add the hyperlink. 
    \hyperlink
      {#1}
      { \Chyperref {#1} }
  }

\RequirePackage { tikz }
\logo
  {
    \tikz [ overlay, remember ~ picture]
      \node [ opacity = \l__scnu_logo_opacity_tl ] at (current ~ page.east)
        { \includegraphics [ width = 5cm ] { fig / logo.png } };
  }
\titlegraphic
  { \includegraphics [ width = 5cm ] { fig / name.png } }
\endinput

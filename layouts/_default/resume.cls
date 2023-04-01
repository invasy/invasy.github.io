\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{resume}[2023-03-13 v0.1.0 Resume document class]

\DeclareOption{a4paper}{
  \setlength\paperheight{297mm}
  \setlength\paperwidth{210mm}}
\DeclareOption{a5paper}{
  \setlength\paperheight{210mm}
  \setlength\paperwidth{148mm}}
\DeclareOption{b5paper}{
  \setlength\paperheight{250mm}
  \setlength\paperwidth{176mm}}
\DeclareOption{letterpaper}{
  \setlength\paperheight{11in}
  \setlength\paperwidth{8.5in}}
\DeclareOption{legalpaper}{
  \setlength\paperheight{14in}
  \setlength\paperwidth{8.5in}}
\DeclareOption{executivepaper}{
  \setlength\paperheight{10.5in}
  \setlength\paperwidth{7.25in}}
\DeclareOption{landscape}{
  \setlength\@tempdima{\paperheight}
  \setlength\paperheight{\paperwidth}
  \setlength\paperwidth{\@tempdima}}

\newcommand\@ptsize{}
\DeclareOption{10pt}{\renewcommand\@ptsize{0}}
\DeclareOption{11pt}{\renewcommand\@ptsize{1}}
\DeclareOption{12pt}{\renewcommand\@ptsize{2}}

\DeclareOption{draft}{\setlength\overfullrule{5pt}}
\DeclareOption{final}{\setlength\overfullrule{0pt}}

\ExecuteOptions{a4paper,12pt,final}\ProcessOptions\relax

\input{size1\@ptsize.clo}

\RequirePackage[T1]{fontenc}
\RequirePackage{svg}
\RequirePackage[unicode]{hyperref}

\newcommand{\firstname}[1]{\def\resume@firstname{#1}}
\newcommand{\lastname}[1]{\def\resume@lastname{#1}}
\renewcommand{\title}[1]{\def\resume@title{#1}}
\newcommand{\email}[1]{\def\resume@email{#1}}
\newcommand{\phone}[1]{\def\resume@phone{#1}}
\newcommand{\url}[1]{\def\resume@url{#1}}
% \makecontact{type}{icon}{username}{url}
\newcommand{\makecontact}[4]{\includesvg[width=1em,height=1em]{#2}~#1:~\href{#4}{#3}}

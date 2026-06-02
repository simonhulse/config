% /home/simon/texmf/tex/latex/asrcslides/asrcslides.cls
% Simon Hulse
% simonhulse@protonmail.com
% Last Edited: Thu 08 May 2025 04:42:37 PM EDT

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{asrcslides}[2025/05/07 ASRC-branded beamer class]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{beamer}}
\ProcessOptions\relax
\LoadClass{beamer}

\setbeamertemplate{navigation symbols}{}
\setbeamersize{text margin left=15pt}

\def\email#1{\gdef\@email{#1}}
\RequirePackage{graphicx}
\RequirePackage{currfile}
\graphicspath{{\currfiledir}}
\pgfdeclareimage[width=\paperwidth]{header}{theme_figures/slideheader.pdf}

% --- Colour -------------------------------------------------------------
\RequirePackage{xcolor}
\definecolor{cunyblue}{HTML}{005DAA}

% --- Title slide format -------------------------------------------------
\setbeamertemplate{title page}
{
    \begin{picture}(0,0)
        \put(0,-120) {
            \begin{minipage}[b][4.5cm][t]{\textwidth}
                \centering
                {
                    \color{cunyblue}
                    {\Large\textbf{\inserttitle}\\[0.7cm]}
                    {\textit{\insertauthor}\\}
                    {\footnotesize\texttt{\@email}\\[0.3cm]}
                    {\insertdate\\[0.3cm]}
                }
            \end{minipage}
      }
  \end{picture}
}


% --- General slide format -----------------------------------------------

\setbeamertemplate{headline}
{
   \begin{picture}(0,0)
       \put(0,-30){\pgfuseimage{header}}
   \end{picture}
}

% TODO
\setbeamertemplate{footline}
{
   \setlength{\fboxsep}{0pt}
   \begin{picture}(0,0)
       \put(0, 5){
           \makebox(356.195,0){
               {\color{cunyblue}\bfseries\insertshortdate\hfill\hspace*{-20pt}\insertshorttitle\hfill Slide \insertframenumber}
           }
       }
   \end{picture}
}

\setbeamertemplate{frametitle}
{
  \begin{picture}(0,0)
      \put(-5,0){\bfseries\normalsize\color{white}\insertframetitle}
      \put(-5,-10){\tiny\bfseries\color{white}\insertframesubtitle}
  \end{picture}
}

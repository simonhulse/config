\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{asrcslides}[2025/05/07 ASRC-branded beamer class]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{beamer}}
\ProcessOptions\relax
\LoadClass{beamer}

\setbeamertemplate{navigation symbols}{}
\setbeamersize{text margin left=15pt}

\RequirePackage{slidesfonts}

\def\email#1{\gdef\@email{#1}}
\RequirePackage{graphicx}
\RequirePackage{currfile}
\edef\asrcslides@figprefix{\currfiledir%
theme_figures/}
\def\asrcslides@fig#1{\asrcslides@figprefix#1}
\pgfdeclareimage[width=\paperwidth]{header}{\asrcslides@fig{slideheader.pdf}}

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

\setbeamertemplate{footline}
{
   \begin{picture}(0,0)
       \put(4, 5){{\color{cunyblue}\bfseries\insertshortdate}}
       \put(\strip@pt\dimexpr\paperwidth/2\relax, 5){\makebox(0,0){{\color{cunyblue}\bfseries\insertshorttitle}}}
       \put(\strip@pt\dimexpr\paperwidth-4pt\relax, 5){\makebox(0,0)[r]{{\color{cunyblue}\bfseries Slide \insertframenumber}}}
   \end{picture}
}

\setbeamertemplate{frametitle}
{
  \begin{picture}(0,0)
      \put(-5,0){\bfseries\normalsize\color{white}\insertframetitle}
      \put(-5,-10){\tiny\bfseries\color{white}\insertframesubtitle}
  \end{picture}
}

% texmf/tex/latex/asrcslides/asrcslides.cls
% Simon Hulse
% simonhulse@protonmail.com
% Last Edited: Wed 07 May 2025 04:49:00 PM EDT

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{asrcslides}[7-5-25 ASRC-branded beamer class by Simon Hulse]

\LoadClass{beamer}
\setbeamertemplate{navigation symbols}{}
\setbeamersize{text margin left=15pt}

\ProcessOptions\relax

% --- FONT CONFIG --------------------------------------------------------
\RequirePackage{fontspec}
\RequirePackage[math-style=ISO,bold-style=ISO]{unicode-math}

\setmainfont{FiraSans}[
    Path           = /home/simonhulse/.fonts/FiraSans/,%
    Extension      = .ttf,%
    UprightFont    = *-Regular,%
    BoldFont       = *-SemiBold,%
    ItalicFont     = *-Italic,%
    BoldItalicFont = *-BoldItalic,%
]

\setsansfont{FiraSans}[
    Path           = /home/simonhulse/.fonts/FiraSans/,%
    Extension      = .ttf,%
    UprightFont    = *-Regular,%
    BoldFont       = *-SemiBold,%
    ItalicFont     = *-Italic,%
    BoldItalicFont = *-BoldItalic,%
]

\setmathfont{FiraMath-Regular}[
    Path           = /home/simonhulse/.fonts/,%
    Extension      = .otf,%
    Scale          = MatchLowercase,%
]

\setmonofont{FiraMono}[
    Path           = /home/simonhulse/.fonts/FiraMono/,%
    Extension      = .ttf,%
    Scale          = MatchLowercase,%
    UprightFont    = *-Regular,%
    BoldFont       = *-Bold,%
]

% --- Maths support ------------------------------------------------------
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{graphicx}
% I use this command quite a lot so thought I would include it by default
\DeclareMathOperator*{\argmin}{arg\,min}

% --- Colour -------------------------------------------------------------
\RequirePackage{xcolor}
\definecolor{cunyblue}{HTML}{005DAA}

\pgfdeclareimage[width=\paperwidth]{header}{/home/simonhulse/texmf/tex/latex/asrcslides/theme_figures/slideheader.pdf}

\def\email#1{\gdef\@email{#1}}

% --- Itemize configuration ----------------------------------------------
\usepackage{enumitem}
\setlist[itemize,1]{leftmargin=20pt}
\setlist[itemize,2]{leftmargin=15pt}

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

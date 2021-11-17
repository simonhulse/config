% Beamer template for presenations
% Oxford Chemistry + Foroozandeh Group branding
% Simon Hulse
% simon.hulse@chem.ox.ac.uk
% 11-3-20

\NeedsTeXFormat{LaTeX2e}
\ProvidesPackage{mf_slides}[2021/11/17 MF Group Beamer class]
\LoadClass[serif]{beamer}

%%% font configuration
\RequirePackage{fontspec}
\RequirePackage[math-style=ISO,bold-style=ISO]{unicode-math}

% Primary font: EB Garamond
\setmainfont{EBGaramond}[
Path           = /home/simon/.fonts/ebgaramond/,%
Extension      = .otf,%
UprightFont    = *-Regular,%
BoldFont       = *-Bold,%
ItalicFont     = *-Italic,%
BoldItalicFont = *-BoldItalic,%
Scale=0.8,%
]

% Maths font: Garamond Maths
\setmathfont{Garamond-Math}[
Path         = /home/simon/.fonts/,%
Extension    = .otf,%
StylisticSet = {1,8,5},%
Scale=0.8,%
]

% Monospaced font: Julia Mono (Looks nice and has brilliant unicode support)
\setmonofont{JuliaMono}[
Extension      = .ttf,%
Scale          = MatchLowercase,%
Path           = /home/simon/.fonts/juliamono/,%
UprightFont    = *-Regular,%
BoldFont       = *-Bold,%
ItalicFont     = *-RegularItalic,%
BoldItalicFont = *-BoldItalic,%
]

\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{bm}
\RequirePackage{physics}
\RequirePackage{graphicx}

\RequirePackage{xcolor}
\definecolor{oxfordblue}{HTML}{002e60}

\RequirePackage{siunitx}
\DeclareSIUnit\Molar{\textsc{m}}
\RequirePackage{nicefrac}

\RequirePackage{enumitem}
\setlist{leftmargin=2mm}
\setlist[itemize]{
  label={\smash{\raisebox{-0.1\height}{\includegraphics[scale=0.25]{theme_figures/fid_bullet.pdf}}}}
}

%% MATHS MACROS
\DeclareMathOperator*{\argmin}{arg\,min}

%%% FORMAT FOR TITLE SLIDE %%%

\pgfdeclareimage[width=\paperwidth]{titlebackground}{./theme_figures/titleslide.pdf}

\setbeamertemplate{title page}
{
  \begin{picture}(0,0)
    \put(-28.5,-163){\pgfuseimage{titlebackground}}
    \put(0,-120)
{
      \begin{minipage}[b][4.5cm][t]{0.5\textwidth}
        \color{oxfordblue}
        {\inserttitle\\[0.5cm]}
        {\insertauthor\\[0.2cm]}
        {\insertdate\\[0.2cm]}
        {\insertinstitute}
      \end{minipage}
}

  \end{picture}
}


%%% FORMAT FOR GENERAL (NON-TITLE) SLIDES %%%

\pgfdeclareimage[width=\paperwidth]{header}{./theme_figures/slideheader.pdf}

\setbeamertemplate{headline}
{
  \begin{picture}(0,0)
    \put(0,-22.5){\pgfuseimage{header}}
    \put(10,-268.5){\color{oxfordblue}\insertshortdate}
    \put(75,-268.5){\color{oxfordblue}\insertshorttitle}
    \put(160,-268.5){\color{oxfordblue} Slide $\the\numexpr\value{page}-1$}
  \end{picture}
}

\setbeamertemplate{frametitle}
{
  \begin{picture}(0,0)
    \put(-10,-25){\bfseries\normalsize\color{oxfordblue}\insertframetitle}
    \put(-10,-35){\scriptsize\color{oxfordblue}\insertframesubtitle}
  \end{picture}
}

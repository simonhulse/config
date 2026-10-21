\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{slidesbase}[2026/10/21 Common base for institution-branded beamer classes]

% A branded class must define the following before \LoadClass{slidesbase}:
%   \slidesbase@figprefix   directory holding its theme figures (trailing /)
%   \slidesbase@headerfile  header image, relative to \slidesbase@figprefix
%   \slidesbase@primaryhex  primary colour as an HTML hex code
% and may define:
%   \slidesbase@titlex      integer x-offset of the frame title (default 0)
% The primary colour is available as `slidesprimary'.

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{beamer}}
\ProcessOptions\relax
\LoadClass{beamer}

\providecommand{\slidesbase@titlex}{0}

\setbeamertemplate{navigation symbols}{}
\setbeamersize{text margin left=15pt}

\RequirePackage{slidesfonts}
\RequirePackage{graphicx}

\def\email#1{\gdef\@email{#1}}
\def\slidesbase@fig#1{\slidesbase@figprefix#1}

% --- Colour -------------------------------------------------------------
\RequirePackage{xcolor}
\definecolor{slidesprimary}{HTML}{\slidesbase@primaryhex}

% --- Header -------------------------------------------------------------
% The header scales with the page width, so its height is measured. The
% frame title sits relative to the 30pt banner of the 4:3 layout.
\pgfdeclareimage[width=\paperwidth]{header}{\slidesbase@fig{\slidesbase@headerfile}}
\newlength{\slidesbase@headerht}
\settoheight{\slidesbase@headerht}{\pgfuseimage{header}}
\newlength{\slidesbase@titleshift}
\setlength{\slidesbase@titleshift}{\dimexpr(\slidesbase@headerht-30pt)/2\relax}

% --- Title slide format -------------------------------------------------
\setbeamertemplate{title page}
{
    \begin{picture}(0,0)
        \put(0,-120) {
            \begin{minipage}[b][4.5cm][t]{\textwidth}
                \centering
                {
                    \color{slidesprimary}
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
       \put(0,\strip@pt\dimexpr-\slidesbase@headerht\relax){\pgfuseimage{header}}
   \end{picture}
}

\setbeamertemplate{footline}
{
   \begin{picture}(0,0)
       \put(4, 5){{\color{slidesprimary}\bfseries\insertshortdate}}
       \put(\strip@pt\dimexpr\paperwidth/2\relax, 5){\makebox(0,0){{\color{slidesprimary}\bfseries\insertshorttitle}}}
       \put(\strip@pt\dimexpr\paperwidth-4pt\relax, 5){\makebox(0,0)[r]{{\color{slidesprimary}\bfseries Slide \insertframenumber}}}
   \end{picture}
}

\setbeamertemplate{frametitle}
{
  \begin{picture}(0,0)
      \put(\numexpr\slidesbase@titlex-5,\strip@pt\dimexpr-\slidesbase@titleshift\relax){\bfseries\normalsize\color{white}\insertframetitle}
      \put(\numexpr\slidesbase@titlex-5,\strip@pt\dimexpr-10pt-\slidesbase@titleshift\relax){\tiny\bfseries\color{white}\insertframesubtitle}
  \end{picture}
}

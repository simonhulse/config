% /home/simon/texmf/tex/latex/cv/cv.cls
% Simon Hulse
% simonhulse@protonmail.com
% Last Edited: Fri 16 May 2025 01:55:19 PM EDT

\ProvidesClass{cv}[2025/03/14 CV class]

\LoadClass{cover}

\RequirePackage{ifthen}
\newgeometry{left=0.3in,right=0.3in,top=0.15in,bottom=0.15in}
\RequirePackage{enumitem}
\RequirePackage{pifont}
\setlist{%
    nosep,%
    topsep=-\parskip,%
    leftmargin=*,%
    label={\raisebox{0.1ex}{\hbox{\scriptsize\ding{118}}}}%
}

\def\sectionskip{\smallskip}
\def\sectionlineskip{\smallskip}

\newenvironment{rSection}[1]
    {
        \sectionskip
        {\large\bfseries\scshape{#1}} % Section title
        \sectionlineskip
        \hrule % Horizontal line
        \nobreak
    }
    {\smallskip}

\newenvironment{rSubsection}[3] % institution, year(s), role/title
    {%
        {\bfseries #1} \hfill {#2} \\
        \ifthenelse{\equal{#3}{}}{}{{\itshape #3}}%
        \begin{itemize}%
    }
    {\end{itemize}\smallskip}

\RequirePackage[%
    backend=biber,%
    sorting=none,%
    doi=true,%
    maxbibnames=50,%
    defernumbers=true,%
]{biblatex}
\renewbibmacro{in:}{}

% >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
% https://github.com/plk/biblatex/issues/793
\renewbibmacro*{issue+date}{%
  \ifboolexpr{test {\iffieldundef{year}}
              and test {\iffieldundef{issue}}}
    {}
    {\printtext[parens]{%
       \printfield{issue}%
       \setunit*{\addspace}%
       \usebibmacro{date}}}%
  \newunit}
% <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

\setlength{\bibitemsep}{.3\baselineskip plus .05\baselineskip minus .05\baselineskip}

\renewcommand*{\mkbibnamefamily}[1]{%
  \ifthenelse{\equal{#1}{Hulse}}{\textbf{#1}}{#1}%
}
\renewcommand*{\mkbibnamegiven}[1]{%
  \ifthenelse{\equal{\namepartfamily}{Hulse}}{\textbf{#1}}{#1}%
}

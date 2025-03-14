% cv/cv.cls
% Simon Hulse
% simonhulse@protonmail.com
% Last Edited: Fri 14 Mar 2025 11:40:04 AM EDT

\ProvidesClass{cv}[2025/03/14 CV class]

\LoadClass{cover}

\newgeometry{left=0.5in,right=0.5in,top=0.5cm,bottom=0.5cm}
\RequirePackage{enumitem}
\RequirePackage{pifont}
\setlist{%
    nosep,%
    leftmargin=*,%
    label={\raisebox{1pt}{\hbox{\scriptsize\ding{118}}}}%
}

\def\sectionskip{\smallskip}
\def\sectionlineskip{\smallskip}

\newenvironment{rSection}[1]
    {
        \sectionskip
        {\large\bfseries\scshape{#1}} % Section title
        \sectionlineskip
        \hrule % Horizontal line
    }

\newenvironment{rSubsection}[3] % 3 args: institution, year(s) employed, job title
    {
        {\bf #1} \hfill {#2} \\
        \ifthenelse{\equal{#3}{}}
            {}
            {
                {
                    \em #3
                    \vspace{-6pt}

                }
            }
    }
    {

    }

\RequirePackage[%
backend=biber,%
sorting=ddnt,%
]{biblatex}

\setlength{\bibitemsep}{.5\baselineskip plus .05\baselineskip minus .05\baselineskip}

\newbibmacro*{bbx:parunit}{%
  \ifbibliography
    {\setunit{\bibpagerefpunct}\newblock
     \usebibmacro{pageref}%
     \clearlist{pageref}%
     \setunit{\adddot\par\nobreak}}
    {}}

\renewbibmacro*{doi+eprint+url}{%
  \usebibmacro{bbx:parunit}
  \iftoggle{bbx:doi}
    {\printfield{doi}}
    {}%
  \iftoggle{bbx:eprint}
    {\usebibmacro{eprint}}
    {}%
  \iftoggle{bbx:url}
    {\usebibmacro{url+urldate}}
    {}}

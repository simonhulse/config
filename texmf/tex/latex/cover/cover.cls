\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cover}[2026/05/14 cover letter class]

\LoadClass[11pt,letterpaper]{article} % Font size and paper type

\RequirePackage{metalogo}
\setlogokern{La}{-0.2em}
\setlogokern{aT}{-.05em}
\setlogokern{eX}{-.05em}

\RequirePackage{fontspec}
\setmainfont{EBGaramond}[%
    UprightFont    = *-Regular,%
    BoldFont       = *-SemiBold,%
    ItalicFont     = *-Italic,%
    BoldItalicFont = *-BoldItalic,%
    FontFace       = {sb}{n}{*-SemiBold},%
]
\setmonofont{FiraMono}[%
    Scale       = MatchLowercase,%
    UprightFont = *-Regular,%
    BoldFont    = *-Bold,%
]

\RequirePackage[left=0.5in,top=1in,right=0.5in,bottom=1in]{geometry} % Document margins
\RequirePackage[parfill]{parskip} % Remove paragraph indentation

\pagestyle{empty} % Suppress page numbers

\def\namesize{\huge} % Size of the name at the top of the document
\def\nameskip{\medskip} % The space between the two address (or phone/email) lines
\def\addressskip{\smallskip} % The space between the two address (or phone/email) lines

\RequirePackage{xcolor}
\definecolor{linkblue}{HTML}{0047ab}

\RequirePackage{hyperref}
\hypersetup{%
    colorlinks=true,%
    linkcolor=black,%
    urlcolor=linkblue,%
    citecolor=black,%
}


\def \name#1{\def\@name{#1}} % Defines the \name command to set name
\def \@name {} % Sets \@name to empty by default

\def \printname {
  \begingroup
    \hfil{\namesize\bfseries\@name}\hfil
    \nameskip\break
  \endgroup
}

\def \addressSep#1{\def\@addressSep{#1}}
\def \@addressSep{\discretionary{}{}{\kern0.5em\texttt{|}\kern0.5em}}

% Accumulate all address items into one wrapping centered paragraph
\def\@addresscontent{}

\def \address #1{
    \ifx\@addresscontent\empty
        \gdef\@addresscontent{#1}%
    \else
        \g@addto@macro\@addresscontent{\@addressSep#1}%
    \fi
}

\def \printaddress {
    {\centering\@addresscontent\par}
    \addressskip
}

\RequirePackage{fontawesome5}
\newcommand{\ICON}[2]{#1~\raisebox{0.1ex}{#2}}
\newcommand{\BUILDING}[2]{\ICON{\faBuilding}{\href{#1}{#2}}}
\newcommand{\EMAIL}[1]{\ICON{\faEnvelope}{\href{mailto:#1}{\texttt{#1}}}}
\newcommand{\GITHUB}[1]{\ICON{\faGithub}{\href{https://github.com/#1}{\texttt{#1}}}}
\newcommand{\LINKEDIN}[1]{\ICON{\faLinkedin}{\href{https://www.linkedin.com/in/#1}{\texttt{#1}}}}
\newcommand{\ORCID}[1]{\ICON{\faOrcid}{\href{https://orcid.org/#1}{\texttt{#1}}}}
\newcommand{\PHONE}[1]{\ICON{\faPhone}{\texttt{#1}}}
\newcommand{\WEBSITE}[2]{\ICON{\faGlobe}{\href{#1}{\texttt{#2}}}}

\let\ori@document=\document
\renewcommand{\document}{
    \ori@document  % Begin document
    \vspace*{-1.3cm}
    \printname % Print the name specified with \name
    \printaddress
}

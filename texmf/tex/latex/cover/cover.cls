% cover/cover.cls
% Simon Hulse
% simonhulse@protonmail.com
% Last Edited: Fri 14 Mar 2025 12:04:04 PM EDT

\ProvidesClass{cover}[2025/03/13 cover letter class]

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

\RequirePackage[left=0.9in,top=1in,right=0.9in,bottom=1in]{geometry} % Document margins
\RequirePackage[parfill]{parskip} % Remove paragraph indentation
\RequirePackage{ifthen} % Required for ifthenelse statements

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
    \hfil{\namesize\bf\@name}\hfil
    \nameskip\break
}

\def \addressSep#1{\def\@addressSep{#1}}
\def \@addressSep{\quad} % Set default address separator to a diamond

% One, two or three address lines can be specified
\let \@addressone \relax
\let \@addresstwo \relax
\let \@addressthree \relax
\let \@addressfour \relax
\let \@addressfive \relax

% \address command can be used to set the first, second, and third address (last 2 optional)
\def \address #1{
    \@ifundefined{@addressone}{
        \def \@addressone {#1}
    }{
        \@ifundefined{@addresstwo}{
            \def \@addresstwo {#1}
        }{
            \@ifundefined{@addressthree}{
                \def \@addressthree {#1}
            }{
                \@ifundefined{@addressfour}{
                    \def \@addressfour {#1}
                }{
                    \def \@addressfive {#1}
                }
            }
        }
    }
}

\def \printaddress {
    \centerline{
        \@ifundefined{@addressone}{}{%
            \@addressone%
            \@ifundefined{@addresstwo}{}{%
                \@addressSep\@addresstwo
                \@ifundefined{@addressthree}{}{%
                    \@addressSep\@addressthree
                    \@ifundefined{@addressfour}{}{%
                        \@addressSep\@addressfour
                    }
                }
            }
        }
    }

    \addressskip
}

\RequirePackage{fontawesome5}
\newcommand{\ICON}[2]{#1\ \raisebox{1pt}{#2}}
\newcommand{\BUILDING}[2]{\ICON{\faBuilding}{\href{#1}{#2}}}
\newcommand{\EMAIL}[1]{\ICON{\faEnvelope}{\href{mailto:#1}{\texttt{#1}}}}
\newcommand{\GITHUB}[1]{\ICON{\faGithub}{\href{https://github.com/#1}{\texttt{#1}}}}
\newcommand{\LINKEDIN}[1]{\ICON{\faLinkedin}{\href{https://www.linkedin.com/in/#1}{\texttt{#1}}}}
\newcommand{\ORCID}[1]{\ICON{\faOrcid}{\href{https://orcid.org/#1}{\texttt{#1}}}}
\newcommand{\PHONE}[1]{\ICON{\faPhone}{\texttt{#1}}}

\let\ori@document=\document
\renewcommand{\document}{
    \ori@document  % Begin document
    \printname % Print the name specified with \name
    \printaddress
}

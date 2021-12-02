\NeedsTeXFormat{LaTeX2e}
\ProvidesPackage{sgh_article}[2021/11/30 SGH Article class]
\LoadClass{article}


\RequirePackage[
left=3cm,%
right=3cm,%
top=3cm,%
bottom=3cm,%
]{geometry}

\setlength{\parskip}{0.7em}

\RequirePackage{tocloft}
\setlength{\cftbeforesecskip}{10pt}
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
]

% Maths font: Garamond Maths
\setmathfont{Garamond-Math}[
Path         = /home/simon/.fonts/,%
Extension    = .otf,%
StylisticSet = {5},%
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

\RequirePackage[
backend=biber,%
style=numeric-comp,%
]{biblatex}


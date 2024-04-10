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

% Stuff I frequently need to write out
\newcommand{\btheta}{\symbf{\vartheta}}
\newcommand{\F}{\mathcal{F}}
\newcommand{\Ftheta}{\mathcal{F}\hspace{-1.5pt}\left(\symbf{\vartheta}\right)}
\newcommand{\gradFtheta}{\nabla_{\btheta}^{\vphantom{2}}\mathcal{F}\hspace{-2pt}\left(\symbf{\vartheta}\right)}
\newcommand{\hessFtheta}{\nabla_{\btheta}^2\mathcal{F}\hspace{-2pt}\left(\symbf{\vartheta}\right)}
\newcommand{\bx}{\symbf{x}}
\newcommand{\bxtheta}{\symbf{x}\hspace{-2pt}\left(\symbf{\vartheta}\right)}
\newcommand{\by}{\symbf{y}}
\newcommand{\yminusx}{\left(\hspace{1pt}\by - \bxtheta\right)}
\newcommand{\iu}{\mathrm{i}}
\newcommand{\btau}{\symbf{\tau}}
\newcommand{\dt}{\symup\Delta t}
\newcommand{\Jxtheta}{\symbf{J}_{\bx}\hspace{-2pt}\left(\btheta\right)}
\newcommand{\dxdthetai}{\frac{\partial \bx}{\partial \vartheta_i}}

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{asrcslides}[2025/05/07 ASRC-branded beamer class]

\RequirePackage{currfile}
\edef\slidesbase@figprefix{\currfiledir%
theme_figures/}
\def\slidesbase@headerfile{slideheader.pdf}
\def\slidesbase@primaryhex{005DAA}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{slidesbase}}
\ProcessOptions\relax
\LoadClass{slidesbase}

\colorlet{cunyblue}{slidesprimary}

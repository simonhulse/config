\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{oxslides}[10-6-22 Oxford-branded beamer class]

\RequirePackage{currfile}
\edef\slidesbase@figprefix{\currfiledir%
theme_figures/}
\def\slidesbase@headerfile{slideheader.pdf}
\def\slidesbase@primaryhex{002e60}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{slidesbase}}
\ProcessOptions\relax
\LoadClass{slidesbase}

\colorlet{oxfordblue}{slidesprimary}

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ntuslides}[2026/10/21 NTU-branded beamer class]

\RequirePackage{currfile}
\edef\slidesbase@figprefix{\currfiledir%
theme_figures/}
\def\slidesbase@headerfile{header.pdf}
\def\slidesbase@primaryhex{181C62}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{slidesbase}}
\ProcessOptions\relax
\LoadClass{slidesbase}

\colorlet{ntublue}{slidesprimary}

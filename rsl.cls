% LaTeX 2e class for URSI Radio Science Letters (RSL)
%
% 28 June 2019, Henrik Wallen <henrik.wallen@aalto.fi>
%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{rsl}[2019/06/28 URSI RSL template class]

% Class options: choose either 'manuscript' (the default) or 'preprint'
%
% Submissions to RSL must use the 'manuscript' option. The PDF should then
% be in letter size and single column with the same layout as the MS Word
% template. 
%
% The 'preprint' option is for producing a nicer preprint version of the
% letter using A4 page size (the published page size in RSL).
%
\DeclareOption{manuscript}{%
  \PassOptionsToClass{onecolumn,letterpaper}{article}%
  \PassOptionsToPackage{letterpaper, vmargin=1in, lmargin=1in,
    rmargin=4.35in}{geometry}%
}
\DeclareOption{preprint}{%
  \PassOptionsToClass{twocolumn,a4paper}{article}%
  \PassOptionsToPackage{a4paper, vmargin=34.2mm, hmargin=22.45mm,
    columnsep=0.2in}{geometry}%
}
\ExecuteOptions{manuscript}
\ProcessOptions

% Everything is based on the standard article class
\LoadClass[10pt]{article}

% Times font for text and formulas
\RequirePackage[T1]{fontenc}
\RequirePackage{textcomp}
\RequirePackage{mathptmx}

% Helvetica (~Arial) as sans serif font for headings
\RequirePackage[scaled]{helvet}

% Graphics and formulas
\RequirePackage{graphicx}
\RequirePackage{amsmath, amssymb}

% To get citation correctly formatted
\RequirePackage{cite}
\renewcommand{\citedash}{\hbox{-}\penalty\citepunctpenalty}

% Page size and layout (options specified above for manuscript/preprint)
\RequirePackage{geometry}

% Paragraph indentation
\setlength\parindent{0.32in} 

% No page numbers
\pagestyle{empty}

% Sloppy paragraph justification is needed also in one-column mode,
% since the column is so narrow.
\sloppy 

% Don't stretch columns to balance them in two-column mode
%\raggedbottom

% Adjust the abstract environment
\renewenvironment{abstract}{\par\emph{Abstract} -- \ignorespaces}{\par}

%
% Adjust the title and authors block
%
\newcommand\@titlecontents{%
  \newpage
  \noindent\hspace{-0.07in}\makebox[0pt][l]{\parbox{6.64in}{%
    \begin{center}
      {\fontsize{20}{24}\selectfont\sffamily\bfseries\@title\par}%
      \vspace{14pt}
      {\fontsize{12}{14}\selectfont\rmfamily\bfseries\itshape\@author\par}%
    \end{center}%
  }}%
  \if@twocolumn
    \vspace{3pt}\mbox{}%
  \else
    \vspace{5pt}%
  \fi
}
\renewcommand\maketitle{\par
  \begingroup
    \if@twocolumn
      \ifnum \col@number=\@ne
        \@titlecontents
      \else
        \twocolumn[\@titlecontents]%
      \fi
    \else
      \global\@topnum\z@   % Prevents figures from going at top of page.
      \@titlecontents
    \fi
  \endgroup
}


% Adjust the section headings
\renewcommand\@seccntformat[1]{\csname the#1\endcsname.~}
\renewcommand\section{\@startsection{section}{1}{0pt}%
  {11pt}%
  {11pt}%
  {\normalfont\sffamily\fontsize{11}{13}\selectfont\bfseries\centering}}
\renewcommand\subsection{\@startsection{subsection}{2}{0pt}%
  {10pt}%
  {10pt}%
  {\normalfont\sffamily\normalsize\bfseries\centering}}
\renewcommand\subsubsection{\@startsection{subsubsection}{3}{0pt}%
  {9pt}%
  {9pt}%
  {\normalfont\sffamily\small\bfseries\centering}}


% Adjust the bibliography
\renewcommand\@biblabel[1]{#1.}
\renewenvironment{thebibliography}[1]
     {\section{\refname}%
      \small
      \@mkboth{\MakeUppercase\refname}{\MakeUppercase\refname}%
      \list{\@biblabel{\@arabic\c@enumiv}}%
           {\settowidth\labelwidth{\@biblabel{#1}}%
            \leftmargin\labelwidth
            \advance\leftmargin\labelsep
            \@openbib@code
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\@arabic\c@enumiv}}%
      \sloppy
      \setlength\itemsep{0pt plus 4pt}
      \clubpenalty4000
      \@clubpenalty \clubpenalty
      \widowpenalty4000%
      \sfcode`\.\@m}
     {\def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}%
      \endlist}

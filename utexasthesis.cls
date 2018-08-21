% UT Austin graduate thesis style. https://github.com/linguistics/utexas-latex
% License: CC0 (https://creativecommons.org/publicdomain/zero/1.0/)
\NeedsTeXFormat{LaTeX2e}%[1994/06/01]
\ProvidesClass{utexasthesis}[2018/08/21 v1.0 University of Texas at Austin graduate thesis style]

% prepare boolean variables and set defaults
\newif\if@masters\@mastersfalse
\newif\if@copyright\@copyrightfalse
\newif\if@draft\@draftfalse
% handle optional arguments
\DeclareOption{masters}{\@masterstrue}
\DeclareOption{copyright}{\@copyrighttrue}
\DeclareOption{draft}{\@drafttrue\PassOptionsToClass{draft}{report}}
% capture the basic setspace package options for passing into setspace later
\def\@setspaceoption{onehalfspacing}
\DeclareOption{singlespacing}{\gdef\@setspaceoption{singlespacing}}
\DeclareOption{onehalfspacing}{\gdef\@setspaceoption{onehalfspacing}}
\DeclareOption{doublespacing}{\gdef\@setspaceoption{doublespacing}}
% handle font size, warning for 10pt and 11pt, defaulting to 12pt
\def\@sizeoption{12pt}
\newcommand{\@sizeoption@warning}{%
  \ClassWarningNoLine{utexasthesis}{The formatting guidelines recommend using 12pt}}
\DeclareOption{10pt}{\gdef\@sizeoption{10pt}\@sizeoption@warning}
\DeclareOption{11pt}{\gdef\@sizeoption{11pt}\@sizeoption@warning}
\DeclareOption{12pt}{\gdef\@sizeoption{12pt}}
% cascade any other options into the \LoadClass[...]{report} call
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
% process options and load report.cls
\ProcessOptions\relax
\LoadClass[\@sizeoption]{report}

% 1.25 inch margins except for the page number, which should be 1in from the bottom
\RequirePackage[letterpaper,hmargin=1.25in,top=1.25in,bottom=1in,includefoot]{geometry}
\RequirePackage[T1]{fontenc}
\RequirePackage[\@setspaceoption]{setspace}
% The indentfirst package ensures that every paragraph is indented,
% even those at the beginning of chapters/sections
\RequirePackage{indentfirst}
% > Paragraph indentions may be five to ten spaces.
% The width of a space for the normal font is 3pt, making the legal range 15pt to 30pt.
% The official Word template uses .5 inch (≈36pt)
% LaTeX's default \parindent is 1.5em (=18pt), which falls within the legal range.
% \setlength{\parindent}{1.5em}

\RequirePackage{natbib}
\setcitestyle{round,comma,yysep={;}}

% table of contents configuration
\RequirePackage[nottoc]{tocbibind}
\RequirePackage{tocloft}
\renewcommand{\contentsname}{Table of Contents} % default: Contents
\renewcommand{\cftdotsep}{0.25} % default: 4.5
% Prefix chapter numbers with "Chapter " and add space as needed
\renewcommand{\cftchappresnum}{\@chapapp\ }
\newlength{\cftchappresnum@width}
\settowidth{\cftchappresnum@width}{\cftchappresnum}
\addtolength{\cftchapnumwidth}{\cftchappresnum@width}

\RequirePackage[hyphens]{url}
\RequirePackage[pdfusetitle]{hyperref}
% hyperlink DOIs in bibliography (for BibTeX entries with doi fields)
\RequirePackage{doi}

% > Headings may be bolded and no more than 2 points larger than the rest of the text.
% When the 12pt option is used, \large is actually 14.4pt, but, close enough?
\newcommand{\headingsize}{\large}
\renewcommand{\Large}{\headingsize}
\renewcommand{\LARGE}{\headingsize}
\renewcommand{\huge}{\headingsize}
\renewcommand{\Huge}{\headingsize}

% chapter heading configuration
% simplified version of the original from report.cls
\def\@makechapterhead#1{{%
  \centering\headingsize
  % print "Chapter N"
  \@chapapp\space\thechapter
  \par\nobreak
  \vskip.25\baselineskip
  \@makeschapterhead{#1}
}}
% star-chapter variation
\def\@makeschapterhead#1{{
  \centering\headingsize
  % prevent page break between following lines at all costs
  \interlinepenalty=10000
  \bfseries #1\par\nobreak
  \vskip\baselineskip
}}

% toc/lot/lof heading configuration
\setlength{\cftbeforetoctitleskip}{\z@}
\setlength{\cftaftertoctitleskip}{.25\baselineskip}
\renewcommand{\cfttoctitlefont}{\headingsize\bfseries\hspace*{\fill}}
\renewcommand{\cftaftertoctitle}{\hspace*{\fill}}
% copy toc to lot
\setlength{\cftbeforelottitleskip}{\cftbeforetoctitleskip}
\setlength{\cftafterlottitleskip}{\cftaftertoctitleskip}
\renewcommand{\cftlottitlefont}{\cfttoctitlefont}
\renewcommand{\cftafterlottitle}{\cftaftertoctitle}
% copy toc to lof
\setlength{\cftbeforeloftitleskip}{\cftbeforetoctitleskip}
\setlength{\cftafterloftitleskip}{\cftaftertoctitleskip}
\renewcommand{\cftloftitlefont}{\cfttoctitlefont}
\renewcommand{\cftafterloftitle}{\cftaftertoctitle}

% Set up default values and setters
\def\@university{University of Texas at Austin}
\newcommand{\graduationdate}[2]{\gdef\@graduationmonth{#1}\gdef\@graduationyear{#2}}
\newcommand{\supervisor}[1]{\gdef\@supervisor{#1}}
\newcommand{\cosupervisor}[1]{\gdef\@cosupervisor{#1}}
\def\@othercommitteemembers{}
\newcommand{\othercommitteemembers}[1]{\gdef\@othercommitteemembers{#1}}

% handle PhD vs. masters based on optional masters argument, which defaults to false
\if@masters
  \gdef\@doctype{Thesis}
  \gdef\@degree{Master of Arts}
  \gdef\@degreeabbr{M.A.}
\else
  \gdef\@doctype{Dissertation}
  \gdef\@degree{Doctor of Philosophy}
  \gdef\@degreeabbr{Ph.D.}
\fi

\newenvironment{middlecenter}{\vspace*{\fill}\begin{center}}%
                             {\end{center}\vspace*{\fill}}

\newcommand{\@signature}[1]{%
  \vskip2\baselineskip\par\rule{\textwidth}{.7pt}%
  \vskip-4.4pt\par#1}
% this question is one of the best and only sources on \@for I could find: https://tex.stackexchange.com/q/2933
\newcommand{\@makesignatures}{%
  \@signature{\@supervisor, Supervisor}
  \@ifundefined{@cosupervisor}{}{%
    \@signature{\@cosupervisor, Co-Supervisor}}
  \@for\@i:=\@othercommitteemembers\do{\@signature{\@i}}%
}

\renewcommand{\maketitle}{%
  % The copyright, signature, title and dedication pages are counted but not numbered,
  % and so they all get the empty pagestyle
  % Generate the copyright page if specified as an option
  \if@copyright
    \clearpage\thispagestyle{empty}
    \begin{middlecenter}
      \begin{spacing}{4}
        \bfseries
        Copyright

        by

        \@author

        \@graduationyear
      \end{spacing}
    \end{middlecenter}
  \fi

  % generate signature page, which differs between Masters and Dissertation
  \clearpage\thispagestyle{empty}
  \if@masters
    \begin{center}
      \begin{doublespace}
        \textbf{\small The \@doctype{} committee for \@author{} certifies that this is the approved
        version of the following \MakeLowercase\@doctype:}

        \hbox

        \hbox

        \textbf{\headingsize\@title}

        \hbox

        \hbox
      \end{doublespace}
    \end{center}
    \hspace{.5\textwidth}\begin{minipage}{.5\textwidth}
      \begin{doublespace}
        \textbf{APPROVED BY}

        \textbf{SUPERVISING COMMITTEE:}

        \@makesignatures
      \end{doublespace}
    \end{minipage}
  \else
    \begin{center}
      \begin{singlespace}
        The \@doctype{} Committee for \@author{} certifies that this is the approved
        version of the following \MakeLowercase\@doctype:

        \hbox
      \end{singlespace}
      \begin{doublespace}
        \textbf{\headingsize\@title}
      \end{doublespace}
    \end{center}
    \hspace{.5\textwidth}\begin{minipage}{.5\textwidth}
      \begin{singlespace}
        \textbf{Committee:}
        \vskip1.5\baselineskip

        \@makesignatures
      \end{singlespace}
    \end{minipage}
  \fi

  % generate the actual title page
  \clearpage\thispagestyle{empty}
  \begin{center}
    \begin{doublespace}
      \textbf{\headingsize\@title}

      \hbox

      by

      \hbox

      \textbf{\@author}

      \hbox

      \textbf{\@doctype}

      \hbox

      Presented to the Faculty of the Graduate School

      of the \@university

      in Partial Fulfillment

      of the Requirements

      for the Degree of

      \hbox

      \textbf{\@degree}

      \hbox

      The \@university

      \@graduationmonth{} \@graduationyear{}
    \end{doublespace}
  \end{center}
  \clearpage
}

% Optional dedication page is triggered by using the dedication environment in the right place
\newenvironment{dedication}{\thispagestyle{empty}\begin{middlecenter}}{\end{middlecenter}}

% Optional acknowledgments page is triggered by using the acknowledgments environment in the right place
\newenvironment{acknowledgments}{%
  \chapter*{Acknowledgments}
}{}

% Required abstract page is triggered by using the abstract environment in the right place
\renewenvironment{abstract}{%
  \clearpage
  \begin{center}
    \begin{doublespace}
      {\headingsize\textbf{Abstract}}

      \hbox

      {\headingsize\textbf{\@title}}

      \hbox

      by

      \hbox

      \@author, \@degreeabbr

      The \@university, \@graduationyear

      \@ifundefined{@cosupervisor}{
        Supervisor: \@supervisor{}
      }{
        Supervisors: \@supervisor{} and \@cosupervisor{}
      }
    \end{doublespace}
  \end{center}

  \indent\ignorespaces%
}{}

\pagenumbering{roman}

\newcommand{\maketableofcontents}{%
  \clearpage
  \tableofcontents
  \clearpage
  \listoftables
  \clearpage
  \listoffigures
  \clearpage\pagenumbering{arabic}
}

\newcommand{\makeappendix}{%
  \appendix
  % ensure that the TOC picks up the redefined value of \@chapapp
  \addtocontents{toc}{\protect\renewcommand\protect\cftchappresnum{\@chapapp\ }}
}

\newcommand{\makebibliography}[1]{%
  \clearpage%
  \bibliography{#1}
}

% Optional vita page is triggered by using the vita environment in the right place
\newenvironment{vita}{%
  \clearpage%
  \addcontentsline{toc}{chapter}{Vita}%
  \chapter*{Vita}
  \noindent\ignorespaces%
}{}

\newenvironment{address}{%
  \setlength{\parskip}{1\baselineskip}\par\noindent%
  \makebox[1in][l]{Address:}%
  \begin{minipage}[t]{5in}%
}{\end{minipage}}

\newcommand{\declaretypist}[1]{\setlength{\parskip}{1.7\baselineskip}\par\noindent%
  This \MakeLowercase\@doctype{} was typed by #1.}

% overrides in draft mode:
\if@draft
  \renewcommand{\maketitle}{}
  \renewcommand{\maketableofcontents}{%
    % Just like \maketableofcontents but without the \tableofcontents
    \clearpage\pagenumbering{arabic}
  }
  % instead of clearing the page, just insert a bit of space
  \renewcommand{\chapter}{\vskip\baselineskip\thispagestyle{plain}\secdef\@chapter\@schapter}
\fi

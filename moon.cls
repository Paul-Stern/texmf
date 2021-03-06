\LoadClass[12pt, landscape]{article}
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{moon}
%% \RequirePackage{graphicx}
\RequirePackage[empty]{fullpage}
\RequirePackage{fontspec}
\RequirePackage{tikz}
\usetikzlibrary{calendar, fpu}
%% \RequirePackage{polyglossia}
%% \linespread{1}
\RequirePackage{hyperref}
\setmainfont{Source Serif Pro}


%% Source: https://tex.stackexchange.com/questions/34785/how-to-typeset-moon-phase-symbols

%% Make it under fair use

\tikzset{
    moon colour/.style={
        moon fill/.style={
            fill=#1
        }
    },
    sky colour/.style={
        sky draw/.style={
            draw=#1
        },
        sky fill/.style={
            fill=#1
        }
    },
    southern hemisphere/.style={
        rotate=180
    }
}

\makeatletter
\pgfcalendardatetojulian{2010-01-15}{\c@pgf@counta} % 2010-01-15 07:11 UTC -- http://aa.usno.navy.mil/cgi-bin/aa_moonphases.pl?year=2010&ZZZ=END
\def\synodicmonth{29.530588853}
\newcommand{\moon}[2][]{%
    \edef\checkfordate{\noexpand\in@{-}{#2}}%
    \checkfordate%
    \ifin@%
        \pgfcalendardatetojulian{#2}{\c@pgf@countb}%
        \pgfkeys{/pgf/fpu=true,/pgf/fpu/output format=fixed}%
        \pgfmathsetmacro\dayssincenewmoon{\the\c@pgf@countb-\the\c@pgf@counta-(7/24+11/(24*60))}%
        \pgfmathsetmacro\lunarage{mod(\dayssincenewmoon,\synodicmonth)}
        \pgfkeys{/pgf/fpu=false}%%
    \else%
        \def\lunarage{#2}%
    \fi%
    \pgfmathsetmacro\leftside{ifthenelse(\lunarage<=\synodicmonth/2,cos(360*(\lunarage/\synodicmonth)),1)}%
    \pgfmathsetmacro\rightside{ifthenelse(\lunarage<=\synodicmonth/2,-1,-cos(360*(\lunarage/\synodicmonth))}%
    \tikz [moon colour=white,sky colour=black,#1]{
        \draw [moon fill, sky draw] (0,0) circle [radius=1ex];
        \draw [sky draw, sky fill] (0,1ex)
            arc (90:-90:\rightside ex and 1ex)
            arc (-90:90:\leftside ex and 1ex)
            -- cycle;
    }%
}
\newcommand{\newmoon}{\moon{0}}
\newcommand{\waxingcrescent}{\moon{\synodicmonth/8}}
\newcommand{\firstquartermoon}{\moon{2*\synodicmonth/8}}
\newcommand{\waxinggibbous}{\moon{3*\synodicmonth/8}}
\newcommand{\fullmoon}{\moon{4*\synodicmonth/8}}
\newcommand{\waninggibbous}{\moon{5*\synodicmonth/8}}
\newcommand{\thirdquartermoon}{\moon{6*\synodicmonth/8}}
\newcommand{\waningcrescent}{\moon{7*\synodicmonth/8}}



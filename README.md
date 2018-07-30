## University of Texas at Austin graduate thesis LaTeX style

The [Digital Submission Requirement](https://gradschool.utexas.edu/academics/theses-and-dissertations/digital-submission-requirement) page describes the requirements for Masters and Ph.D. thesis submissions.
Most `utexas.edu` URLs are fragile; if that link is dead, try searching for [utexas graduate thesis style](https://www.google.com/search?q=utexas+graduate+thesis+style).


### Instructions

1. Download the [`utexasthesis.cls`](https://raw.githubusercontent.com/linguistics/utexas-latex/master/utexasthesis.cls) (right click and "Save As...") file into your working directory
2. Replace your initial `\documentclass{...}` call with `\documentclass{utexasthesis}`
3. Fill in the required personal information by calling the following commands in your preamble (i.e., somewhere before `\begin{document}`):
   - `\title{The Title of Your Dissertation or Treatise}`
   - `\author{Full Official Name}`
     + This should match the "Name of Doctoral Candidate" field on your official "Request For Final Oral Examination" form.
   - `\graduationdate{May}{2017}`
   - `\supervisor{Supervisor Name}`
   - `\cosupervisor{Cosupervisor Name}`
     + `% \cosupervisor{}` is optional, unless you use the `masters` option (described [below](#options)),
       in which case it's required and `\othercommitteemembers{}` is ignored.
   - `\othercommitteemembers{Member's Name, Member's Name, Member's Name}`
4. Supply `\maketitle` and the other commands and environments in the proper order.
5. Use `\maketableofcontents` instead of `\tableofcontents`
6. Use `\makebibliography{yourbib}` instead of `\bibliography{yourbib}`
   (and be sure to specify a style with `\bibliographystyle{...}`).

Alternatively, you can use the [`basic.tex`](https://raw.githubusercontent.com/linguistics/utexas-latex/master/template/basic.tex) (right click and "Save As...") example as a starting point, replacing the placeholder text with your own information.
View the `pdflatex` render of `basic.tex` on GitHub at [`basic.pdf`](https://github.com/linguistics/utexas-latex/blob/master/template/basic.pdf), or [download](https://raw.githubusercontent.com/linguistics/utexas-latex/master/template/basic.pdf).


### Customizations

The formatting guide doesn't specify a required font face.
The `utexasthesis` class doesn't set one, which leaves "Computer Modern Roman" as the default font family.

You can use any font supported by your LaTeX distribution; e.g., to use the Palatino font, as in the formatting guideline's examples:

    \usepackage{palatino}

Or to use Times, along with a teletype font (which is used in URLs) that's more compact than Courier:

    \usepackage{times}
    \renewcommand*\ttdefault{cmvtt}


### Options

The `utexasthesis` class can be customized with several optional arguments,
which are supplied in the `\documentclass{}` call, e.g., `\documentclass[masters]{utexasthesis}`.

- **`masters`**: switch format to Masters thesis, which has the following effects:
  + The document type is set to "Thesis" instead of "Dissertation".
  + The degree is set to "Master of Arts" (M.A.) instead of "Doctor of Philosophy" (Ph.D.).
  + The signatures page is styled differently.
- **`copyright`**: adds a copyright page at the beginning of your thesis.
- Line spacing (defaults to `onehalfspacing` if omitted):
  + **`singlespacing`**: Use single-spacing throughout the document,
    which is prohibited by the formatting guidelines.
  + **`onehalfspacing`**: Use 1.5-spacing throughout the document.
  + **`doublespacing`**: Use double-spacing throughout the document.
- Font sizes (defaults to `12pt` if omitted):
  + **`10pt`**: Use 10 point font,
    which is not recommended by the formatting guidelines.
  + **`11pt`**: Use 11 point font,
    which is not recommended by the formatting guidelines.
  + **`12pt`**: Use 12 point font.
- **`draft`**: renders a compact version of your thesis.
  The layout does not comply with the graduate school requirements,
  but may be useful to print out drafts for review.
  + This option applies the usual `draft` class options to the underlying `report` class.
  + The copyright page is omitted even if the `copyright` option is used.
  + The signatures page is omitted.
  + The main title page is omitted.
  + Chapters do not trigger a page break.

All of these can be used in combination, separated by commas.
The few options that have overlapping effects will give priority to the last-listed argument(s) in the listings above.
E.g., `\documentclass[masters,12pt,draft,11pt]{utexasthesis}` will render the Masters thesis format in 12 point font,
even though `11pt` comes after `12pt` in the list of options.


### Packages

The following packages are imported by `utexasthesis`:

* `geometry` (to set paper size, layout dimensions, and margins)
* `fontenc`
* `setspace` (configurable via `singlespacing` / `onehalfspacing` / `doublespacing` option)
* `indentfirst` (to indent every paragraph, even at the beginning of chapters and sections)
* `natbib`
* `tocloft`
* `tocbibind`
* `url`
* `hyperref`
* `doi` (to hyperlink DOIs in bibliography)


## License

The `utexasthesis` document class and related materials are [CC0](https://creativecommons.org/publicdomain/zero/1.0/)-licensed.
This is similar to the [Unlicense](http://unlicense.org) and [WTFPL](http://wtfpl.net).
This means I (Christopher Brown), have waived all copyright rights to this work, to the extent allowed by law.

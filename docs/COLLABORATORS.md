# Defining collaborators, colours and comments

RevMode uses a short key to connect every comment or change to one person and
one colour. Configure the keys once in `revmode-config.tex`.

## 1. Define the collaborators

```latex
\definecollab{sam}{Sam Hedayati}{revBlue}
\definecollab{sara}{Sara Smith}{revRed}
\definecollab{tom}{Tom Brown}{revGreen}
\definecollab{reviewer1}{Reviewer 1}{revPurple}
```

The three arguments are:

1. the short key used in manuscript commands;
2. the name printed beside the comment;
3. the colour assigned to that person.

The built-in print-safe colours are `revBlue`, `revRed`, `revGreen`,
`revPurple`, `revOrange`, `revTeal`, `revBrown` and `revPink`.

To define another colour:

```latex
\definecolor{myNavy}{HTML}{17365D}
\definecollab{editor}{Journal Editor}{myNavy}
```

## 2. Add comments and responses

```latex
The proposed method is computationally efficient.
\comment{sara}{Please support this claim with the runtime table.}
\reply{sam}{Agreed. I will refer to Table 4 here.}
```

Use `\resolved` when the manuscript was changed:

```latex
\comment{reviewer1}{The contribution is not sufficiently explicit.}
\resolved{sam}{Added a three-item contribution statement at the end of the introduction.}
```

The reply or resolution belongs to the most recent preceding comment, so keep
each comment and its responses together in the source.

## 3. Mark addressed text and suggestions

Text already written to address a point:

```latex
\changed{sam}{The method reduces the scenario set while preserving a certified objective bound.}
```

A proposed replacement, insertion or deletion:

```latex
\suggest{tom}{large improvement}{18.4 percent reduction}
\suggestadd{sara}{All experiments use the same random seeds.}
\suggestdel{sam}{This sentence is redundant.}
```

Override the global final-mode policy for one suggestion:

```latex
\suggest[accept]{tom}{old wording}{accepted wording}
\suggest[reject]{sara}{retained wording}{rejected wording}
```

## 4. Fill the separate point-by-point response

Open `point-by-point.tex` and write one formal entry per reviewer comment:

```latex
\responseheading
\responsepoint{R1}{reviewer1}
  {Please explain the sampling procedure.}
  {sam}
  {Thank you. We added a numbered explanation in Section 3.}
\responsechange{sam}{Exact text added to the revised manuscript.}
```

Compile `main-response.tex` for a standalone response letter. The same file is
appended to `main-original.tex` and `main-comments.tex`.

## 5. Produce a clean submission

In `main-final.tex`:

```latex
\usepackage[mode=final,accept=all]{revmode}
```

This applies pending suggestions and removes comments, responses, colours,
private notes and line numbers. Change `accept=all` to `accept=none` to retain
the pre-suggestion wording unless an individual suggestion overrides it.

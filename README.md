# rio

The aim of `rio` is to make data file I/O in R as easy as possible. The swiss-army knife-style functions `export` and `import` provide painless data file I/O experience and the `convert` function allows the user to convert between file formats.

## Supported file formats

*Export*

* txt (tab-seperated)
* csv
* rds
* dta (Stata)

*Import*

* txt (tab-seperated)
* csv
* rds
* dta (Stata)
* sav (SPSS)
* mtp (Minitab)
* rec (Epiinfo)

## Examples

```R
library(rio)

# export
export(iris, "iris.csv")
export(iris, "iris.rds")
export(iris, "iris.dta")

# import
x <- import("iris.csv")
y <- import("iris.rds")
z <- import("iris.dta")

# convert
convert("iris.csv", "iris.dta")
```

## Package Installation

```R
library("devtools")
install_github("chainsawriot/rio")
```

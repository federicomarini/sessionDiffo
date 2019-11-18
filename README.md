
<!-- README.md is generated from README.Rmd. Please edit that file -->

# sessionDiffo

<!-- badges: start -->

[![](https://img.shields.io/github/last-commit/federicomarini/sessionDiffo.svg)](https://github.com/federicomarini/sessionDiffo/commits/master)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
![Travis build
status](https://travis-ci.org/federicomarini/sessionDiffo.svg?branch=master)
<!-- badges: end -->

## Installation

You can install the released version of sessionDiffo from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("sessionDiffo")
```

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("federicomarini/sessionDiffo")
```

## Why?

Ever encountered a situation where the configuration of two systems is
different?

Examples:

  - a newer package introduced changes in the functionality, and you
    have different setups on different machines. You might want to
    pinpoint what is different

  - debugging/reporting an issue: you encounter a bug, or someone
    reports it to you, and you want to compare the full set of packages
    that are available in the two different setups

<!-- end list -->

``` r
library(sessionDiffo)
# start the ShinySessionDiffo app
ssd()
```

## Development

If you encounter a bug, have usage questions, or want to share ideas and
functionality to make this package better, feel free to file an
[issue](https://github.com/federicomarini/sessionDiffo/issues).

## Code of Conduct

Please note that the `sessionDiffo` project is released with a
[Contributor Code of Conduct](CODE_OF_CONDUCT.md). By contributing to
this project, you agree to abide by its terms.

## License

MIT © Federico Marini

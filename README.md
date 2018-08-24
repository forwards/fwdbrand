Forwards branding
=================

[![Travis build status](https://travis-ci.org/forwards/fwdbrand.svg?branch=master)](https://travis-ci.org/forwards/fwdbrand) [![AppVeyor build status](https://ci.appveyor.com/api/projects/status/github/forwards/fwdbrand?branch=master&svg=true)](https://ci.appveyor.com/project/maelle/fwdbrand) [![Coverage status](https://codecov.io/gh/forwards/fwdbrand/branch/master/graph/badge.svg)](https://codecov.io/github/forwards/fwdbrand?branch=master)


This repo contains material related to Forwards (the R foundation taskforce promoting diversity in the R community) branding, organized as an R package for easier distribution and use.

# Installation

```r
# install.packages("devtools")
devtools::install_github("forwards/fwdbrand")
```

# Logo

![](inst/extdata/assets/logo.png)

## Files 

* Logo (transparent background) as [png](inst/extdata/assets/forwards.png) and [svg](inst/extdata/assets/forwards.svg). [White background logo](inst/extdata/assets/white_bg_forwards.png).

* [Hex logo](inst/extdata/assets/forwards_hex.png).

## Code

* [Create the logo](inst/assets-scripts/create_original_transparent_logo.R).

* [Create its white background version](inst/assets-scripts/create_white_bg_logo.R).

* [Create a hex sticker based on the logo](inst/assets-scripts/create_hex_sticker.R).

# Workshop certificate creation

Create a certificate for the participants of a workshop using `create_workshop_certificates`. See example below. PDFs are created in the folder indicated by `dir`.

```r
# Fake names generated via charlatan::ch_name
attendees <- c("Marnie Dickinson", "Dr. Marlin Wilderman")
date <- as.Date("2018-01-01")
location <- "University of Lorraine"
workshop <- "Package development workshop"
curriculum <- system.file("rmarkdown", "templates",
                          "workshop_certificate", "resources",
                          "default_workshop_contents.md", package = "fwdbrand")
certifier <- "Zaire Crooks"
credentials <- "Forwards teaching team member"
dir <- "certificates"
create_workshop_certificates(date, location,
                             workshop, curriculum,
                             certifier,
                             credentials,
                             attendees,
                             dir)
```

[Example certificate]("certificates/package_development_workshop_01.pdf").

## Legalese

The Forwards logo is a derivative of the [R logo](https://www.r-project.org/logo/Rlogo.svg), [©2016 The R Foundation](https://www.r-project.org/logo/), used 
under [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/). The 
Forwards logo is licensed under [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/), ©2016 Forwards.

### Meta

Please note that this project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md).
  By participating in this project you agree to abide by its terms.

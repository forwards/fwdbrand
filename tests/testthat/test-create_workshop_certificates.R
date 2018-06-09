context("test-create_workshop_certificates.R")

test_that("create_workshop_certificates works", {
    skip_on_cran()
    attendees <- c("Marnie Dickinson", "Dr. Marlin Wilderman")
    date <- structure(17532, class = "Date")
    workshop <- "Package development workshop"
    curriculum <- system.file("rmarkdown", "templates", "workshop_certificate", "resources", "default_workshop_contents.md", package = "fwdbrand")
    certifier <- "Zaire Crooks"
    credentials <- "Forwards teaching team member"
    dir <- "certificates"
    create_workshop_certificates(date, workshop, curriculum, certifier,
                                 credentials,
                                 attendees,
                                 dir)
    expect_true(file.exists(file.path(dir,
                                      "package_development_workshop_01.pdf")))
    expect_true(file.exists(file.path(dir,
                                      "package_development_workshop_02.pdf")))
    unlink(dir, recursive = TRUE)
})

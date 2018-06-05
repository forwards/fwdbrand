create_workshop_certificates <- function(date, workshop, curriculum, certifyer,
                                        credentials,
                                        attendees,
                                        dir){
    file.copy(system.file("rmarkdown", "templates",
                          "workshop_certificate", "skeleton",
                          "skeleton.Rmd", package = "branding"),
              file.path(dir, "skeleton.Rmd"))
    file.copy(system.file("extdata", "assets",
                          "partly_transparent_forwards.png", package = "branding"),
              file.path(dir, "logo.png"))

    purrr::wak(attendees,
               create_workshop_certificate)

   file.remove(file.path(dir, "skeleton.Rmd"))
   file.remove(file.path(dir, "logo.png"))
}

create_workshop_certificate <- function(attendee,
                                        date, workshop,
                                        curriculum, certifyer,
                                        credentials,
                                        dir,
                                        number){
    rmarkdown::render(input = "skeleton.Rmd",
                      output_file = snakecase::to_snake_case(paste(workshop, number)),
                      output_dir = dir,
                      params = list(date = date,
                                    worshop = workshop,
                                    curriculum = curriculum,
                                    certifyer = certifyer,
                                    credentials = credentials,
                                    attendee = attendee))
}

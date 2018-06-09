#' Create certificates for all attendees
#'
#' @param date Date of the workshop, as a date.
#' @param workshop Workshop title, character.
#' @param curriculum Path to the workshop curriculum (.md), character.
#' @param certifier Person certifying, character.
#' @param credentials Credentials of the certifying person, character.
#' @param attendees Names of attendees, character vector.
#' @param dir Directory where to output the pdf certificates, character.
#' @param keep_tex Logical argument passed to rmarkdown::render
#'
#' @export
#'
#' @examples
#' \dontrun{
#' # Fake names generated via charlatan::ch_name
#' attendees <- c("Marnie Dickinson", "Dr. Marlin Wilderman")
#' date <- as.Date("2018-01-01")
#' workshop <- "Package development workshop"
#' curriculum <- system.file("rmarkdown", "templates",
#' "workshop_certificate", "resources",
#' "default_workshop_contents.md", package = "fwdbrand")
#' certifier <- "Zaire Crooks"
#' credentials <- "Forwards teaching team member"
#' dir <- "certificates"
#' create_workshop_certificates(date, workshop, curriculum,
#'  certifier,
#' credentials,
#' attendees,
#' dir)
#' }
create_workshop_certificates <- function(date, workshop, curriculum, certifier,
                                        credentials,
                                        attendees,
                                        dir, keep_tex){

    if(!dir.exists(dir)){
        dir.create(dir)
    }
    file.copy(system.file("rmarkdown", "templates",
                          "workshop_certificate", "skeleton",
                          "skeleton.Rmd", package = "fwdbrand"),
              file.path(dir, "skeleton.Rmd"))
    file.copy(system.file("extdata", "assets",
                          "partly_transparent_forwards.png", package = "fwdbrand"),
              file.path(dir, "logo.png"))


    purrr::walk2(attendees, 1:length(attendees),
               create_workshop_certificate,
               date, workshop,
               curriculum, certifier,
               credentials,
               dir, keep_tex)

   file.remove(file.path(dir, "skeleton.Rmd"))
   file.remove(file.path(dir, "logo.png"))
}

create_workshop_certificate <- function(attendee, number,
                                        date, workshop,
                                        curriculum, certifier,
                                        credentials,
                                        dir, keep_tex){
    rmarkdown::render(input = file.path(dir, "skeleton.Rmd"),
                      output_file = paste0(snakecase::to_snake_case(paste(workshop,
                                                                   stringr::str_pad(number, 2, pad = "0"))),
                                           ".pdf"),
                      output_dir = dir,
                      params = list(date = date,
                                    workshop = workshop,
                                    curriculum = curriculum,
                                    certifier = certifier,
                                    credentials = credentials,
                                    attendee = attendee),
                      output_options = list(keep_tex = keep_tex))
}

#' Create certificates for all attendees
#'
#' @param date Date of the workshop, as a date.
#' @param workshop Workshop title, character.
#' @param curriculum Path to the workshop curriculum (.md), character.
#' @param certifyer Person certifying, character.
#' @param credentials Credentials of the certifying person, character.
#' @param attendees Names of attendees, character vector.
#' @param dir Directory where to output the pdf certificates, character.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' # Fake names generated via charlatan::ch_name
#' attendees <- c("Marnie Dickinson", "Dr. Marlin Wilderman", "Gail Dietrich",
#' "Mr. Hall Emard", "Kwame Tillman II", "Mrs. Vessie Gusikowski",
#' "Burt Purdy", "Kendrick Mohr-Mann", "Stephany Cartwright", "Osvaldo Connelly"
#' )
#' date <- structure(17532, class = "Date")
#' workshop <- "Package development workshop"
#' curriculum <- system.file("rmarkdown", "templates", "workshop_certificate", "resources", "default_workshop_contents.md", package = "branding")
#' certifyer <- "Zaire Crooks"
#' credentials <- "Forwards teaching team member"
#' dir <- "certificates"
#' create_workshop_certificates(date, workshop, curriculum, certifyer,
#' credentials,
#' attendees,
#' dir)
#' }
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

    if(!dir.exists(dir)){
        dir.create(dir)
    }

    purrr::walk2(attendees, 1:length(attendees),
               create_workshop_certificate,
               date, workshop,
               curriculum, certifyer,
               credentials,
               dir)

   file.remove(file.path(dir, "skeleton.Rmd"))
   file.remove(file.path(dir, "logo.png"))
}

create_workshop_certificate <- function(attendee, number,
                                        date, workshop,
                                        curriculum, certifyer,
                                        credentials,
                                        dir){
    rmarkdown::render(input = file.path(dir, "skeleton.Rmd"),
                      output_file = paste0(snakecase::to_snake_case(paste(workshop,
                                                                   stringr::str_pad(number, 2, pad = "0"))),
                                           ".pdf"),
                      output_dir = dir,
                      params = list(date = date,
                                    workshop = workshop,
                                    curriculum = curriculum,
                                    certifyer = certifyer,
                                    credentials = credentials,
                                    attendee = attendee))
}

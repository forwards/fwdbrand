library("magrittr")
logo_path <- "inst/extdata/assets/forwards.png"

# replace transparent background with white background
# note, this is probably not the best solution
logo <- magick::image_read(logo_path)
height <- magick::image_info(logo)$height
magick::image_blank(height, height, color = "white") %>%
  magick::image_composite(logo) %>%
  magick::image_write("inst/extdata/assets/white_bg_forwards.png")

bitmap <- logo[[1]]
bitmap[4,,] <- as.raw(as.integer(bitmap[4,,]) * 0.4)
magick::image_read(bitmap) %>%
    magick::image_write("inst/extdata/assets/partly_transparent_forwards.png")

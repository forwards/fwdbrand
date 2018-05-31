# make hex sticker
library("magrittr")
logo_path <- "assets/forwards.png"
# first step, hex sticker with wrong border
hexSticker::sticker(logo_path, package="",
                    filename="temp.png",
                    h_fill = "white",
                    h_color = "green",
                    s_width = 0.7,
                    s_height = 0.7,
                    h_size = 2,
                    s_x = 1, s_y = 1)

# now make border transparent
height <- magick::image_info(magick::image_read("temp.png"))$height
width <- magick::image_info(magick::image_read("temp.png"))$width
img <- magick::image_blank(width, height, "white") %>%
    magick::image_composite(magick::image_read("temp.png")) %>%
    magick::image_transparent(color = "#00FF00", fuzz = 1)

# blank gradient image for the background
fig <- magick::image_graph(width = width, height = height, res = 96)
x <- y <- seq(0,1,length.out=100)
tmp <- expand.grid(x=x,y=y)
z <- matrix( tmp$y , 100 )
par(mar=rep(0, 4), xpd = NA)
image(x, y, z, col = viridis::viridis_pal(option = "magma")(100),
      axes = FALSE, xlab = "", ylab = "")
dev.off()

magick::image_composite(fig, img) %>%
    magick::image_transparent("white") %>%
    magick::image_write("assets/forwards_hex.png")

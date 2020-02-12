library(rparticle)
library(ggplot2)
library(base64enc)
library(htmltools)

# replicate example
(ex1 <- rparticle(
  list(
    src = "https://malerba118.github.io/react-particle-image-demo/logo512.png",
    #src = src,
    scale = 0.75,
    entropy = 20,
    maxParticles = 4200,
    particleOptions = list(
      filter = htmlwidgets::JS('
        ({ x, y, image }) => {
          // Get pixel
          const pixel = image.get(x, y);
          // Make a particle for this pixel if blue > 50 (range 0-255)
          return pixel.b > 50;
        }
      '),
      color =  htmlwidgets::JS('({ x, y, image }) => "#fff"')
    ),
    mouseMoveForce = htmlwidgets::JS('
      (x,y) => {
        return forces.disturbance(x, y, 5);
      };
    ')
  )
)
)

tmp <- tempfile(fileext = ".png")
#on.exit({unlink(tmp)})
png(file = tmp, width =480, height=480, units="px")
ggplot(
  data.frame(x = letters[1:5], y = runif(5,1,100)),
  aes(x = x, y = y, fill = x)
) +
  geom_col(show.legend = FALSE) +
  theme_void() +
  theme(panel.background = element_rect(fill = "black"))
dev.off()
src <- paste0(
  "data:image/png;base64,",
  base64enc::base64encode(tmp)
)

#do it with a ggplot
(ex2 <- rparticle(
  list(
    src = src,
    scale = 0.75,
    entropy = 20,
    maxParticles = 4200,
    particleOptions = list(
      filter = htmlwidgets::JS('
        ({ x, y, image }) => {
          // Get pixel
          const pixel = image.get(x, y);
          // Make a particle for this pixel if red > 200 (range 0-255)
          return pixel.r > 50 || pixel.g > 50 || pixel.b > 50
        }
      '),
      color =  htmlwidgets::JS('
         ({ x, y, image }) => {
            const pixel = image.get(x, y);
            return("rgb(" + pixel.r + "," + pixel.g + "," + pixel.b + ")")
         }
      ')
    ),
    mouseMoveForce = htmlwidgets::JS('
      (x,y) => {
        return forces.disturbance(x, y, 5);
      };
    ')
  )
)
)

browsable(tagList(
  tags$style(".html-widget{display:inline;}"),
  ex1,
  ex2
))

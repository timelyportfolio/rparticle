#' <Add Title>
#'
#' <Add Description>
#'
#' @import htmlwidgets
#'
#' @export
rparticle <- function(
  config = list(),
  width = NULL, height = NULL, elementId = NULL
) {

  # describe a React component to send to the browser for rendering.
  component <- reactR::reactMarkup(
    reactR::component("ParticleImage", config)
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'rparticle',
    component,
    width = width,
    height = height,
    package = 'rparticle',
    elementId = elementId
  )
}

#' Shiny bindings for rparticle
#'
#' Output and render functions for using rparticle within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a rparticle
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name rparticle-shiny
#'
#' @export
rparticleOutput <- function(outputId, width = '100%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(outputId, 'rparticle', width, height, package = 'rparticle')
}

#' @rdname rparticle-shiny
#' @export
renderRparticle <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, rparticleOutput, env, quoted = TRUE)
}

#' Called by HTMLWidgets to produce the widget's root element.
#' @rdname rparticle-shiny
rparticle_html <- function(id, style, class, ...) {
  htmltools::tagList(
    # Necessary for RStudio viewer version < 1.2
    reactR::html_dependency_corejs(),
    reactR::html_dependency_react(),
    reactR::html_dependency_reacttools(),
    htmltools::tags$div(id = id, class = class, style = style)
  )
}

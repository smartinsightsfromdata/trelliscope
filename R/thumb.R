#' Make a thumbnail for an htmlwidget panel
#'
#' @param p htmlwidget object
#' @param thumbPath where to save thumbnail file
#' @param timeout how many milliseconds to wait until plot is rendered
#' @export
#' @importFrom htmlwidgets saveWidget
widgetThumbnail <- function(p, thumbPath, timeout = 500) {
  phantom <- findPhantom()
  thumbPath <- path.expand(thumbPath)

  if(phantom == "") {
    message("** phantomjs dependency could not be found - thumbnail cannot be generated (run phantomInstall() for details)")
  } else {
    res <- try({
      ff <- tempfile(fileext = ".html")
      ffjs <- tempfile(fileext = ".js")

      # don't want any padding
      p$sizingPolicy$padding <- 0
      suppressMessages(saveWidget(p, ff, selfcontained = FALSE))

      js <- paste0("var page = require('webpage').create();
page.open('file://", ff, "', function() {
  window.setTimeout(function () {
    page.render('", thumbPath, "');
    phantom.exit();
  }, ", timeout, ");
});")
      cat(js, file = ffjs)
      system2(phantom, ffjs)
    })
    if(inherits(res, "try-error"))
      message("** could not create htmlwidget thumbnail...")

    # system(paste("open ", ffjs))
    # system(paste("open ", dirname(ffjs)))
  }
}

#' @export
phantomInstall <- function() {
  message("Please visit this page to install phantomjs on your system: http://phantomjs.org/download.html")
}

# similar to webshot
findPhantom <- function() {

  phantom <- Sys.which("phantomjs")

  if(Sys.which("phantomjs") == "") {
    if(identical(.Platform$OS.type, "windows")) {
      phantom <- Sys.which(file.path(Sys.getenv("APPDATA"), "npm", "phantomjs.cmd"))
    }
  }

  phantom

}

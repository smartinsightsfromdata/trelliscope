\name{makeDisplay}
\alias{makeDisplay}
\title{Create a Trelliscope Display}
\usage{
  makeDisplay(data, name, group = "common", desc = "",
    panelDim = list(height = NULL, width = NULL, aspect = NULL, res = NULL),
    panelFn = NULL,
    lims = list(x = "free", y = "free", prepanelFn = NULL),
    cogFn = NULL, preRender = FALSE, cogConn = dfCogConn(),
    output = NULL, conn = getOption("vdbConn"),
    verbose = TRUE, control = NULL)
}
\arguments{
  \item{data}{data of class "ddo" or "ddf" (see
  \code{\link{ddo}}, \code{\link{ddf}})}

  \item{name}{the name of the display (no spaces or special
  characters)}

  \item{group}{the group the display belongs to (displays
  are organized into groups).  Defaults to "common"}

  \item{desc}{a description of the display (used in the
  viewer and in notebooks)}

  \item{panelDim}{a list defining aspects of dimensions for
  each panel, including height, width, aspect, and res
  (resolution of raster image).  defaults are 1000 (px),
  1000 (px), "fill", and 150, respectively}

  \item{panelFn}{a function that produces a plot and takes
  one argument, which will be the current split of the data
  being passed to it.  Useful to test with
  panelFn(divExample(dat)).  Must return either an object
  of class "ggplot", "trellis", or "expression" (of base
  plot commands)}

  \item{lims}{either an object of class "trsLims" as
  obtained from \code{\link{setLims}} or a list with
  elements x, y, and prepanelFn, that specify how to apply
  \code{\link{prepanel}} and \code{\link{setLims}}}

  \item{cogFn}{a function that produces a single row of a
  data frame where each column is a cognostic feature .
  The function should takes one argument, which will be the
  current split of the data being passed to it.  Useful to
  test with cogFn(divExample(dat))}

  \item{preRender}{should the panels be pre-rendered and
  stored (\code{TRUE}), or rendered on-the-fly in the
  viewer (\code{FALSE}, default)?  Default is recommended
  unless rendering is very expensive.}

  \item{cogConn}{a connection to store the cognostics data.
  By default, this is \code{\link{dfCogConn()}}, but if
  there are many subsets (millions or more),
  \code{\link{mongoCogConn()}} is recommended (if MongoDB
  is an option).}

  \item{output}{how to store the panels and metadata for
  the display (unnecessary to specify in most cases -- see
  details)}

  \item{conn}{VDB connection info, typically stored in
  options("vdbConn") at the beginning of a session, and not
  necessary to specify here if a valid "vdbConn" object
  exists}

  \item{verbose}{print status messages?}

  \item{control}{parameters specifying how the backend
  should handle things (most-likely parameters to
  \code{\link{rhwatch}} in RHIPE) - see
  \code{\link{rhipeControl}} and
  \code{\link{localDiskControl}}}
}
\description{
  Create a trelliscope display and add it to a
  visualization database (VDB)
}
\details{
  Many of the parameters are optional or have defaults.
  For several examples, see the documentation on github:
  \url{http://hafen.github.io/trelliscope}

  Panels by default are not pre-rendered.  Instead, this
  function creates a display object and computes and stores
  the cognostics.  Then panels are rendered on the fly.  If
  a user would like to pre-render the images, then by
  default these will be stored to a local disk connection
  (see \code{\link{localDiskConn}}) inside the VDB
  directory, organized in subdirectories by group and name
  of the display.  Optionally, the user can specify the
  \code{output} parameter to be any valid "kvConnection"
  object, as long as it is one that persists on disk (e.g.
  \code{\link{hdfsConn}}).
}
\examples{
# see docs
}
\author{
  Ryan Hafen
}
\seealso{
  \code{\link{prepanel}}, \code{\link{setLims}},
  \code{\link{inputVars}}, \code{\link{divide}}
}

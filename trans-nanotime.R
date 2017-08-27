library(nanotime)
library(ggplot2)
library(scales)


nanotime_breaks <- function(n=5) {
    function(x) {
        nanotime(pretty_breaks(n)(as.numeric(x)))
    }
}

nanotime_format <- function(format = getOption("nanotimeFormat", default="%Y-%m-%dT%H:%M:%E9S%Ez"),
                            tz     = getOption("nanotimeTz", default="UTC")) {
    function(x) format(x, format, tz=tz)
}

nanotime_trans <- function(tz = NULL) {
    
    to_time <- function(x) {
        nanotime(x)
    }
    
    from_time <- function(x) {
        if (!inherits(x, "nanotime")) {
            stop("Invalid input: nanotime_trans works with objects of class ",
                 "nanotime only", call. = FALSE)
        }
        structure(as.numeric(x), names = names(x))
    }

    trans_new("nanotime", "from_time", "to_time",
              breaks=nanotime_breaks(),
              format=nanotime_format())
}

# This tells ggplot2 what scale to look for
ScaleContinuousNanotime <-
    ggproto("ScaleContinuousNanotime", ScaleContinuous,
            timezone = NULL,
            transform = function(self, x) {
                ggproto_parent(ScaleContinuous, self)$transform(x)
            },
            map = function(self, x, limits = self$get_limits()) {
                self$oob(x, limits)
            })

scale_type.nanotime <- function(x) "nanotime"
scale_nanotime <- function(aesthetics, labels=waiver(), ...) {
    print("scale_nanotime called")
    continuous_scale(aesthetics, "nanotime", identity, labels=labels,
                     guide="none", trans=nanotime_trans(), ..., super=ScaleContinuousNanotime)
}

scale_x_nanotime <- function(position="bottom", ...) {
    print("scale_x_nanotime called")
    scale_nanotime(aesthetics = c("x", "xmin", "xmax", "xend"), position=position, ...)
}

scale_y_nanotime <- function(...) {
    scale_nanotime(aesthetics = c("y", "ymin", "ymax", "yend"), ...)
}




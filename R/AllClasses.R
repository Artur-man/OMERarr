.OMEZarrArray <- setClass(
  Class = "OMEZarrArray",
  slots = c(
    meta = "list",
    levels = "list"
  )
)

#' @rdname misc
setMethod("show", 
          "OMEZarrArray", 
          function(object) {
            n.object <- length(object@levels)
            cat("class:", class(object),"\n")
            scales <- vapply(object@levels, \(x) sprintf("(%s)", paste0(dim(x), collapse=",")), character(1))
            coolcat("Scales (%d): %s", scales)
          })
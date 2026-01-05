####
# Methods ####
####

#' Methods for OMEZarrArray
#'
#' Methods for \code{OMEZarrArray} objects
#'
#' @param x,object An OMEZarrArray object
#' @param i Depends on the usage
#' \describe{
#'  \item{\code{[[}}{
#'    Here \code{i} is the level of the image pyramid.
#'    You can use the \code{length} function to get the
#'    number of the layers in the pyramid.
#'  }
#' }
#'
#' @name OMEZarrArray-methods
#' @rdname OMEZarrArray-methods
#'
#' @aliases
#' [[,OMEZarrArray,numeric-method
#'
NULL

#' @describeIn OMEZarrArray-methods Layer access
#' for \code{OMEZarrArray} objects
#'
#' @export
setMethod(
  f = '[[',
  signature = c('OMEZarrArray', "numeric"),
  definition = function(x, i) {
    return(x@levels[[i]])
  }
)

#' @describeIn OMEZarrArray-methods dimensions of an OMEZarrArray
#' @export
#' @returns dim of the first level of the OMEZarrArray object
setMethod("dim", "OMEZarrArray", function(x) dim(x[[1]]))

#' @describeIn OMEZarrArray-methods dimensions of an OMEZarrArray
#' @export
#' @returns type of OMEZarrArray object
setMethod("type", "OMEZarrArray", function(x) type(x[[1]]))

#' @describeIn OMEZarrArray-methods length of an OMEZarrArray
#' @export
#' @returns length of OMEZarrArray object
setMethod("length", signature = "OMEZarrArray", function(x) length(x@levels))

#' @describeIn OMEZarrArray-methods length of an OMEZarrArray
#' @export
#' @returns length of OMEZarrArray object
setMethod("meta", signature = "OMEZarrArray", function(object) object@meta)

#' @describeIn OMEZarrArray-methods OMEZarrArray constructor method
#'
#' A function for creating objects of OMEZarrArray class
#'
#' @param meta the metadata of the OMEZarrArray object. 
#' @param levels levels of the pyramid image, typically a vector of integers
#' starting with 1
#'
#' @importFrom S4Vectors new2
#' @importFrom Rarr read_zarr_array
#' @export
#' @return An OMEZarrArray object
read_image <- function(group, s3_client = NULL){
  
  # read metadata
  meta <- read_ome_metadata(group = group, 
                            s3_client = s3_client)
  
  # read levels
  datasets <- .get_multiscale_datasets(meta) 
  levels <- lapply(datasets, function(dataset){
    Rarr::read_zarr_array(zarr_array_path = file.path(group, dataset), 
                         s3_client = s3_client)
  })
  
  # construct class
  S4Vectors::new2("OMEZarrArray", meta = meta, levels = levels)
}

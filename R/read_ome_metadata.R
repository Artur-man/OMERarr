read_ome_metadata <- function(group, s3_client = NULL) {
  meta <- Rarr::read_zarr_attributes(zarr_path = group, 
                                     s3_client = s3_client)
  meta
}

.get_multiscale_datasets <- function(meta) {
  meta$multiscales$datasets[[1]]$path
}

.get_axes <- function(meta) {
  meta$multiscales$axes[[1]]
}
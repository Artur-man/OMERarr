setClass("BaseGroupV04", 
         slot = 
           c(attr = "list"))

# validation
.validate_BaseGroupV04 <- function(object)
{
  
}
setValidity("BaseGroupV04", .validate_BaseGroupV04)
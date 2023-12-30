rctble_format_table = function(rctble_object
                               ,striped = T
                               ,defaultPageSize = 1000
                               ,highlight = T
                               ,fullWidth = T
                               ,wrap = F
                               ,resizable = T
                               ,compact = T){

  rctble_object$x$tag$attribs$striped = striped
  rctble_object$x$tag$attribs$defaultPageSize = defaultPageSize
  rctble_object$x$tag$attribs$highlight = highlight
  rctble_object$x$tag$attribs$fullWidth = fullWidth
  rctble_object$x$tag$attribs$wrap = wrap
  rctble_object$x$tag$attribs$resizable = resizable
  rctble_object$x$tag$attribs$compact = compact

  return(rctble_object)

}

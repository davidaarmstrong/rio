#' @rdname characterize
#' @title Character conversion of labelled data
#' @description Convert labelled variables to character or factor
#' @param x A vector or data frame.
#' @param \dots additional arguments passed to methods
#' @details \code{characterize} converts a vector with a \code{labels} attribute of named levels into a character vector. \code{factorize} does the same but to factors. This can be useful at two stages of a data workflow: (1) importing labelled data from metadata-rich file formats (e.g., Stata or SPSS), and (2) exporting such data to plain text files (e.g., CSV) in a way that preserves information.
#' @examples
#' # vector method
#' x <- structure(1:4, labels = c("A" = 1, "B" = 2, "C" = 3))
#' characterize(x)
#' factorize(x)
#' 
#' # data frame method
#' x <- data.frame(v1 = structure(1:4, labels = c("A" = 1, "B" = 2, "C" = 3)),
#'                 v2 = structure(c(1,0,0,1), labels = c("foo" = 0, "bar" = 1)))
#' str(factorize(x))
#' str(characterize(x))
#' 
#' # comparison of exported file contents
#' import(export(x, "example.csv"))
#' import(export(factorize(x), "example.csv"))
#' 
#' # cleanup
#' unlink("example.csv")
#' 
#' @seealso \code{\link{gather_attrs}}
#' @export
characterize <- function(x, ...) {
    UseMethod("characterize")
}

#' @rdname characterize
#' @export
factorize <- function(x, ...) {
    UseMethod("factorize")
}

#' @rdname characterize
#' @export
characterize.default <- function(x, ...) {
    xlab <- NULL
    if(!is.null(attributes(x)$label)){
        xlab <- attributes(x)$label
    }
    
    if (!is.null(attributes(x)$labels)) {
        x <- as.character(factorize(x, ...))
        if(!is.null(xlab)){
            attr(x, "label") <- xlab
        }
        x
    } else {
        x
    }
}

#' @rdname characterize
#' @export
characterize.data.frame <- function(x, ...) {
    x[] <- lapply(x, characterize, ...)
    x
}

#' @rdname characterize
#' @export
factorize.default <- function(x, ...) {
    xlab <- NULL
    if(!is.null(attributes(x)$label)){
        xlab <- attributes(x)$label
    }
    if (!is.null(attributes(x)$labels)) {
        labs <- na.omit(attributes(x)$labels)
        x <- factor(x, labs, names(labs), ...)
        if(!is.null(xlab)){
            attr(x, "label") <- xlab
        }
        x
    } else {
        x
    }
    
}

#' @rdname characterize
#' @export
factorize.data.frame <- function(x, ...) {
    x[] <- lapply(x, factorize, ...)
    x
}

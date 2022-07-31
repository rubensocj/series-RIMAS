#' Function for importing packages
#'
#' Try to load a package, if it is not installed, perform installation
#' and loads in workspace
#'
#' @param x package names to be imported (string vector)
load_packages <- function(x) {
  for (pkg in x) {
    if(!require(pkg, character.only = TRUE)){
      install.packages(pkg, )
      library(pkg)
    }
  }
}

#' Title
#'
#' Imports a text file downloaded directly from RIMAS/CPRM website
#' with gorundwater level information from monitoring and converts
#' into a data.frame object with two column: Data and Nivel
#' 
#' @param file path to text file (a string)
#'
#' @return groundwater levels and date (data.frame)
#' @export
#'
#' @examples
import_RIMAS <- function(file) {
  require("dplyr")
  
  # file <- file.gwl[1]
  # import as text
  x <- base::readLines(file, encoding = "latin1")
  x <- x[-which(x==";;;;;;")]
  x <- x[-which(x=="")]
  
  # header (n) e data (x)
  n <- "N"#úmero de sequencia do nível d'agua;Data da medição;Hora da medição;Nível da água;Vazão;Bombeando;"
  for (i in 1:length(x)) {
    if (base::substr(x[i],1,1)==n) {
      kn <- i
      break
    }
  }
  n <- x[kn]
  x <- x[(kn+1):length(x)]
  
  # separe by ";"
  sx <- base::strsplit(x, split = ";")
  nx <- base::unlist(strsplit(n, split = ";"))
  
  # create data frame
  xm <- data.frame(matrix(unlist(sx), nrow = length(sx), byrow = T))
  names(xm) <- nx
  len <- nrow(xm)
  
  # date column correct
  xm <- xm %>% dplyr::mutate(Data = as.Date(xm[,2], "%d/%m/%Y"))
  
  # level column correct
  xm <- xm %>% dplyr::mutate(Nivel = as.numeric(gsub(",",".",xm[,4])))
  xm <- xm %>% dplyr::group_by(Data) %>% dplyr::mutate(Nivel = mean(Nivel))
  
  # date regularization in a new data frame
  dti <- xm$Data[1]
  dtf <- xm$Data[len]
  df <- data.frame(Data = seq(as.Date(dti), as.Date(dtf), by = 1))
  # df <- suppressMessages(left_join(df, select(xm, Nivel), by = "Data"))
  df <- suppressMessages(df %>% dplyr::left_join(xm))
  df <- df %>% dplyr::select(Data, Nivel)
  # names(df) <- c("Data", "Nivel")
  
  # day, month and year columns
  df <- df %>% dplyr::mutate(Ano = as.numeric(substr(Data, 1, 4)), .before = Nivel)
  df <- df %>% dplyr::mutate(Mes = as.numeric(substr(Data, 6, 7)), .before = Nivel)
  df <- df %>% dplyr::mutate(Dia = as.numeric(substr(Data, 9, 10)), .before = Nivel)
  
  return(df)
}
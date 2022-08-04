#' @Title
#' Pré-processamento de dados de níveis de água subterrânea da RIMAS
#' 
#' @description 
#' Limpa e trata os dados obtidos do portal da Rede Integrada de Monitoramento
#' de Águas Subterrâneas (RIMAS) para análise de séries temporais.
#' 
#' @details 
#' Importa um arquivo de texto separado por vírgula (extensão .csv) obtido
#' do site da RIMAS (http://rimasweb.cprm.gov.br/layout/) com a 
#' evolução do nivel d´água medido em poços de monitoramento.
#' 
#' Os dados da RIMAS são disponibilizados com periodicidade diária.
#' Para dias com mais de um registro, a função calcula a média dos valores.
#' Para dias sem registro, a função atribui um valor ausente (NA).
#' 
#' @param file string informando o caminho (local no computador) para
#' o arquivo baixado do portal RIMAS.
#'
#' @return data.frame com duas colunas: uma para a data e outra para os níveis.
#'
#' @author Rubens Oliveira da Cunha Júnior (cunhajunior.rubens@gmail.com).
#' 
#' @examples
#' caminho <- './dados/P2300020827.csv'
#' poco <- import_RIMAS(caminho)
import_RIMAS <- function(file) {
  require("dplyr")
  
  # import as text
  x <- base::readLines(file, encoding = "latin1")
  x <- x[-which(x==";;;;;;")]
  x <- x[-which(x=="")]
  
  # header (n) e data (x)
  n <- "N"
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
  df <- suppressMessages(df %>% dplyr::left_join(xm))
  df <- df %>% dplyr::select(Data, Nivel)
  
  # day, month and year columns
  df <- df %>% dplyr::mutate(Ano = as.numeric(substr(Data, 1, 4)), .before = Nivel)
  df <- df %>% dplyr::mutate(Mes = as.numeric(substr(Data, 6, 7)), .before = Nivel)
  df <- df %>% dplyr::mutate(Dia = as.numeric(substr(Data, 9, 10)), .before = Nivel)
  
  return(df)
}

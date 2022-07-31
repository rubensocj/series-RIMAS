#' @author: Rubens O. da Cunha Júnior

rm(list = ls())
cat('\014')
set.seed(1)

source(file = './r/functions.R')
source(file = './r/metrics.R')
source(file = './r/models.R')

load_packages(c('forecast','dplyr','imputeTS','tsfeatures','xtable','MASS',
                'corrplot','elmNNRcpp','keras','tensorflow'))

path.gwl <- './man/nivel/todos/'
path.results <- './man/results/main/'

# Input parameters ----
well <- 4
min.scale <- -1; max.scale <- 1
ml.par <- list('p' = 5, 'P' = 3, 'nodes.max' = 40, 'units.max' = 40,
               'layers.max' = 4, 'lstm.layers.max' = 1, 'epochs' = 400,
               'pmutation' = 0.1, 'pcrossover' = 0.9, 'max.iter' = 50,
               'popSize' = 10)

# Import ----
temp.gwl <- list.files(path = path.gwl, pattern = '*.csv')
file.gwl <- paste0(path.gwl, temp.gwl)
file.gwl <- lapply(file.gwl, import_RIMAS)
names(file.gwl) <- substring(temp.gwl, 1, nchar(temp.gwl[1])-4)

# Time series objects ----
# get average monthly GWL time series
ls.gwl.average <- suppressMessages(lapply(file.gwl, function(y) {
  return(y %>% group_by(Ano, Mes) %>% summarise(NivelMedio = mean(Nivel)))
}))

# list with all GWL time series
ls.gwl.raw <- lapply(ls.gwl.average, function(y) {
  return(ts(as.numeric(y$NivelMedio),
            start = c(y$Ano[1], y$Mes[1]),
            end = c(y$Ano[nrow(y)], y$Mes[nrow(y)]),
            frequency = 12))})

rename.gwl <- paste0("P",sprintf("%02d", 1:21))

# Missing values (MV) imputation
ls.gwl <- lapply(ls.gwl.raw, imputeTS::na_seadec)

# Target time series
ts.gwl <- ls.gwl[[well]]

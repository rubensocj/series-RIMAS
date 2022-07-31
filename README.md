# series-RIMAS

O **series-RIMAS** é um projeto que realiza o pré-processamento de dados da Rede Integrada de Monitoramento de Águas Subterrâneas (RIMAS), obtidos do portal [RIMAS *Web*](http://rimasweb.cprm.gov.br/layout/) para análise de séries temporais em linguagem `R`.

A função [import_RIMAS.R](importRIMAS.R) importa, limpa e trata os dados da RIMAS para análise de séries temporais. O arquivo de texto separado por vírgula (extensão *.csv*) obtido do site da RIMAS (http://rimasweb.cprm.gov.br/layout/) com a evolução do nivel d´água medido em poços de monitoramento é importado, e a função retorna um `data.frame` com duas colunas: data e nível.

Os dados da RIMAS são disponibilizados com periodicidade diária. Para dias com mais de um registro, a função calcula a média dos valores, e para dias sem registro, a função atribui um valor ausente (`NA`).

Este projeto foi desenvolvido no âmbito do Programa de Mestrado em Desenvolvimento Regional Sustentável (PRODER) da Universidade Federal do Cariri (UFCA).

## Instalação

Faça download do código-fonte e utilize a função [import_RIMAS.R](importRIMAS.R).

## Exemplo

## Citação

```
@MASTERSTHESIS{,
  title = {}
  author = {da Cunha Júnior, Rubens Oliveira},
  year = {2022},
  school = {Universidade Federal do Cariri},
  address = {Crato},
  type = {Mestrado em Desenvolvimento Regional Sustentável}
}
```

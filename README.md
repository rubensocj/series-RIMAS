# series-RIMAS

Este repositório contém códigos para pré-processamento de dados da Rede Integrada de Monitoramento de Águas Subterrâneas (RIMAS) para análise de séries temporais em linguagem R.

O objetivo é automatizar o tratamento dos dados da RIMAS em linguagem R, como alternativa ao tratamento dos dados de forma manual usando softwares de planilha.
Este projeto foi desenvolvido durante o Mestrado em Desenvolvimento Regional Sustentável (PRODER) da Universidade Federal do Cariri (UFCA).

As séries históricas da evolução dos níveis de água subterrânea em poços de monitoramento da RIMAS são armazenadas em arquivos de texto separado por vírgula (extensão *.csv*) que podem ser obtidos do endereço:

- http://rimasweb.cprm.gov.br/layout/

A função [import_RIMAS.R](import_RIMAS.R) importa, limpa e organiza os dados para análise de séries temporais a partir de um arquivo de extensão *.csv*.
Os dados da RIMAS são disponibilizados com periodicidade diária.
Para dias com mais de um registro, a função calcula a média dos valores, e para dias sem registro, a função atribui um valor ausente (NA).
A função retorna:

- Tabela com data e nível no formato 'data.frame'

## Instalação

Faça download do código-fonte e utilize a função [import_RIMAS.R](import_RIMAS.R).

## Exemplo

```
caminho <- './dados/P2300020827.csv'
poco <- import_RIMAS(caminho)
```

## Requisitos

Escrito usando R 4.1.2 e dplyr 1.0.7.

## Citação

```
@MASTERSTHESIS{,
  title = {Previsão do nível de água subterrânea usando ensemble de modelos de séries temporais}
  author = {da Cunha Júnior, Rubens Oliveira},
  year = {2022},
  school = {Universidade Federal do Cariri},
  address = {Crato},
  type = {Mestrado em Desenvolvimento Regional Sustentável}
}
```

## Referências
<a id="1"></a> 
CUNHA JÚNIOR, R. O. 
**Previsão do nível de água subterrânea usando ensemble de modelos de séries temporais**. 
Dissertação (Mestrado em Desenvolvimento Regional Sustentável) -
Universidade Federal do Cariri.
Crato, 2022.

<a id="2"></a> 
CUNHA JÚNIOR, R. O.; COSTA, C. T. F.; FIRMINO, P. R. A. 
Preenchimento de falhas em séries temporais de níveis de águas subterrâneas usando métodos univariados. 
*In*: XIV ENREHSE - Encontro de Recursos Hídricos em Sergipe, Aracaju-SE, 2022.
**Trabalho Técnicos**.
p. 1-6.
Disponível em: https://anais.abrhidro.org.br/job.php?Job=13793.

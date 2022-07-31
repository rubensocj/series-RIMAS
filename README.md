# series-RIMAS

O **series-RIMAS** é um projeto que realiza o pré-processamento de dados da Rede Integrada de Monitoramento de Águas Subterrâneas (RIMAS) obtidos do portal [RIMAS *Web*](http://rimasweb.cprm.gov.br/layout/) para análise de séries temporais em linguagem `R`.

A função [import_RIMAS.R](importRIMAS.R) importa, limpa e trata os dados da RIMAS para análise de séries temporais. O arquivo de texto separado por vírgula (extensão *.csv*), obtido do site da RIMAS (http://rimasweb.cprm.gov.br/layout/), com a evolução do nivel d´água em poços de monitoramento é importado, e a função retorna um `data.frame` com duas colunas: data e nível.

Os dados da RIMAS são disponibilizados com periodicidade diária. Para dias com mais de um registro, a função calcula a média dos valores, e para dias sem registro, a função atribui um valor ausente (`NA`).

A motivação para o projeto foi automatizar o tratamento dos dados da RIMAS. Trata-se de uma etapa que precede a análise, modelagem e previsão de séries temporais de níveis de água subterrânea. Uma vez que todas as etapas podem ser realizadas em linguagem `R`, a função é uma alternativa ao tratamento dos dados de forma manual usando *softwares* de planilha.

Este projeto foi desenvolvido no âmbito do Programa de Mestrado em Desenvolvimento Regional Sustentável (PRODER) da Universidade Federal do Cariri (UFCA).

## Instalação

Faça download do código-fonte e utilize a função [import_RIMAS.R](importRIMAS.R).

## Exemplo

No arquivo [main.R](main.R) há um exemplo de aplicação.

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

## Referências
<a id="1"></a> 
CUNHA JÚNIOR, R. O.; COSTA, C. T. F.; FIRMINO, P. R. A. 
Preenchimento de falhas em séries temporais de níveis de águas subterrâneas usando métodos univariados. 
*In*: XIV ENREHSE - Encontro de Recursos Hídricos em Sergipe, Aracaju-SE, 2022.
**Trabalho Técnicos**.
p. 1-6.
Disponível em: https://anais.abrhidro.org.br/job.php?Job=13793.

install.packages("factoextra")
install.packages("gridExtra")
install.packages("cluster")
install.packages("ggplot2")

library(ggplot2)
library(factoextra)
library(gridExtra)
library(cluster)

dados <- read.csv("seeds_dataset.txt", header = FALSE, sep = "")


colnames(dados) <- c("Area", "Perimeter", "Compactness", "Kernel_length", "Kernel_width", "Asymmetry_coefficient", "Kernel_groove_length", "Class")
head(dados)
summary(dados)


dados2 <- dados[, 1:7]  # Seleciona todas as colunas, exceto a classe
dados.padronizado <- scale(dados2)
head(dados.padronizado)

set.seed(5)
dados.k3 <- kmeans(dados.padronizado, centers = 3, nstart = 25, iter.max = 100)
g3 <- fviz_cluster(dados.k3, geom = "point", data = dados.padronizado) + ggtitle("K = 3")
plot(g3)

par(mfrow = c(1, 3))
boxplot(dados$Area ~ as.factor(dados.k3$cluster), col = 'blue', main = 'Área')
boxplot(dados$Perimeter ~ as.factor(dados.k3$cluster), col = 'blue', main = 'Perímetro')
boxplot(dados$Compactness ~ as.factor(dados.k3$cluster), col = 'blue', main = 'Compacidade')

#CONCLUSÃO:

#Área e Perímetro são os mais úteis para a classificação, pois apresentam claras distinções entre os clusters.
#Por outro lado podemos ver que a Compacidade pode ter alguma utilidade, mas seu poder de separação é menor.


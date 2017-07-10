
library(tm)
library(Matrix)
library(glmnet)
library(ROCR)
library(ggplot2)

# read business and world articles into one data frame
business <- read.delim('bus.tsv', header=F)
colnames(business) =c("Snippet","URL","Section","Date")
world <- read.delim('world.tsv', header=F)
colnames(world) =c("Snippet","URL","Date","Section")
articles <- rbind(business,world)

# create a Corpus from the article snippets
corpus <- Corpus(VectorSource(articles$Snippet))

# create a DocumentTermMatrix from the snippet Corpus
# remove punctuation and numbers
dtm <- DocumentTermMatrix(corpus, list(weight = weightBin,
                                       stopwords = T,
                                       removePunctuation = T,
                                       removeNumbers = T))

# convert the DocumentTermMatrix to a sparseMatrix, required by cv.glmnet
# helper function
dtm_to_sparse <- function(dtm) {
 sparseMatrix(i=dtm$i, j=dtm$j, x=dtm$v, dims=c(dtm$nrow, dtm$ncol), dimnames=dtm$dimnames)
}
sparse <- dtm_to_sparse(dtm)
# create a train / test split

sample <- sample.int(n = nrow(sparse), size = floor(0.75 * nrow(sparse)))

train <- sparse[sample,]
test <- sparse[-sample,]

train_response <- articles[sample,]
test_response <- articles[-sample,]

train_response$Section
# cross-validate logistic regression with cv.glmnet, measuring auc
logit <- cv.glmnet(train, train_response$Section, family="binomial" ,type.measure="auc")

# evaluate performance for the best-fit model


# plot ROC curve and output accuracy and AUC


# extract coefficients for words with non-zero weight
# helper function
get_informative_words <- function(crossval) {
  coefs <- coef(crossval, s="lambda.min")
  coefs <- as.data.frame(as.matrix(coefs))
  names(coefs) <- "weight"
  coefs$word <- row.names(coefs)
  row.names(coefs) <- NULL
  subset(coefs, weight != 0)
}

# show weights on words with top 10 weights for business

# show weights on words with top 10 weights for world

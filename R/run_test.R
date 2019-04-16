source("get_test_exp.R")
load("../data/expr_counts.RData")
test_exp <- get_test_exp(cd)

source("get_ordIndex.R")
t1 <- Sys.time()
ordIndex <- get_ordIndex(test_exp, 10, step_size = 1.25)
t2 <- Sys.time()
t2-t1

source("get_score.R")
t1 <- Sys.time()
score_result <- get_score(t(test_exp))
t2 <- Sys.time()
t2-t1

source("plot.R")
plot2 <- plot_bayes(score_result$bayes_score, ordIndex)
ggsave("plot2.pdf", plot2, width = 20, height = 10) 

source("get_hmm.R")
load("../data/ola_mES_2i_ordIndex.RData")
load("../data/ola_mES_2i_region.RData")
myord = c(4:1, 295:5)
t1 <- Sys.time()
hmm_result <- get_hmm_order(bayes_score = score_result$bayes_score, 
    mean_score = score_result$mean_score, 
    ordIndex = ordIndex, cls_num = 3, myord = myord, rdata = rdata)
t2 <- Sys.time()
t2-t1
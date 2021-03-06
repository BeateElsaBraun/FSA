context("capHistXXX() VALIDATE")
source("EXS_capHist.R")

test_that("capHistSum() results",{
  ## Simple two-sample test data
  ch <- capHistSum(d,cols2use=3:4)
  expect_equivalent(ch$caphist,as.table(c(2,2,1)))
  expect_equivalent(names(ch$caphist),c("01","10","11"))
  expect_equal(ch$sum,data.frame(M=3,n=3,m=1))
  
  ## Simple three-sample test data
  ch <- capHistSum(d,cols2use=3:5)
  expect_equivalent(ch$caphist,as.table(c(1,1,1,1,1)))
  expect_equivalent(names(ch$caphist),c("010","011","100","101","110"))
  tmp <- data.frame(n=c(3,3,2),m=c(0,1,2),R=c(3,3,0),M=c(0,3,5),
                    u=c(3,3,0),v=c(1,3,2),f=c(2,3,0))
  expect_equal(ch$sum,tmp)
  expect_identical(ch$methodB.top[upper.tri(ch$methodB.top)],c(1,1,1))
  expect_identical(ch$methodB.top[!upper.tri(ch$methodB.top)],as.numeric(rep(NA,6)))
  expect_equal(ch$sum,tmp)
  tmp <- matrix(c(0,3,3,3,1,2,3,3,2,0,2,0),nrow=4)
  expect_equivalent(ch$methodB.bot,tmp)
  tmp <- matrix(c(3,3,2,1,NA,NA,1,1,NA,1,2,2),nrow=3)
  expect_equivalent(ch$m.array,tmp)
})  

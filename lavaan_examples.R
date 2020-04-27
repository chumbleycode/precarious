##################################3

# make up some data with one mediator
set.seed(06052017)
X <- rnorm(100)
M <- 0.5*X + rnorm(100)
Y <- 0.7*M + rnorm(100)
Data <- data.frame(X = X, Y = Y, M = M)

# add another mediator
M2 <- -0.35*X + rnorm(100)
Y <- 0.7*M2 + 0.48*-M + rnorm(100)
Data <- data.frame(X = X, Y = Y, M1 = M, M2 = M2)

# As shown in the lavaan website performing a mediation analysis is as simple as typing in the code below:
simpleMediation <- '
    Y ~ b * M1 + c * X
    M1 ~ a * X
    indirect := a * b
    total    := c + (a * b)
'
require(lavaan)
fit <- sem(model = simpleMediation, data = Data)
summary(fit)


# Multiple mediation
###

multipleMediation <- '
Y ~ b1 * M1 + b2 * M2 + c * X
M1 ~ a1 * X
M2 ~ a2 * X
indirect1 := a1 * b1
indirect2 := a2 * b2
total := c + (a1 * b1) + (a2 * b2)
M1 ~~ M2
'
fit <- sem(model = multipleMediation, data = Data)
summary(fit) 

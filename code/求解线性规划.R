#################################################################
##          使用R求解线性规划问题 吕文博 2024.05.09            ##
##  请参考 https://www.cnblogs.com/haohai9309/p/16218804.html  ##
#################################################################

library(lpSolve)

# q1
f.con = matrix(c(2,2,1,2,4,0,0,4),
               ncol = 2,byrow = T)
f.rhs = c(12,8,16,12)
f.dir = rep('<=',4)
f.obj = c(2,3)
lp('max',
   objective.in = f.obj,
   const.mat = f.con,
   const.rhs = f.rhs,
   const.dir = f.dir) -> lp1

lp1$solution
lp1$objval

# q2
lp('max',
   objective.in = c(2,-1,2),
   const.mat = matrix(c(rep(1,3),
                        -2,0,1,
                        2,0,-1),
                      ncol = 3,byrow = T),
   const.rhs = c(6,2,0),
   const.dir = rep('>=',3)) -> lp2 
lp2$solution
lp2$objval
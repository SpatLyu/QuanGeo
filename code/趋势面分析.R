# http://www.sthda.com/english/wiki/impressive-package-for-3d-and-4d-graph-r-software-and-data-visualization

x = c(0,1.1,1.8,2.95,3.4,1.8,0.7,0.2,0.85,1.65,2.65,3.65)
y = c(1,0.6,0,0,0.2,1.7,1.3,2,3.35,3.15,3.1,2.55)
z = c(27.6,38.4,24,24.7,32,55.5,40.4,37.5,31,31.7,53,44.9)

surf.ls = \(x, y, z, np = 3, grid.lines = 100){
  require(magrittr)
  require(plotly)
  generatesurf = \(n,x = 'x',y = 'y'){if(n==1){return(paste0(x,'+',y))}
                      else{return(paste0(generatesurf(n-1,x,y),'+',
                                  paste0(x,'^',n:0,'*',y,'^',0:n,
                                         collapse = '+')))}}
  if(np <= 0){
    stop('Please provide a positive integar!')
    }else{newdata = generatesurf(np) %>% 
    stringr::str_split('\\+') %>% 
    purrr::pluck(1) %>% 
    purrr::map_dfc(\(i) eval(parse(text = i))) %>% 
    purrr::set_names(paste0('x',1:ncol(.))) %>% 
    dplyr::mutate(y = z)}
  fit = lm('y ~ .',data = newdata)
  x.pred = seq(min(x), max(x), length.out = grid.lines)
  y.pred = seq(min(y), max(y), length.out = grid.lines)
  xy = generatesurf(np,'x.pred','y.pred') %>%
    stringr::str_split('\\+') %>%
    purrr::pluck(1) %>%
    purrr::map_dfc(\(i) eval(parse(text = i))) %>%
    purrr::set_names(paste0('x',1:ncol(.))) %>% 
    as.data.frame()
  z.pred = matrix(predict(fit, newdata = xy), 
                  nrow = grid.lines, ncol = grid.lines)
  fig.surf = plot_ly(x = x.pred,y = y.pred,z = z.pred) %>% add_surface()
  surflm = summary(fit)
  coefb = surflm$coefficients[,1]
  names(coefb) = paste0('b',0:(length(coefb)-1))
  rv = list(coefb,surflm$fstatistic,fig.surf)
  names(rv) = c('coefficients','fstatistic','surface')
  return(rv)
}

surf2 = surf.ls(x, y, z, 2)

surf3 = surf.ls(x, y, z, 3)

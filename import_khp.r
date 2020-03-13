import_khp<- function(path){
  require(haven)
  require(dplyr)
  p<-c(path)
  l<-list.files(p)
  khp_ind = data.frame()
  khp_in = data.frame()
  khp_ou = data.frame()
  a = data.frame()
  b = data.frame()
  c = data.frame()
  for (i in 1:length(l)){
    if(substr(l[i],4,6) == 'ind'){
      d = read_sas(paste(p, l[i],
                              sep="/"),
                   encoding = "EUC-KR")
      year1 = substr(l[i],2,3)
      year2 = paste0('20',year1)
      if (as.numeric(year1) < 14){
        a = rbind(a,
                  cbind(select(d,
                               PIDWON, I_WGC, C3, C4_0),
                               yr = year2))
      }
      else {
        a = rbind(a,
                  cbind(select(d,
                               PIDWON, I_WGC = I_WGC_TOT, C3, C4_0),
                        yr = year2))
      }
    }
    if(substr(l[i],4,6) == 'in.'){
      d = read_sas(paste(p, l[i],
                         sep="/"),
                   encoding = "EUC-KR")
      year1 = substr(l[i],2,3)
      year2 = paste0('20',year1)
      if (as.numeric(year1) < 12){
        b = rbind(b,
                  cbind(select(d,
                               PIDWON, IN3, IN4, IN5, IN6, IN7, IN8, IN25, IN26, IN27),
                        yr = year2))
      }
      else {
        b = rbind(b,
                  cbind(select(d,
                               PIDWON, IN3, IN4, IN5, IN6, IN7, IN8, IN25 = IN25_2, IN26 = IN26_2, IN27 = IN27_2),
                        yr = year2))
      }
    }
    if(substr(l[i],4,6) == 'ou.'){
      d = read_sas(paste(p, l[i],
                         sep="/"),
                   encoding = "EUC-KR")
      year1 = substr(l[i],2,3)
      year2 = paste0('20',year1)
      if (as.numeric(year1) < 12){
        c = rbind(c,
                  cbind(select(d,
                               PIDWON, OU6, OU7, OU8, OU3, OU4, OU5),
                        yr = year2))
      }
      else {
        c = rbind(c,
                  cbind(select(d,
                               PIDWON, OU6, OU7, OU8, OU3 = OU3_2, OU4 = OU4_2, OU5 = OU5_5),
                        yr = year2))
      }
    }
  }
  assign("khp_ind",
         a,
         envir = .GlobalEnv)
  assign("khp_in",
         b,
         envir = .GlobalEnv)
  assign("khp_ou",
         c,
         envir = .GlobalEnv)
}

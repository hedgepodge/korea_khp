khp_code_list<-function(vector){
    for (i in 1:5){
      a<- c()
      b<- c()
      assign(paste0("charcode",i),
             data.frame())
      assign(paste0("numcode",i),
             data.frame())
      d = vector[is.na(str_extract(vector, "[aA-zZ]+"))]
      c = setdiff(vector,d)
      if(length(nchar(c))>0){
        for (j in 1:length(nchar(c))){
          if(nchar(c[j])==i) {
            a<- c(a,
                  c[j])
          }
        }
      }
      if(length(nchar(d))>0){
        for (j in 1:length(nchar(d))){
          if(nchar(d[j])==i) {
            b<- c(b,
                  d[j])
          }
        }
      }
      assign(paste0("charcode",i),
             a,
             envir = .GlobalEnv)
      assign(paste0("numcode",i),
             b,
             envir = .GlobalEnv)
    }
  }

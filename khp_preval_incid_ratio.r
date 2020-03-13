khp_preval_incid_ratio<-function(directory, diagnosis_code, claim_free_period){

  khp_code_list(diagnosis_code)
  
  khp_ou_select<-subset(khp_ou,
                        substr(OU3,1,1) %in% as.numeric(numcode1) | substr(OU3,1,1) %in% charcode1|
                          substr(OU4,1,1) %in% as.numeric(numcode1) | substr(OU4,1,1) %in% charcode1|
                          substr(OU5,1,1) %in% as.numeric(numcode1) | substr(OU5,1,1) %in% charcode1|
                          substr(OU3,1,2) %in% as.numeric(numcode2) | substr(OU3,1,2) %in% charcode2|
                          substr(OU4,1,2) %in% as.numeric(numcode2) | substr(OU4,1,2) %in% charcode2|
                          substr(OU5,1,2) %in% as.numeric(numcode2) | substr(OU5,1,2) %in% charcode2|
                          substr(OU3,1,3) %in% as.numeric(numcode3) | substr(OU3,1,3) %in% charcode3|
                          substr(OU4,1,3) %in% as.numeric(numcode3) | substr(OU4,1,3) %in% charcode3|
                          substr(OU5,1,3) %in% as.numeric(numcode3) | substr(OU5,1,3) %in% charcode3|
                          substr(OU3,1,4) %in% as.numeric(numcode4) | substr(OU3,1,4) %in% charcode4|
                          substr(OU4,1,4) %in% as.numeric(numcode4) | substr(OU4,1,4) %in% charcode4|
                          substr(OU5,1,4) %in% as.numeric(numcode4) | substr(OU5,1,4) %in% charcode4|
                          substr(OU3,1,5) %in% as.numeric(numcode5) | substr(OU3,1,5) %in% charcode5|
                          substr(OU4,1,5) %in% as.numeric(numcode5) | substr(OU4,1,5) %in% charcode5|
                          substr(OU5,1,5) %in% as.numeric(numcode5) | substr(OU5,1,5) %in% charcode5)
  
  khp_in_select<-subset(khp_in,
                        substr(IN25,1,1) %in% as.numeric(numcode1) | substr(IN25,1,1) %in% charcode1|
                          substr(IN26,1,1) %in% as.numeric(numcode1) | substr(IN26,1,1) %in% charcode1|
                          substr(IN27,1,1) %in% as.numeric(numcode1) | substr(IN27,1,1) %in% charcode1|
                          substr(IN25,1,2) %in% as.numeric(numcode2) | substr(IN25,1,2) %in% charcode2|
                          substr(IN26,1,2) %in% as.numeric(numcode2) | substr(IN26,1,2) %in% charcode2|
                          substr(IN27,1,2) %in% as.numeric(numcode2) | substr(IN27,1,2) %in% charcode2|
                          substr(IN25,1,3) %in% as.numeric(numcode3) | substr(IN25,1,3) %in% charcode3|
                          substr(IN26,1,3) %in% as.numeric(numcode3) | substr(IN26,1,3) %in% charcode3|
                          substr(IN27,1,3) %in% as.numeric(numcode3) | substr(IN27,1,3) %in% charcode3|
                          substr(IN25,1,4) %in% as.numeric(numcode4) | substr(IN25,1,4) %in% charcode4|
                          substr(IN26,1,4) %in% as.numeric(numcode4) | substr(IN26,1,4) %in% charcode4|
                          substr(IN27,1,4) %in% as.numeric(numcode4) | substr(IN27,1,4) %in% charcode4|
                          substr(IN25,1,5) %in% as.numeric(numcode5) | substr(IN25,1,5) %in% charcode5|
                          substr(IN26,1,5) %in% as.numeric(numcode5) | substr(IN26,1,5) %in% charcode5|
                          substr(IN27,1,5) %in% as.numeric(numcode5) | substr(IN27,1,5) %in% charcode5)
  
  khp_ou_select<-cbind(PIDWON=as.character(khp_ou_select$PIDWON),
                       select(khp_ou_select, 
                              starty=OU6, startm=OU7, startd=OU8, code1=OU3, code2=OU4, code3=OU5),
                       select(khp_ou_select,
                              endy=OU6, endm=OU7, endd=OU8),
                       io="outpatient")
  
  khp_in_select<- if(nrow(khp_in_select)==0){
    khp_in_select
  } else cbind(PIDWON=as.character(khp_in_select$PIDWON),
               select(khp_in_select,
                      starty=IN3, startm=IN4, startd=IN5, endy=IN6, endm=IN7, endd=IN8, code1=IN25, code2=IN26, code3=IN27),
               io="inpatient")
  
  khp_ind[,1]<-as.factor(khp_ind[,1])
  khp_ind[,5]<-as.numeric(as.character(khp_ind[,5]))
  
  khp_io_select<-as.data.table(rbind(khp_in_select,khp_ou_select))
  
  khp_io_select$startymd<-as.Date(with(khp_io_select, paste(2000+starty, startm, startd,sep="-")), "%Y-%m-%d")
  khp_io_select$endymd<-as.Date(with(khp_io_select, paste(2000+endy, endm, endd,sep="-")), "%Y-%m-%d")
  
  khp_io_select<-khp_io_select[complete.cases(khp_io_select),]
  
  for (i in 13:(max(khp_ind$yr)-2000)){
    khp_io_select[, paste0("claim_free_from_20", i, "_1_1") := ifelse(as.Date(paste0("20", i, "-01-01"))-khp_io_select$endymd < 1, 9999, as.Date(paste0("20", i, "-01-01"))-khp_io_select$endymd)]
    khp_io_select[, paste0("prevalent_at_20", i, "?") := ifelse(starty<=i & i<=endy, 1, 0)]
  }
  
  khp_io_summary<-summarise(group_by(khp_io_select,
                                     PIDWON))
  
  for (i in 13:(max(khp_ind$yr)-2000)){
    a<-summarise(group_by(khp_io_select,
                          PIDWON),
                 a= min(get(paste0("claim_free_from_20", i, "_1_1"))),
                 b= max(get(paste0("prevalent_at_20", i, "?"))))
    colnames(a)<-c("PIDWON", paste0("min_claim_free_from_20", i), paste0("prevalent_at_20", i, "_really?"))
    khp_io_summary<-left_join(khp_io_summary,
                              a,
                              by="PIDWON")
    rm(a)
  }
  
  khp_io_summary<-merge(khp_io_summary,
                        merge(summarise(group_by(khp_ind,
                                                 PIDWON),
                                        min_yr=min(yr)),
                              dcast(khp_ind, PIDWON~paste0("I_WGC_",yr), value.var="I_WGC", sum),
                              by="PIDWON"),
                        by="PIDWON")
  
  khp_io_summary<-as.data.table(khp_io_summary)
  
  for (i in 13:(max(khp_ind$yr)-2000)){
    khp_io_summary[, paste0("claim_free_at_20", i, "_1_1") := ifelse(get(paste0("min_claim_free_from_20", i)) >= 365 * claim_free_period, 1, 0)]
    khp_io_summary[, paste0("exist_at_20", i) := ifelse(min_yr <= 2000 + i - claim_free_period, 1, 0)]
    khp_io_summary[, paste0("incidence_weight_at_20", i) := get(paste0("prevalent_at_20", i, "_really?")) * get(paste0("claim_free_at_20", i, "_1_1")) * get(paste0("I_WGC_20",i)) * get(paste0("exist_at_20", i))]
    khp_io_summary[, paste0("prevalence_weight_at_20", i) := get(paste0("prevalent_at_20", i, "_really?")) * get(paste0("I_WGC_20",i)) * get(paste0("exist_at_20", i))]
  }
  
  write.table(khp_io_summary,
              paste0(directory, "/khp_io_summary_", diagnosis_code[1],".txt"),
              sep="\t",
              row.names=F)
  write.table(khp_io_select,
              paste0(directory, "/khp_io_select_", diagnosis_code[1],".txt"),
              sep="\t",
              row.names=F)
  
  print(diagnosis_code)
  for (i in 13:(max(khp_ind$yr)-2000)){
    options(digits = 14)
    print(paste(nrow(subset(khp_io_summary, get(paste0("incidence_weight_at_20", i))>0))),
          nrow(subset(khp_io_summary, get(paste0("prevalence_weight_at_20", i))>0)),
          sum(select(khp_io_summary, paste0("incidence_weight_at_20", i))),
          sum(select(khp_io_summary, paste0("prevalence_weight_at_20", i))),
          sep=";")
  }
}

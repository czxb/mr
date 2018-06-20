chinese_econ_dirty_data <- function(url = "http://data.eastmoney.com/cjsj/consumerpriceindex.aspx?p=", filename = "mydata.csv") {
  require(rvest)
  page <- function(url = url){
    page <- url %>% read_html() %>% html_nodes("input#pagecount") %>% html_attr("value")
    page <- as.integer(page)
    return(page)
  }
  url_init <- url
  table = data.frame()
  for(i in 1:page(url = url_init)){
    url <- paste(url_init, i)
    table <- rbind(table, as.data.frame(url %>% read_html() %>% html_table(fill = T, header = F)))
  }
  str_temp <- paste0("pageit('", page(url = url_init), "');")
  table <- table[-which(table$X2 == str_temp),]
  table <- table[,which(apply(is.na(table), 2, sum) == 0)]
  return(table)
}
library(readxl)

load_data <- function(file_path){
  data <- read_excel(file_path)
  data <- data %>% remove_rownames %>% column_to_rownames(var="Department")
  return(data[,-c(1:2)])
}



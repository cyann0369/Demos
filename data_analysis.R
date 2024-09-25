library(readxl)
library(reactable)
# library(htmltools)
library(corrplot)
library(compositions)



###################################
#Dataframes manipulation functions#
###################################

load_data <- function(file_path){
  data <- read_excel(file_path)
  data <- data %>% remove_rownames %>% column_to_rownames(var="Department")
  return(data[,-c(1:2)])
}



logratio_transform <- function(df, cols_to_transform, variant) {
  
  # Select only the columns to transform
  data <- df[, cols_to_transform]
  
  # Convert the selected columns to a composition object (required for transfotmation)
  data <- acomp(data)
  
  # Apply  transformation
  switch(variant,
         "clr"={
           data <- clr(data)
         },
         "ilr"={
           data <- ilr(data)
         },
         "alr"={
           data <- alr(data)
         })
  # Convert the transformed object to a dataframe
  data <- as.data.frame(data)
  
  # Rename ILR-transformed columns (since ILR reduces the dimensionality by 1)
  #colnames(ilr_df) <- paste0("ILR_", seq_along(1:(ncol(selected_data) - 1)))
  
  # Combine the original dataframe with the new ILR-transformed columns
  #df_transformed <- cbind(df, ilr_df)
  
  return(data)
}

##################
#Tables functions#
##################

generate_reactable_table <- function(data, columns = "all", bar_height = "16px", bar_fill = "#15607A", bar_background = "#EEEEEE") {

  # Define the bar chart function for use in the table
  bar_chart <- function(label, width = "100%", height = bar_height, fill = bar_fill, background = bar_background) {
    bar <- div(style = list(background = fill, width = width, height = height))
    chart <- div(style = list(flexGrow = 1, background = background), bar) #, marginRight = "10px"
    div(style = list(display = "flex", alignItems = "center"), label, chart)
  }

  # If columns is set to "all", use all columns from the dataset
  if (identical(columns, "all")) {
    columns <- names(data)
  }

  # Define a dynamic columns list for reactable
  col_definitions <- list()

  for (col in columns) {
    # Check if the column is numeric to apply the bar chart, else render normally
    if (is.numeric(data[[col]])) {
      col_definitions[[col]] <- colDef(align = "left", cell = function(value) {
        # Dynamically adjust bar width based on the column's maximum value
        width <- paste0(value / max(data[[col]]) * 100, "%")
        bar_chart(value, width = width)
      })
    } else {
      # Non-numeric columns just display their values as-is
      col_definitions[[col]] <- colDef(align = "left")
    }
  }

  # Render the reactable table
  reactable(
    data[, columns, drop = FALSE],  # Select only the specified columns
    columns = col_definitions
  )
}




####################
#Graphics functions#
####################

draw_correlation_heatmap <- function(data){
  graph <- corrplot(cor(data), type="upper", tl.col="black", tl.srt=45)
  return(graph)
}



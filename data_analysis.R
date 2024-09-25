library(readxl)
library(reactable)

library(caret)

load_data <- function(file_path){
  data <- read_excel(file_path)
  data <- data %>% remove_rownames %>% column_to_rownames(var="Department")
  return(data[,-c(1:2)])
}

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

# return a dataframe with scaled vars, if none are given, all columns of the dataframe will be scaled
# usage example df_scaled <- min_max_scaling(data, c("HLM", "Salairemoy", "TxPauv", "NonDiplome", "txcho"))
min_max_scaling <- function(df, columns_to_normalize = "all") {

  # If columns_to_normalize is set to "all", use all numeric columns from the dataset
  if (identical(columns_to_normalize, "all")) {
    columns_to_normalize <- names(df)[sapply(df, is.numeric)]
  }

  # Apply preProcess to the selected columns
  process <- preProcess(df[columns_to_normalize], method = c("range"))

  # Predict (normalize) the columns
  norm_columns <- predict(process, df[columns_to_normalize])

  # Replace the original columns with the normalized columns
  df[columns_to_normalize] <- norm_columns

  # Return the dataframe with scaled columns replaced
  return(df)
}


# Function to split data into train and test sets
train_test_split <- function(df, target_column = "txabs", p = 0.8) {
  # Set seed for reproducibility
  set.seed(123)

  # Create the training index
  train_index <- createDataPartition(df[[target_column]], p = p, list = FALSE)

  # Split the data into training and test sets
  train_data <- df[train_index, ]
  test_data <- df[-train_index, ]

  # Return a list containing both train and test sets
  return(list(train = train_data, test = test_data))
}

## Seperate the queries between and paramters by built in(intersection and element), and custom functions
## Apply colors if not specified
SeperateQueries <- function(queries, choice, palette){
  seperated <- list()
  for(i in 1:length(queries)){
    if(is.null(queries[[i]]$color) == T){
      queries[[i]]$color <- palette[1]
      palette <- palette[-1]
    }
    else if(is.null(queries[[i]]$color) == F){
      next
    }
  }
  if(choice == 1){
    for(i in 1:length(queries)){
      if(identical(intersects, queries[[i]]$query) == T || identical(elements, queries[[i]]$query) == T){
        seperated <- c(seperated, list(queries[[i]]))
      }
      else{
        next
      }
    }
  }
  else if(choice == 2){
    for(i in 1:length(queries)){
      if(identical(intersects, queries[[i]]$query) == F && identical(elements, queries[[i]]$query) == F){
        seperated <- c(seperated, list(queries[[i]]))
      }
      else{
        next
      }
    }
  }
  return(seperated)
}

## Combine all attribute data generated from queries 
combineQueriesData <- function(Intersection, Elements, Custom, att_x, att_y){
  all_data <- data.frame()
  all_data <- rbind(Intersection, Elements, Custom)
  if(length(all_data) == 0){
    return(NULL)
  }
  if(is.null(att_x) == F && is.null(att_y) == T){
    all_data <- all_data[order(all_data$val1), ]
  }
  else if(is.null(att_x) == F && is.null(att_y) == F){
    all_data <- all_data[order(all_data$val1, all_data$val2), ]
  }
  return(all_data)
}

## Create legend data for queries
GuideGenerator <- function(queries, palette){
  numbers <- c()
  colors <- c()
  if(length(queries) == 0){
    return(NULL)
  }
  for(i in 1:length(queries)){
    if(is.null(queries[[i]]$color) == T){
      queries[[i]]$color <- palette[1]
      palette <- palette[-1]
    }
    else if(is.null(queries[[i]]$color) == F){
      queries[[i]]$color <- queries[[i]]$color
    }
    colors[i] <- queries[[i]]$color
    numbers[i] <- paste("Query", as.character(i), sep = "")
  }
guide <- cbind(numbers, colors)
return(as.data.frame(guide))
}

## Make plot of that legend using legend data 
Make_legend <- function(legend){
  colors <- as.character(legend$colors)
  labels <- as.character(legend$numbers)
  
  leg <- legendGrob(labels =labels, pch=22,
                     gp=gpar(col = colors, fill = colors, fontsize = 8),
                     ncol = length(labels), hgap = unit(0, "lines"))
  return(leg)
}
library(msgxtractr)
library(tidyverse)
library(here)



# read list of msg files in folders
files <- list.files("data/All Files/")

# extract and save attachments and return paths
write_msg_files <- function(msg_file){
  msg <- read_msg(paste0("data/All Files/", msg_file))
  dir_name <- paste0("output/", msg_file)
  dir.create(dir_name)
  save_attachments(msg_obj = msg, path = dir_name)
  #return path and file names for attachments
  attachment_names <- list.files(dir_name)
  attachment_paths <- paste0(msg_file, "/", attachment_names)
  
  # paths <- as.data.frame(attachment_names) %>% 
  #   mutate(email = msg_file,
  #          from = unlist(msg$headers$From),
  #          body = paste(msg$body$text, collapse = "\n"))
  
  paths <- data_frame(email = msg_file,
                   from = unlist(msg$headers$From),
                   to = unlist(msg$headers$To),
                   cc = unlist(msg$headers$CC),
                   subject = unlist(msg$headers$Subject),
                   date = unlist(msg$headers$Date),
                   body = paste(msg$body$text, collapse = "\n"),
                   attachments = list(attachment_paths))
  rmarkdown::render(
    input = "output_template.Rmd",
    #output_file = paste0(paths[1,]$paths, ".html"),
    output_file = here("output", paste0(msg_file, ".html"))
  )
}


# paths <- map_dfr(files[2], write_attachments)

walk(files, write_attachments)


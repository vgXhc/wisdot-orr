library(msgxtractr)
library(tidyverse)



# read list of msg files in folders
files <- list.files("data/All Files/")

# extract and save attachments and return paths
write_attachments <- function(msg_file){
  msg <- read_msg(paste0("data/All Files/", msg_file))
  dir_name <- paste0("output/", msg_file)
  dir.create(dir_name)
  save_attachments(msg_obj = dat, path = dir_name)
  #return path and file names for attachments
  attachment_names <- list.files(dir_name)
  as.data.frame(attachment_names) %>% 
    mutate(email = msg_file,
           from = unlist(msg$headers$From),
           body = paste(msg$body$text, collapse = "\n"))
}


paths <- map_dfr(files[2], write_attachments)

write_attachments(files[1])

dat <- read_msg(paste0("data/All Files/", files[2]))

msg_text <- dat$body$text

msgxtractr::


dat
unlist(dat)

#get vector of all attachment names
attachment_names <- map_chr(dat$attachments, "long_filename")

#create text output
msg <- paste0("From: ", dat$sender$sender_name, " (", dat$sender$sender_email,")\n",
       "To: ", dat$headers$To, "\n",
       "Subject", dat$headers$Subject, "\n",
       "Attachments: ", attachment_names, "\n",
       dat$body$html)


# code for rendering parametrized report
for(i in 1:length(hospitals)){
  rmarkdown::render(
    input = "surveillance_report.Rmd",
    output_file = str_glue("output/Report_{hospitals[i]}_{Sys.Date()}.docx"),
    params = list(hospital  = hospitals[i]))
}       

rmarkdown::render(
  input = "output_template.Rmd",
  #output_file = paste0(paths[1,]$paths, ".html"),
  output_file = "output/test.docx"
  )



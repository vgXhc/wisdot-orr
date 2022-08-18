library(msgxtractr)
library(tidyverse)



# read list of msg files in folders
files <- list.files("data/All Files/")

# extract and save attachments and return paths
write_attachments <- function(msg_file){
  msg <- read_msg(paste0("data/All Files/", msg_file))
  dir_name <- paste0("data/", msg_file)
  dir.create(dir_name)
  save_attachments(msg_obj = dat, path = paste0("data/", msg_file))
  #return path and file names for attachments
  attachment_names <- list.files(paste0("data/", msg_file))
  paths <- map_chr(attachment_names, ~paste0(dir_name, .))
  as.data.frame(paths) %>% 
    mutate(email = msg_file)
}

x <- c("test", "test")
as.data.frame(x)
paths <- map_dfr(files, write_attachments)

write_attachments(files[1])

dat <- read_msg("data/All Files/Administration modification to 2021-2025 TIP for Madison area.msg")

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


save_h
dat$sender

dat$attachments


dat$attachments[[1]]$filename


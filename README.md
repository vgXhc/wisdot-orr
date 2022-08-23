# wisdot-orr
As part of an open records request, someone received a large number of MS Outlook `*.msg` files. `msg` files are a proprietary format, which can be read with the [msgextractor`](https://github.com/hrbrmstr/msgxtractr) package.

The `generate_output.R` script

- reads each message files,
- writes its attachments into a separate folder
- generates a html document with key information from the email as well as links to the attachments.

The content and format of the `html` files is determined by the `output_template.Rmd` markdown file.



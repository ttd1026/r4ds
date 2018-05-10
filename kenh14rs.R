library(tidyverse)
library(jsonlite)


json_file <- fromJSON("kenh14data.json")

transform(json_file, stack(json_file))


library(tidyverse)
library(jsonlite)

lst <- fromJSON("fuckthis.json")
transform(lst, stack(lst))

stack(lst)


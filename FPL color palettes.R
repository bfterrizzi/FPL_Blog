# color palletes for FPL Tool 


# Color Palettes
fullPalette <- c("#32073A", #dark purple
                  "#6D1B50", #mid purple
                  "#AC2F69", #light purple
                  "#77FA92", #dark green
                  "#D1FC64", #mid green
                  "#EEFC54") #light green


positionPalette <- data.frame("forwards" = "#32073A", # forwards = dark purple
                              "midfielders" = "#AC2F69", # mids = light purple
                              "defenders" = "#77FA92",# defenders = dark green
                              "keepers" = "#D1FC64") %>%  # keepers = mid green
        pivot_longer(forwards:keepers, names_to = "position", values_to = "color")


# Color Palettes
metricPalette <- c("#32073A", #dark purple
                 "#6D1B50", #mid purple
                 "#77FA92") #light purple




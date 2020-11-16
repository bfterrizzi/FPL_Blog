
# getFPL()

getFPL <- function () {
        url <- 'https://fantasy.premierleague.com/api/bootstrap-static/'
        library(jsonlite)
        request <- jsonlite::fromJSON(curl::curl(url),simplifyVector = TRUE)
}



# wrangleFPL()

wrangleFPL <- function () {
        request <- jsonlite::fromJSON("https://fantasy.premierleague.com/api/bootstrap-static/")
        ## add positions
        library(dplyr)
        elements <- data.frame(request$elements) # 'element_type' = 'id' in element_types
        element_types <- data.frame(request$element_types) %>% 
                select(id, # 'id' = "element_type" in elements df
                       plural_name, 
                       plural_name_short, 
                       singular_name, 
                       singular_name_short) 
        data <- left_join(elements, element_types, by = c("element_type" = "id")) %>%
                # change stupid fucking names 
                rename(position = singular_name,
                       position_short = singular_name_short,
                       player_code = code, 
                       position_code = element_type,
                       player_id = id)
        # change team_code to actual team name
        teams <- data.frame(request$teams)
        teams <- teams %>% select(code, name, short_name, strength) %>%
                rename(team_code = code,
                       team_name = name, 
                       team_name_abb = short_name, 
                       team_strength = strength)
        # join team names to rest of data       
        data <- left_join(data, teams, by = "team_code")
        
}



# grab top 10 highest scoring forwards 
topForwards <- function () {
        data <- wrangleFPL()
        data <- data %>% filter(position == "Forward") %>% 
                top_n(10, total_points)
}

# grab top 10 highest scoring midfielders 
topMidfielders <- function () {
        data <- wrangleFPL()
        data <- data %>% filter(position == "Midfielder") %>% 
                top_n(10, total_points)
}

# grab top 10 highest scoring defenders 
topDefenders <- function () {
        data <- wrangleFPL()
        data <- data %>% filter(position == "Defender") %>% 
                top_n(10, total_points)
}


# grab top 5 highest scoring keepers 
topKeepers <- function () {
        data <- wrangleFPL()
        data <- data %>% filter(position == "Goalkeeper") %>% 
                top_n(5, total_points)
}


# grab highest scoring players in each position 
topPlayers <- function () {
        a <- topForwards ()
        b <- topMidfielders ()
        c <- topDefenders ()
        d <- topKeepers ()
        e <- rbind(a,b,c,d)
        e <- e %>% mutate(position = factor(position, levels = c("Forward", 
                                                                 "Midfielder", 
                                                                 "Defender", 
                                                                 "Goalkeeper")))
        
}







# getEntry()

##### I want to be able to grab entry team data

# getEntry <- function(team = NULL){
#         if(is.null(team)) stop("Please enter a team ID")
#         {
#                 entry <- jsonlite::fromJSON(paste(
#                         "https://fantasy.premierleague.com/api/entry/",team,"/",sep=""))
#                 return(team)
#         }
# }




       
        


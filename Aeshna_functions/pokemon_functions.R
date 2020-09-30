# Data Science project 01
# Pokèmon
      
# 01  function to assign region according generation and pokèdex number:
#     every expression tests two conditions (Generation and Pokedex_Number )
#     to assign the corresponding pokèregion

assign_region <- function(x){
  ifelse(x["Generation"] == "I" & x["Pokedex_Number"] >= 1 & x["Pokedex_Number"] <=	151, pokemon$Region <- "Kanto", 
    ifelse(x["Generation"] == "II" & x["Pokedex_Number"] >= 152 & x["Pokedex_Number"] <=	251, pokemon$Region <- "Johto",   
      ifelse(x["Generation"] == "III" & x["Pokedex_Number"] >= 252 & x["Pokedex_Number"] <=	386, pokemon$Region <- "Hoenn",
       ifelse(x["Generation"] == "IV" & x["Pokedex_Number"] >= 387 & x["Pokedex_Number"] <=	493, pokemon$Region <- "Sinnoh",  
        ifelse(x["Generation"] == "V" & x["Pokedex_Number"] >= 494 & x["Pokedex_Number"] <=	649, pokemon$Region <- "Unova",
          ifelse(x["Generation"] == "VI" & x["Pokedex_Number"] >= 650 & x["Pokedex_Number"] <=	721, pokemon$Region <- "Kalos",
          ifelse(x["Generation"] == "VII" & x["Pokedex_Number"] >= 722 & x["Pokedex_Number"] <=	801, pokemon$Region <- "Alola", pokemon$Region <- "Other")))))))
  }

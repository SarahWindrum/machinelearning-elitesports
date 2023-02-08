# http://r-statistics.co/Linear-Regression.html

library(tidyverse)
performance_data = read_csv('21-22_Gallagher_Premiership_Data_NoSymbol.csv')

# install.packages("rlang")
library(caTools)
library(ROCR)
library(caret)

# LOOCV
cv = trainControl(method="LOOCV")

linear_model = train(Score ~ Amber_Zone_Possession_Try + Defenders_Beaten_in_Green_Zone + Linebreaks + Rucks0_Try +
                  Defence_Scrum_Offence + Green_Zone_Entries + Green_Zone_Points_Scored +
                  Green_Zone_Positive + Kick_Difference + Linebreaks_in_Green_Zone + Metres_Per_Carry + 
                  Penalties_Kicked + Penalty_Difference + Scrum_Pens_Con + Rucks1_Try + Rucks3_Try + Rucks_Three + 
                  Total_Possession_Turnovers + Tries_From_Green_Zone_Within_Three + Tries_From_Counter +  
                  Tries_From_Lineout_from_Amber + Tries_from_Set_Piece + Tries_From_Amber_Zone_Within_Three +
                  Tries_From_Grey_Zone_Within_Three + Rucks_Over_Three_Seconds_Grey_Zone + Tries_From_Brokenplay +
                  Tries_From_Lineout_from_Green + Turnovers_Conceded, data=performance_data, method="lm", trControl = cv)

print(linear_model)
 
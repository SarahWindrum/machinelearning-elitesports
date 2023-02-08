library(tidyverse)
performance_data = read_csv('21-22_Gallagher_Premiership_Data_Scrubbed_v2.csv')

# https://www.geeksforgeeks.org/logistic-regression-in-r-programming/#:~:text=Logistic%20regression%20in%20R%20Programming%20is%20a%20classification%20algorithm%20used,function%20in%20a%20binomial%20distribution.
# https://community.rstudio.com/t/splitting-data-errors/103722

# install.packages("caTools")
# install.packages("ROCR")
library(caTools)
library(ROCR)

# 50% split 
split = floor(0.5 * nrow(performance_data))
train_ = sample(seq_len(nrow(performance_data)), size = split)
train_data_50 = performance_data[train_, ]
test_data_50 = performance_data[-train_, ]

simple_model_50 = glm(RESULT ~ Penalties_Kicked + Scrums_Won +  Attacking_Breakdown_Penalties + Attacking_Not_Releasing + Complete_Opp_Half +
                  Defence_Scrum_Offence + Kick_Difference + Kick_P2 + Total_Possession_Turnovers + Tries_from_Set_Piece + Tries_From_Scrum + 
                  Turnover_Won_Opp_Half + Phase2_Possessions + Possessions_Ended_With_Kicks_In_Play + Total_Scrum_Pens_Won + 
                  Kicked_to_Touch + Amber_Zone_Possession_Try + Green_Zone_Entries + Rucks0_Try + Green_Zone_Points_Scored +
                  Green_Zone_Positive + Linebreaks_in_Green_Zone + Pens_in_Amber_Zone + Tries_From_Green_Zone +
                  Rucks_in_Grey_Zone + Tries_From_Amber_Zone_Within_3 + Tries_From_Lineout_from_Amber + Passes_in_Grey_Zone + Ruck_Speed_,
                  data = train_data_50, family = 'binomial')

simple_model_50
summary(simple_model_50)

predict_result_50 = predict(simple_model_50, test_data_50, type = "response")
predict_result_50 = ifelse(predict_result_50 > 0.5, 1, 0)

split = floor(0.5 * nrow(performance_data))
train_ = sample(seq_len(nrow(performance_data)), size = split)
train_data_50_1 = performance_data[train_, ]
test_data_50_1 = performance_data[-train_, ]

simple_model_50_1 = glm(RESULT ~ Penalties_Kicked + Scrums_Won +  Attacking_Breakdown_Penalties + Attacking_Not_Releasing + Complete_Opp_Half +
                        Defence_Scrum_Offence + Kick_Difference + Kick_P2 + Total_Possession_Turnovers + Tries_from_Set_Piece + Tries_From_Scrum + 
                        Turnover_Won_Opp_Half + Phase2_Possessions + Possessions_Ended_With_Kicks_In_Play + Total_Scrum_Pens_Won + 
                        Kicked_to_Touch + Amber_Zone_Possession_Try + Green_Zone_Entries + Rucks0_Try + Green_Zone_Points_Scored +
                        Green_Zone_Positive + Linebreaks_in_Green_Zone + Pens_in_Amber_Zone + Tries_From_Green_Zone +
                        Rucks_in_Grey_Zone + Tries_From_Amber_Zone_Within_3 + Tries_From_Lineout_from_Amber + Passes_in_Grey_Zone + Ruck_Speed_,
                      data = train_data_50_1, family = 'binomial')

predict_result_50_1 = predict(simple_model_50_1, test_data_50_1, type = "response")
predict_result_50_1 = ifelse(predict_result_50_1 > 0.5, 1, 0)

split = floor(0.5 * nrow(performance_data))
train_ = sample(seq_len(nrow(performance_data)), size = split)
train_data_50_2 = performance_data[train_, ]
test_data_50_2 = performance_data[-train_, ]

simple_model_50_2 = glm(RESULT ~ Penalties_Kicked + Scrums_Won +  Attacking_Breakdown_Penalties + Attacking_Not_Releasing + Complete_Opp_Half +
                          Defence_Scrum_Offence + Kick_Difference + Kick_P2 + Total_Possession_Turnovers + Tries_from_Set_Piece + Tries_From_Scrum + 
                          Turnover_Won_Opp_Half + Phase2_Possessions + Possessions_Ended_With_Kicks_In_Play + Total_Scrum_Pens_Won + 
                          Kicked_to_Touch + Amber_Zone_Possession_Try + Green_Zone_Entries + Rucks0_Try + Green_Zone_Points_Scored +
                          Green_Zone_Positive + Linebreaks_in_Green_Zone + Pens_in_Amber_Zone + Tries_From_Green_Zone +
                          Rucks_in_Grey_Zone + Tries_From_Amber_Zone_Within_3 + Tries_From_Lineout_from_Amber + Passes_in_Grey_Zone + Ruck_Speed_,
                        data = train_data_50_2, family = 'binomial')

predict_result_50_2 = predict(simple_model_50_2, test_data_50_2, type = "response")
predict_result_50_2 = ifelse(predict_result_50_2 > 0.5, 1, 0)

predict_result_50_3 = predict(simple_model_50, test_data_50, type = "response")
predict_result_50_3 = ifelse(predict_result_50_3 > 0.5, 1, 0)

split = floor(0.5 * nrow(performance_data))
train_ = sample(seq_len(nrow(performance_data)), size = split)
train_data_50_3 = performance_data[train_, ]
test_data_50_3 = performance_data[-train_, ]

simple_model_50_3 = glm(RESULT ~ Penalties_Kicked + Scrums_Won +  Attacking_Breakdown_Penalties + Attacking_Not_Releasing + Complete_Opp_Half +
                          Defence_Scrum_Offence + Kick_Difference + Kick_P2 + Total_Possession_Turnovers + Tries_from_Set_Piece + Tries_From_Scrum + 
                          Turnover_Won_Opp_Half + Phase2_Possessions + Possessions_Ended_With_Kicks_In_Play + Total_Scrum_Pens_Won + 
                          Kicked_to_Touch + Amber_Zone_Possession_Try + Green_Zone_Entries + Rucks0_Try + Green_Zone_Points_Scored +
                          Green_Zone_Positive + Linebreaks_in_Green_Zone + Pens_in_Amber_Zone + Tries_From_Green_Zone +
                          Rucks_in_Grey_Zone + Tries_From_Amber_Zone_Within_3 + Tries_From_Lineout_from_Amber + Passes_in_Grey_Zone + Ruck_Speed_,
                        data = train_data_50_3, family = 'binomial')

predict_result_50_3 = predict(simple_model_50_3, test_data_50_3, type = "response")
predict_result_50_3 = ifelse(predict_result_50_3 > 0.5, 1, 0)

split = floor(0.5 * nrow(performance_data))
train_ = sample(seq_len(nrow(performance_data)), size = split)
train_data_50_4 = performance_data[train_, ]
test_data_50_4 = performance_data[-train_, ]

simple_model_50_4 = glm(RESULT ~ Penalties_Kicked + Scrums_Won +  Attacking_Breakdown_Penalties + Attacking_Not_Releasing + Complete_Opp_Half +
                          Defence_Scrum_Offence + Kick_Difference + Kick_P2 + Total_Possession_Turnovers + Tries_from_Set_Piece + Tries_From_Scrum + 
                          Turnover_Won_Opp_Half + Phase2_Possessions + Possessions_Ended_With_Kicks_In_Play + Total_Scrum_Pens_Won + 
                          Kicked_to_Touch + Amber_Zone_Possession_Try + Green_Zone_Entries + Rucks0_Try + Green_Zone_Points_Scored +
                          Green_Zone_Positive + Linebreaks_in_Green_Zone + Pens_in_Amber_Zone + Tries_From_Green_Zone +
                          Rucks_in_Grey_Zone + Tries_From_Amber_Zone_Within_3 + Tries_From_Lineout_from_Amber + Passes_in_Grey_Zone + Ruck_Speed_,
                        data = train_data_50_4, family = 'binomial')

predict_result_50_4 = predict(simple_model_50_4, test_data_50_4, type = "response")
predict_result_50_4 = ifelse(predict_result_50_2 > 0.5, 1, 0)

# Confusion Matrix
table(test_data_50$RESULT, predict_result_50)
table(test_data_50$RESULT, predict_result_50_1)
table(test_data_50$RESULT, predict_result_50_2)
table(test_data_50$RESULT, predict_result_50_3)
table(test_data_50$RESULT, predict_result_50_4)

# F1 Score
# install.packages("MLmetrics")
library(MLmetrics)
F1_Score(y_pred = predict_result_50, y_true = test_data_50$RESULT)
F1_Score(y_pred = predict_result_50_1, y_true = test_data_50_1$RESULT)
F1_Score(y_pred = predict_result_50_2, y_true = test_data_50_2$RESULT)
F1_Score(y_pred = predict_result_50_3, y_true = test_data_50_3$RESULT)
F1_Score(y_pred = predict_result_50_4, y_true = test_data_50_4$RESULT)

# AUC Score
# install.packages("pROC")
library(pROC)
auc(test_data_50$RESULT, predict_result_50)
auc(test_data_50$RESULT, predict_result_50_1)
auc(test_data_50$RESULT, predict_result_50_2)
auc(test_data_50$RESULT, predict_result_50_3)
auc(test_data_50$RESULT, predict_result_50_4)


# 65% split
split = floor(0.65 * nrow(performance_data))
train_ = sample(seq_len(nrow(performance_data)), size = split)
train_data_65 = performance_data[train_, ]
test_data_65 = performance_data[-train_, ]

simple_model_65 = glm(RESULT ~ Penalties_Kicked + Scrums_Won +  Attacking_Breakdown_Penalties + Attacking_Not_Releasing + Complete_Opp_Half +
                                     Defence_Scrum_Offence + Kick_Difference + Kick_P2 + Total_Possession_Turnovers + Tries_from_Set_Piece + Tries_From_Scrum + 
                                     Turnover_Won_Opp_Half + Phase2_Possessions + Possessions_Ended_With_Kicks_In_Play + Total_Scrum_Pens_Won + 
                                     Kicked_to_Touch + Amber_Zone_Possession_Try + Green_Zone_Entries + Rucks0_Try + Green_Zone_Points_Scored +
                                     Green_Zone_Positive + Linebreaks_in_Green_Zone + Pens_in_Amber_Zone + Tries_From_Green_Zone +
                                     Rucks_in_Grey_Zone + Tries_From_Amber_Zone_Within_3 + Tries_From_Lineout_from_Amber + Passes_in_Grey_Zone + Ruck_Speed_,
                                   data = train_data_65, family = 'binomial')

simple_model_65
summary(simple_model_65)

predict_result_65 = predict(simple_model_65, test_data_65, type = "response")
predict_result_65 = ifelse(predict_result_65 > 0.5, 1, 0)

split = floor(0.65 * nrow(performance_data))
train_ = sample(seq_len(nrow(performance_data)), size = split)
train_data_65_1 = performance_data[train_, ]
test_data_65_1 = performance_data[-train_, ]

simple_model_65_1 = glm(RESULT ~ Penalties_Kicked + Scrums_Won +  Attacking_Breakdown_Penalties + Attacking_Not_Releasing + Complete_Opp_Half +
                        Defence_Scrum_Offence + Kick_Difference + Kick_P2 + Total_Possession_Turnovers + Tries_from_Set_Piece + Tries_From_Scrum + 
                        Turnover_Won_Opp_Half + Phase2_Possessions + Possessions_Ended_With_Kicks_In_Play + Total_Scrum_Pens_Won + 
                        Kicked_to_Touch + Amber_Zone_Possession_Try + Green_Zone_Entries + Rucks0_Try + Green_Zone_Points_Scored +
                        Green_Zone_Positive + Linebreaks_in_Green_Zone + Pens_in_Amber_Zone + Tries_From_Green_Zone +
                        Rucks_in_Grey_Zone + Tries_From_Amber_Zone_Within_3 + Tries_From_Lineout_from_Amber + Passes_in_Grey_Zone + Ruck_Speed_,
                      data = train_data_65_1, family = 'binomial')

predict_result_65_1 = predict(simple_model_65_1, test_data_65_1, type = "response")
predict_result_65_1 = ifelse(predict_result_65_1 > 0.5, 1, 0)

split = floor(0.65 * nrow(performance_data))
train_ = sample(seq_len(nrow(performance_data)), size = split)
train_data_65_2 = performance_data[train_, ]
test_data_65_2 = performance_data[-train_, ]

simple_model_65_2 = glm(RESULT ~ Penalties_Kicked + Scrums_Won +  Attacking_Breakdown_Penalties + Attacking_Not_Releasing + Complete_Opp_Half +
                        Defence_Scrum_Offence + Kick_Difference + Kick_P2 + Total_Possession_Turnovers + Tries_from_Set_Piece + Tries_From_Scrum + 
                        Turnover_Won_Opp_Half + Phase2_Possessions + Possessions_Ended_With_Kicks_In_Play + Total_Scrum_Pens_Won + 
                        Kicked_to_Touch + Amber_Zone_Possession_Try + Green_Zone_Entries + Rucks0_Try + Green_Zone_Points_Scored +
                        Green_Zone_Positive + Linebreaks_in_Green_Zone + Pens_in_Amber_Zone + Tries_From_Green_Zone +
                        Rucks_in_Grey_Zone + Tries_From_Amber_Zone_Within_3 + Tries_From_Lineout_from_Amber + Passes_in_Grey_Zone + Ruck_Speed_,
                      data = train_data_65_2, family = 'binomial')

predict_result_65_2 = predict(simple_model_65_2, test_data_65_2, type = "response")
predict_result_65_2 = ifelse(predict_result_65_2 > 0.5, 1, 0)

split = floor(0.65 * nrow(performance_data))
train_ = sample(seq_len(nrow(performance_data)), size = split)
train_data_65_3 = performance_data[train_, ]
test_data_65_3 = performance_data[-train_, ]

simple_model_65_3 = glm(RESULT ~ Penalties_Kicked + Scrums_Won +  Attacking_Breakdown_Penalties + Attacking_Not_Releasing + Complete_Opp_Half +
                        Defence_Scrum_Offence + Kick_Difference + Kick_P2 + Total_Possession_Turnovers + Tries_from_Set_Piece + Tries_From_Scrum + 
                        Turnover_Won_Opp_Half + Phase2_Possessions + Possessions_Ended_With_Kicks_In_Play + Total_Scrum_Pens_Won + 
                        Kicked_to_Touch + Amber_Zone_Possession_Try + Green_Zone_Entries + Rucks0_Try + Green_Zone_Points_Scored +
                        Green_Zone_Positive + Linebreaks_in_Green_Zone + Pens_in_Amber_Zone + Tries_From_Green_Zone +
                        Rucks_in_Grey_Zone + Tries_From_Amber_Zone_Within_3 + Tries_From_Lineout_from_Amber + Passes_in_Grey_Zone + Ruck_Speed_,
                      data = train_data_65_3, family = 'binomial')

predict_result_65_3 = predict(simple_model_65_3, test_data_65_3, type = "response")
predict_result_65_3 = ifelse(predict_result_65_3 > 0.5, 1, 0)

split = floor(0.65 * nrow(performance_data))
train_ = sample(seq_len(nrow(performance_data)), size = split)
train_data_65_4 = performance_data[train_, ]
test_data_65_4 = performance_data[-train_, ]

simple_model_65_4 = glm(RESULT ~ Penalties_Kicked + Scrums_Won +  Attacking_Breakdown_Penalties + Attacking_Not_Releasing + Complete_Opp_Half +
                        Defence_Scrum_Offence + Kick_Difference + Kick_P2 + Total_Possession_Turnovers + Tries_from_Set_Piece + Tries_From_Scrum + 
                        Turnover_Won_Opp_Half + Phase2_Possessions + Possessions_Ended_With_Kicks_In_Play + Total_Scrum_Pens_Won + 
                        Kicked_to_Touch + Amber_Zone_Possession_Try + Green_Zone_Entries + Rucks0_Try + Green_Zone_Points_Scored +
                        Green_Zone_Positive + Linebreaks_in_Green_Zone + Pens_in_Amber_Zone + Tries_From_Green_Zone +
                        Rucks_in_Grey_Zone + Tries_From_Amber_Zone_Within_3 + Tries_From_Lineout_from_Amber + Passes_in_Grey_Zone + Ruck_Speed_,
                      data = train_data_65_4, family = 'binomial')

predict_result_65_4 = predict(simple_model_65_4, test_data_65_4, type = "response")
predict_result_65_4 = ifelse(predict_result_65_4 > 0.5, 1, 0)

# Confusion Matrix
table(test_data_65$RESULT, predict_result_65)
table(test_data_65_1$RESULT, predict_result_65_1)
table(test_data_65_2$RESULT, predict_result_65_2)
table(test_data_65_3$RESULT, predict_result_65_3)
table(test_data_65_4$RESULT, predict_result_65_4)

# F1 Score
# install.packages("MLmetrics")
library(MLmetrics)
F1_Score(y_pred = predict_result_65, y_true = test_data_65$RESULT)
F1_Score(y_pred = predict_result_65_1, y_true = test_data_65_1$RESULT)
F1_Score(y_pred = predict_result_65_2, y_true = test_data_65_2$RESULT)
F1_Score(y_pred = predict_result_65_3, y_true = test_data_65_3$RESULT)
F1_Score(y_pred = predict_result_65_4, y_true = test_data_65_4$RESULT)

# AUC Score
# install.packages("pROC")
library(pROC)
auc(test_data_65$RESULT, predict_result_65)
auc(test_data_65_1$RESULT, predict_result_65_1)
auc(test_data_65_2$RESULT, predict_result_65_2)
auc(test_data_65_3$RESULT, predict_result_65_3)
auc(test_data_65_4$RESULT, predict_result_65_4)

# 80% split 
split = floor(0.80 * nrow(performance_data))
train_ = sample(seq_len(nrow(performance_data)), size = split)
train_data_80 = performance_data[train_, ]
test_data_80 = performance_data[-train_, ]

simple_model_80 = glm(RESULT ~ Penalties_Kicked + Scrums_Won +  Attacking_Breakdown_Penalties + Attacking_Not_Releasing + Complete_Opp_Half +
                        Defence_Scrum_Offence + Kick_Difference + Kick_P2 + Total_Possession_Turnovers + Tries_from_Set_Piece + Tries_From_Scrum + 
                        Turnover_Won_Opp_Half + Phase2_Possessions + Possessions_Ended_With_Kicks_In_Play + Total_Scrum_Pens_Won + 
                        Kicked_to_Touch + Amber_Zone_Possession_Try + Green_Zone_Entries + Rucks0_Try + Green_Zone_Points_Scored +
                        Green_Zone_Positive + Linebreaks_in_Green_Zone + Pens_in_Amber_Zone + Tries_From_Green_Zone +
                        Rucks_in_Grey_Zone + Tries_From_Amber_Zone_Within_3 + Tries_From_Lineout_from_Amber + Passes_in_Grey_Zone + Ruck_Speed_,
                      data = train_data_80, family = 'binomial')

simple_model_80
summary(simple_model_80)

predict_result_80 = predict(simple_model_80, test_data_80, type = "response")
predict_result_80 = ifelse(predict_result_80 > 0.5, 1, 0)

split = floor(0.80 * nrow(performance_data))
train_ = sample(seq_len(nrow(performance_data)), size = split)
train_data_80_1 = performance_data[train_, ]
test_data_80_1 = performance_data[-train_, ]

simple_model_80_1 = glm(RESULT ~ Penalties_Kicked + Scrums_Won +  Attacking_Breakdown_Penalties + Attacking_Not_Releasing + Complete_Opp_Half +
                        Defence_Scrum_Offence + Kick_Difference + Kick_P2 + Total_Possession_Turnovers + Tries_from_Set_Piece + Tries_From_Scrum + 
                        Turnover_Won_Opp_Half + Phase2_Possessions + Possessions_Ended_With_Kicks_In_Play + Total_Scrum_Pens_Won + 
                        Kicked_to_Touch + Amber_Zone_Possession_Try + Green_Zone_Entries + Rucks0_Try + Green_Zone_Points_Scored +
                        Green_Zone_Positive + Linebreaks_in_Green_Zone + Pens_in_Amber_Zone + Tries_From_Green_Zone +
                        Rucks_in_Grey_Zone + Tries_From_Amber_Zone_Within_3 + Tries_From_Lineout_from_Amber + Passes_in_Grey_Zone + Ruck_Speed_,
                      data = train_data_80_1, family = 'binomial')

predict_result_80_1 = predict(simple_model_80_1, test_data_80_1, type = "response")
predict_result_80_1 = ifelse(predict_result_80_1 > 0.5, 1, 0)

split = floor(0.80 * nrow(performance_data))
train_ = sample(seq_len(nrow(performance_data)), size = split)
train_data_80_2 = performance_data[train_, ]
test_data_80_2 = performance_data[-train_, ]

simple_model_80_2 = glm(RESULT ~ Penalties_Kicked + Scrums_Won +  Attacking_Breakdown_Penalties + Attacking_Not_Releasing + Complete_Opp_Half +
                        Defence_Scrum_Offence + Kick_Difference + Kick_P2 + Total_Possession_Turnovers + Tries_from_Set_Piece + Tries_From_Scrum + 
                        Turnover_Won_Opp_Half + Phase2_Possessions + Possessions_Ended_With_Kicks_In_Play + Total_Scrum_Pens_Won + 
                        Kicked_to_Touch + Amber_Zone_Possession_Try + Green_Zone_Entries + Rucks0_Try + Green_Zone_Points_Scored +
                        Green_Zone_Positive + Linebreaks_in_Green_Zone + Pens_in_Amber_Zone + Tries_From_Green_Zone +
                        Rucks_in_Grey_Zone + Tries_From_Amber_Zone_Within_3 + Tries_From_Lineout_from_Amber + Passes_in_Grey_Zone + Ruck_Speed_,
                      data = train_data_80_2, family = 'binomial')

predict_result_80_2 = predict(simple_model_80_2, test_data_80_2, type = "response")
predict_result_80_2 = ifelse(predict_result_80_2 > 0.5, 1, 0)

split = floor(0.80 * nrow(performance_data))
train_ = sample(seq_len(nrow(performance_data)), size = split)
train_data_80_3 = performance_data[train_, ]
test_data_80_3 = performance_data[-train_, ]

simple_model_80_3 = glm(RESULT ~ Penalties_Kicked + Scrums_Won +  Attacking_Breakdown_Penalties + Attacking_Not_Releasing + Complete_Opp_Half +
                        Defence_Scrum_Offence + Kick_Difference + Kick_P2 + Total_Possession_Turnovers + Tries_from_Set_Piece + Tries_From_Scrum + 
                        Turnover_Won_Opp_Half + Phase2_Possessions + Possessions_Ended_With_Kicks_In_Play + Total_Scrum_Pens_Won + 
                        Kicked_to_Touch + Amber_Zone_Possession_Try + Green_Zone_Entries + Rucks0_Try + Green_Zone_Points_Scored +
                        Green_Zone_Positive + Linebreaks_in_Green_Zone + Pens_in_Amber_Zone + Tries_From_Green_Zone +
                        Rucks_in_Grey_Zone + Tries_From_Amber_Zone_Within_3 + Tries_From_Lineout_from_Amber + Passes_in_Grey_Zone + Ruck_Speed_,
                      data = train_data_80_3, family = 'binomial')

predict_result_80_3 = predict(simple_model_80_3, test_data_80_3, type = "response")
predict_result_80_3 = ifelse(predict_result_80_3 > 0.5, 1, 0)

split = floor(0.80 * nrow(performance_data))
train_ = sample(seq_len(nrow(performance_data)), size = split)
train_data_80_4 = performance_data[train_, ]
test_data_80_4 = performance_data[-train_, ]

simple_model_80_4 = glm(RESULT ~ Penalties_Kicked + Scrums_Won +  Attacking_Breakdown_Penalties + Attacking_Not_Releasing + Complete_Opp_Half +
                        Defence_Scrum_Offence + Kick_Difference + Kick_P2 + Total_Possession_Turnovers + Tries_from_Set_Piece + Tries_From_Scrum + 
                        Turnover_Won_Opp_Half + Phase2_Possessions + Possessions_Ended_With_Kicks_In_Play + Total_Scrum_Pens_Won + 
                        Kicked_to_Touch + Amber_Zone_Possession_Try + Green_Zone_Entries + Rucks0_Try + Green_Zone_Points_Scored +
                        Green_Zone_Positive + Linebreaks_in_Green_Zone + Pens_in_Amber_Zone + Tries_From_Green_Zone +
                        Rucks_in_Grey_Zone + Tries_From_Amber_Zone_Within_3 + Tries_From_Lineout_from_Amber + Passes_in_Grey_Zone + Ruck_Speed_,
                      data = train_data_80_4, family = 'binomial')

predict_result_80_4 = predict(simple_model_80_4, test_data_80_4, type = "response")
predict_result_80_4 = ifelse(predict_result_80_4 > 0.5, 1, 0)

# Confusion Matrix
table(test_data_80$RESULT, predict_result_80)
table(test_data_80_1$RESULT, predict_result_80_1)
table(test_data_80_2$RESULT, predict_result_80_2)
table(test_data_80_3$RESULT, predict_result_80_3)
table(test_data_80_4$RESULT, predict_result_80_4)

# F1 Score
# install.packages("MLmetrics")
library(MLmetrics)
F1_Score(y_pred = predict_result_80, y_true = test_data_80$RESULT)
F1_Score(y_pred = predict_result_80_1, y_true = test_data_80_1$RESULT)
F1_Score(y_pred = predict_result_80_2, y_true = test_data_80_2$RESULT)
F1_Score(y_pred = predict_result_80_3, y_true = test_data_80_3$RESULT)
F1_Score(y_pred = predict_result_80_4, y_true = test_data_80_4$RESULT)

# AUC Score
# install.packages("pROC")
library(pROC)
auc(test_data_80$RESULT, predict_result_80)
auc(test_data_80_1$RESULT, predict_result_80_1)
auc(test_data_80_2$RESULT, predict_result_80_2)
auc(test_data_80_3$RESULT, predict_result_80_3)
auc(test_data_80_4$RESULT, predict_result_80_4)


# http://r-statistics.co/Logistic-Regression-With-R.html

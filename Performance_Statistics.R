library(tidyverse)
library(dplyr)
performance_data = read_csv('21-22_Gallagher_Premiership_Data_Scrubbed.csv')
as_tibble(performance_data)

options(max.print=99999999) # See full stats table 

# Summary Statistics for numerical data 
performance_data_v2 = read_csv('21-22_Gallagher_Premiership_Data_Scrubbed_v2.csv')
performance_data_num = dplyr::select(performance_data_v2, -Team, -Opposition, -Round)

# Min, 1st Quartile, Median, Mean, 3rd Quartile, Max
summary_stats = summary(performance_data_num)
summary_stats

# Standard Deviation
variable_sd = performance_data_num %>%
  summarise_if(is.numeric, sd)

# Outlier Box Plots
# install.packages("ggplot2")
library(ggplot2)
boxplot(performance_data_v2$Tries_Scored) + title(main = "Boxplot to Identify Potential Outliers in Tries Scored")
performance_data_outliers = dplyr::select(performance_data_v2, Tries_From_Brokenplay, Tries_From_Counter, Tries_From_Scrum, Tries_From_Turnover)
performance_data_outliers2 = dplyr::select(performance_data_v2, Tries_From_Amber_Zone_Within_3, Tries_From_Grey_Zone_Within_3,
                                           Tries_From_Red_Zone_Within_3, Tries_From_Lineout_from_Amber, Tries_from_Lineout_from_Amber_Within_3, 
                                           Tries_From_Grey_Zone,Tries_From_Red_Zone)
performance_data_outliers3 = dplyr::select(performance_data_v2, Rucks0_End_of_Play, Rucks2_Turnover_Scrum, Rucks3_Turnover_Scrum,
                                           Rucks4_Turnover_Scrum, Dropped_Ball_Red_Zone, Foul_Play_Fighting, Scrum_Pens_Won_Amber_Zone)
boxplot(performance_data_outliers) + title(main = "Boxplot to Identify Potential Outliers in Play Tries")
boxplot(performance_data_outliers2) + title(main = "Boxplot to Identify Potential Outliers in Location Tries")
boxplot(performance_data_outliers3) + title(main = "Boxplot to Identify Potential Outliers in Non-Try Play")

outliers_to_remove = dplyr::select(performance_data_v2, Tries_From_Turnover, Tries_From_Red_Zone_Within_3, Tries_from_Lineout_from_Amber_Within_3,
                                   Tries_From_Red_Zone, Rucks0_End_of_Play, Rucks3_Turnover_Scrum, Rucks4_Turnover_Scrum, Foul_Play_Fighting)
boxplot(outliers_to_remove) + title(main = "Boxplot of Outlier Variables to Remove")

boxplot.stats(performance_data_v2$Tries_From_Brokenplay)$out
boxplot.stats(performance_data_v2$Tries_From_Turnover)$out
# Correlations with Result for Play Variables
performance_data_pairs = select(performance_data, 'RESULT', 'Tries Scored', 'Tackles Made', 'Tackle Completion',
                               'Carries', 'Carries From Counter', 'Pick and Go Carries', 'Carry Meters', 'Post Contact Metres',
                               'Defenders Beaten', 'Linebreaks',  'Support Carries', 'Penalties Kicked', 'Kicks In Play',
                               'Kicks Retained', 'Kick Metres', 'Caught Full', 'Collected Bounce')

library(GGally)
ggpairs(performance_data_pairs)
performance_data_pairs2 = select(performance_data, 'RESULT', 'Kicks Inside 22', 
                                 'Kicks Outside 22', 'Kicked to Touch', 'Defensive Penalties', 'Attacking Penalties', 
                                 'Total Passes...42', 'Pass to Kick', 'Possession', 'Territory', 'Lineouts', 'Lineout %',
                                 'Scrums', 'Scrums Won', 'Scrum Pens Won', 'Ruck Speed <3', 'Gainline %', 'Total LO Mauls', 'Pens Won at Maul')
ggpairs(performance_data_pairs2)
performance_data_pairs3 = select(performance_data, 'RESULT', 'Total Rucks...58', 'Tries From Lineout', 'Tries From Scrum', 'Tries From Counter',
                                 'Tries From Turnover', 'Scrum Pens Con', 'Metres Per Carry', 'Post Contact Metres Per Carry',
                                 'Lineouts Won', 'Penalties Won', 'Pens in Own Half', 'Linebreaks Con...117', 'Carry Metres Con', 'Tries from Set Piece',
                                 'Tries From Brokenplay', 'Tries con from Set Piece', 'Tries con from Brokenplay')
ggpairs(performance_data_pairs3)

performance_data_pairs4 = select(performance_data, 'RESULT', 'Pens Con at LO Maul',
                                 'Ruck Win %', 'Possessions', 'Possessions Ended With Kicks In Play', 'Possessions Ended with Kicks to Touch',
                                 'Possessions Ended with Kick In Goal', 'Total Rucks...142', 'Total Linebreaks', 'Box Kicks Retained',
                                 'All Kicks Retained', 'Passes', 'Passes Per Possession', 'Total Maul Pens Won',
                                 'Total Scrum Pens Won', 'Defensive Open Play Penalties', 'Attacking Open Play Penalties', 'Defensive Breakdown Penalties',
                                 'Attacking Breakdown Penalties')
ggpairs(performance_data_pairs4)

performance_data_pairs5 = select(performance_data, 'RESULT', 'Turnover Won Own Half', '1 Phase Possessions', '2 Phase Possessions', '3 Phase Possessions',
                                 '4 Phase Possessions', '5 Phase Possessions', '6 Phase Possessions', '7+ Phase Possessions', 'Rucks 0-3s', 'Rucks 3-6',
                                 'Rucks 6+', 'Bomb', 'Chip', 'Cross Pitch', 'Territorial', 'Low', 'Box')
ggpairs(performance_data_pairs5)

performance_data_pairs6 = select(performance_data, 'RESULT', 'Touch Kick', 'Kick P1', 'Kick P2', 'Kick P3',
                                 'Kick P4', 'Kick P5', 'Kick P6+', 'Complete Own Half', 'Passive Own Half', 'Offload Allowed Own Half', 'Try Saver Own Half', 'Sack Own Half',
                                 'Complete Opp Half', 'Passive Opp Half', 'Offload Allowed Opp Half', 'Turnover Won Opp Half', 'Try Saver Opp Half', 'Sack Opp Half')
ggpairs(performance_data_pairs6)

performance_data_pairs7 = select(performance_data, 'RESULT', 'Carried Out of 22', 'Kicked Out of 22', 'Con Quick Rucks', 'Defensive Exits', 'Players Commited to DOOA', 'Offloads', 'Missed Tackles',
                                 'Ineffective Tackles', 'Penalties Conceded', 'Turnovers Conceded', 'Possession Lost From Kick return', 'Tries Conceded', 'Turnovers in Own Half', 
                                 'Total Possession Turnovers', 'Dissent')
ggpairs(performance_data_pairs7)

performance_data_pairs8 = select(performance_data, 'RESULT', 'Foul Play - Foot Contact', 'Bad Pass', 'Rucks Lost', 'Forced Into Touch Own Half', 'Pen Conceded Own Half',
                                 'Attacking - Not Releasing', 'Attacking - Hands in Ruck', 'Defence -Hands in Ruck', 'Attacking - Wrong Side at Ruck', 'Defence - Wrong Side at Ruck',
                                 'Attacking - Wrong Side at Maul', 'Defence - Wrong Side at Maul', 'Attacking - Offside', 'Defence - Offside')
ggpairs(performance_data_pairs8)

performance_data_pairs9 = select(performance_data, 'RESULT', 'Attacking - Offside at Kick',
                                 'Defence - Offside at Kick', 'Attacking - Collapsing Maul', 'Defence - Collapsing Maul', 'Attacking - Scrum Offence', 'Defence - Scrum Offence', 
                                 'Attacking - Lineout Offence', 'Defence - Lineout Offence', 'Attacking - Off Feet at Ruck', 'Defence - Off Feet at Ruck', 'Defence - Not Rolling Away',
                                 'Defence - Deliberate Knock On', 'Attacking - Obstruction', 'Attacking - Charging into Ruck', 'Defence - Charging into Ruck', 'Attacking - Maul Obstruction',
                                 'Other Offence')
ggpairs(performance_data_pairs9)

performance_data_pairs10 = select(performance_data, 'RESULT', 'Delaying Kick Restart', 'Foul Play - Fighting', 'Foul Play - Dangerous Throw', 'Foul Play - Late Tackle', 'Foul Play - Mid Air Tackle', 
                                  'Foul Play - High Tackle', 'Foul Play - Other', 'Missed Own Half', 'Ineffective Own Half', 'Dropped Ball Unforced', 'Forced Into Touch Opp Half', 
                                  'Pen Conceded Opp Half', 'Failed Exit From 22', 'Turnovers 1st 3 Phases From Counter')
ggpairs(performance_data_pairs10)


# Correlations with Tries Scored for Play Variables

performance_data_tries = select(performance_data, 'Tries Scored', 'Kicks Inside 22', 
                                 'Kicks Outside 22', 'Kicked to Touch', 'Defensive Penalties', 'Attacking Penalties', 
                                 'Total Passes...42', 'Pass to Kick', 'Possession', 'Territory', 'Lineouts', 'Lineout %',
                                 'Scrums', 'Scrums Won', 'Scrum Pens Won', 'Ruck Speed <3', 'Gainline %', 'Total LO Mauls', 'Pens Won at Maul')
ggpairs(performance_data_tries)

performance_data_tries1 = select(performance_data, 'Tries Scored', 'Total Rucks...58', 'Tries From Lineout', 'Tries From Scrum', 'Tries From Counter',
                                 'Tries From Turnover', 'Scrum Pens Con', 'Metres Per Carry', 'Post Contact Metres Per Carry',
                                 'Lineouts Won', 'Penalties Won', 'Pens in Own Half', 'Linebreaks Con...117', 'Carry Metres Con', 'Tries from Set Piece',
                                 'Tries From Brokenplay', 'Tries con from Set Piece', 'Tries con from Brokenplay')
ggpairs(performance_data_tries1)

performance_data_tries2 = select(performance_data, 'Tries Scored', 'Pens Con at LO Maul',
                                 'Ruck Win %', 'Possessions', 'Possessions Ended With Kicks In Play', 'Possessions Ended with Kicks to Touch',
                                 'Possessions Ended with Kick In Goal', 'Total Rucks...142', 'Total Linebreaks', 'Box Kicks Retained',
                                 'All Kicks Retained', 'Passes', 'Passes Per Possession', 'Total Maul Pens Won',
                                 'Total Scrum Pens Won', 'Defensive Open Play Penalties', 'Attacking Open Play Penalties', 'Defensive Breakdown Penalties',
                                 'Attacking Breakdown Penalties')
ggpairs(performance_data_tries2)

performance_data_tries3 = select(performance_data, 'Tries Scored', 'Turnover Won Own Half', '1 Phase Possessions', '2 Phase Possessions', '3 Phase Possessions',
                                 '4 Phase Possessions', '5 Phase Possessions', '6 Phase Possessions', '7+ Phase Possessions', 'Rucks 0-3s', 'Rucks 3-6',
                                 'Rucks 6+', 'Bomb', 'Chip', 'Cross Pitch', 'Territorial', 'Low', 'Box')
ggpairs(performance_data_tries3)

performance_data_tries4 = select(performance_data, 'Tries Scored', 'Touch Kick', 'Kick P1', 'Kick P2', 'Kick P3',
                                'Kick P4', 'Kick P5', 'Kick P6+', 'Complete Own Half', 'Passive Own Half', 'Offload Allowed Own Half', 'Try Saver Own Half', 'Sack Own Half',
                                'Complete Opp Half', 'Passive Opp Half', 'Offload Allowed Opp Half', 'Turnover Won Opp Half', 'Try Saver Opp Half', 'Sack Opp Half')
ggpairs(performance_data_tries4)

performance_data_tries5 = select(performance_data, 'Tries Scored', 'Carried Out of 22', 'Kicked Out of 22', 'Con Quick Rucks', 'Defensive Exits', 'Players Commited to DOOA', 'Offloads', 'Missed Tackles',
                                 'Ineffective Tackles', 'Penalties Conceded', 'Turnovers Conceded', 'Possession Lost From Kick return', 'Tries Conceded', 'Turnovers in Own Half', 
                                 'Total Possession Turnovers', 'Dissent')
ggpairs(performance_data_tries5)

performance_data_tries6 = select(performance_data, 'Tries Scored', 'Foul Play - Foot Contact', 'Bad Pass', 'Rucks Lost', 'Forced Into Touch Own Half', 'Pen Conceded Own Half',
                                 'Attacking - Not Releasing', 'Attacking - Hands in Ruck', 'Defence -Hands in Ruck', 'Attacking - Wrong Side at Ruck', 'Defence - Wrong Side at Ruck',
                                 'Attacking - Wrong Side at Maul', 'Defence - Wrong Side at Maul', 'Attacking - Offside', 'Defence - Offside')
ggpairs(performance_data_tries6)

performance_data_tries7 = select(performance_data, 'Tries Scored', 'Attacking - Offside at Kick',
                                 'Defence - Offside at Kick', 'Attacking - Collapsing Maul', 'Defence - Collapsing Maul', 'Attacking - Scrum Offence', 'Defence - Scrum Offence', 
                                 'Attacking - Lineout Offence', 'Defence - Lineout Offence', 'Attacking - Off Feet at Ruck', 'Defence - Off Feet at Ruck', 'Defence - Not Rolling Away',
                                 'Defence - Deliberate Knock On', 'Attacking - Obstruction', 'Attacking - Charging into Ruck', 'Defence - Charging into Ruck', 'Attacking - Maul Obstruction',
                                 'Other Offence')
ggpairs(performance_data_tries7)

performance_data_tries8 = select(performance_data, 'Tries Scored', 'Delaying Kick Restart', 'Foul Play - Fighting', 'Foul Play - Dangerous Throw', 'Foul Play - Late Tackle', 'Foul Play - Mid Air Tackle', 
                                  'Foul Play - High Tackle', 'Foul Play - Other', 'Missed Own Half', 'Ineffective Own Half', 'Dropped Ball Unforced', 'Forced Into Touch Opp Half', 
                                  'Pen Conceded Opp Half', 'Failed Exit From 22', 'Turnovers 1st 3 Phases From Counter')
ggpairs(performance_data_tries8)



# Correlations with Tries Conceded for Play Variables

performance_data_con = select(performance_data, 'Tries Conceded', 'Kicks Inside 22', 
                                'Kicks Outside 22', 'Kicked to Touch', 'Defensive Penalties', 'Attacking Penalties', 
                                'Total Passes...42', 'Pass to Kick', 'Possession', 'Territory', 'Lineouts', 'Lineout %',
                                'Scrums', 'Scrums Won', 'Scrum Pens Won', 'Ruck Speed <3', 'Gainline %', 'Total LO Mauls', 'Pens Won at Maul')
ggpairs(performance_data_con)

performance_data_con1 = select(performance_data, 'Tries Conceded', 'Total Rucks...58', 'Tries From Lineout', 'Tries From Scrum', 'Tries From Counter',
                                 'Tries From Turnover', 'Scrum Pens Con', 'Metres Per Carry', 'Post Contact Metres Per Carry',
                                 'Lineouts Won', 'Penalties Won', 'Pens in Own Half', 'Linebreaks Con...117', 'Carry Metres Con', 'Tries from Set Piece',
                                 'Tries From Brokenplay', 'Tries con from Set Piece', 'Tries con from Brokenplay')
ggpairs(performance_data_con1)

performance_data_con2 = dplyr::select(performance_data, 'Tries Conceded', 'Pens Con at LO Maul',
                                 'Ruck Win %', 'Possessions', 'Possessions Ended With Kicks In Play', 'Possessions Ended with Kicks to Touch',
                                 'Possessions Ended with Kick In Goal', 'Total Rucks...142', 'Total Linebreaks', 'Box Kicks Retained',
                                 'All Kicks Retained', 'Passes', 'Passes Per Possession', 'Total Maul Pens Won',
                                 'Total Scrum Pens Won', 'Defensive Open Play Penalties', 'Attacking Open Play Penalties', 'Defensive Breakdown Penalties',
                                 'Attacking Breakdown Penalties')
ggpairs(performance_data_con2)

performance_data_con3 = select(performance_data, 'Tries Conceded', 'Turnover Won Own Half', '1 Phase Possessions', '2 Phase Possessions', '3 Phase Possessions',
                                 '4 Phase Possessions', '5 Phase Possessions', '6 Phase Possessions', '7+ Phase Possessions', 'Rucks 0-3s', 'Rucks 3-6',
                                 'Rucks 6+', 'Bomb', 'Chip', 'Cross Pitch', 'Territorial', 'Low', 'Box')
ggpairs(performance_data_con3)

performance_data_con4 = select(performance_data, 'Tries Conceded', 'Touch Kick', 'Kick P1', 'Kick P2', 'Kick P3',
                                 'Kick P4', 'Kick P5', 'Kick P6+', 'Complete Own Half', 'Passive Own Half', 'Offload Allowed Own Half', 'Try Saver Own Half', 'Sack Own Half',
                                 'Complete Opp Half', 'Passive Opp Half', 'Offload Allowed Opp Half', 'Turnover Won Opp Half', 'Try Saver Opp Half', 'Sack Opp Half')
ggpairs(performance_data_con4)

performance_data_con5 = select(performance_data, 'Tries Conceded', 'Carried Out of 22', 'Kicked Out of 22', 'Con Quick Rucks', 'Defensive Exits', 'Players Commited to DOOA', 'Offloads', 'Missed Tackles',
                                 'Ineffective Tackles', 'Penalties Conceded', 'Turnovers Conceded', 'Possession Lost From Kick return', 'Tries Conceded', 'Turnovers in Own Half', 
                                 'Total Possession Turnovers', 'Dissent')
ggpairs(performance_data_con5)

performance_data_con6 = select(performance_data, 'Tries Conceded', 'Foul Play - Foot Contact', 'Bad Pass', 'Rucks Lost', 'Forced Into Touch Own Half', 'Pen Conceded Own Half',
                                 'Attacking - Not Releasing', 'Attacking - Hands in Ruck', 'Defence -Hands in Ruck', 'Attacking - Wrong Side at Ruck', 'Defence - Wrong Side at Ruck',
                                 'Attacking - Wrong Side at Maul', 'Defence - Wrong Side at Maul', 'Attacking - Offside', 'Defence - Offside')
ggpairs(performance_data_con6)

performance_data_con7 = select(performance_data, 'Tries Conceded', 'Attacking - Offside at Kick',
                                 'Defence - Offside at Kick', 'Attacking - Collapsing Maul', 'Defence - Collapsing Maul', 'Attacking - Scrum Offence', 'Defence - Scrum Offence', 
                                 'Attacking - Lineout Offence', 'Defence - Lineout Offence', 'Attacking - Off Feet at Ruck', 'Defence - Off Feet at Ruck', 'Defence - Not Rolling Away',
                                 'Defence - Deliberate Knock On', 'Attacking - Obstruction', 'Attacking - Charging into Ruck', 'Defence - Charging into Ruck', 'Attacking - Maul Obstruction',
                                 'Other Offence')
ggpairs(performance_data_con7)

performance_data_con8 = select(performance_data, 'Tries Conceded', 'Delaying Kick Restart', 'Foul Play - Fighting', 'Foul Play - Dangerous Throw', 'Foul Play - Late Tackle', 'Foul Play - Mid Air Tackle', 
                                 'Foul Play - High Tackle', 'Foul Play - Other', 'Missed Own Half', 'Ineffective Own Half', 'Dropped Ball Unforced', 'Forced Into Touch Opp Half', 
                                 'Pen Conceded Opp Half', 'Failed Exit From 22', 'Turnovers 1st 3 Phases From Counter')
ggpairs(performance_data_con8)


# Correlations with Result for Location Variables 

location_data_red = select(performance_data, 'RESULT', 'Pens in Red Zone', 'Rucks in Red Zone', 'Defenders Beaten in Red Zone', 'Linebreaks in Red Zone', 'Scrum Pens Won Red Zone',
                           'Tries From Red Zone', 'Tries From Red Zone Within 3', 'Passes in Red Zone', 'Maul Pens Won Red Zone', 'Rucks Over 3 Seconds Red Zone', 
                           'Rucks Under 3 Seconds Red Zone', 'Turnovers in Red Zone', 'Bad Pass Red Zone', 'Dropped Ball Red Zone')

location_data_grey = select(performance_data, 'RESULT', 'Pens in Grey Zone', 'Rucks in Grey Zone', 'Defenders Beaten in Grey Zone', 'Linebreaks in Grey Zone',
                            'Tries From Grey Zone', 'Tries From Grey Zone Within 3', 'Passes in Grey Zone', 'Maul Pens Won Grey Zone', 'Scrum Pens Won Grey Zone',
                            'Rucks Over 3 Seconds Grey Zone', 'Rucks Under 3 Seconds Grey Zone', 'Turnovers in Grey Zone', 'Bad Pass Grey Zone','Dropped Ball Grey Zone')

location_data_amber = select(performance_data, 'RESULT', 'Pens in Amber Zone', 'Rucks in Amber Zone', 'Defenders Beaten in Amber Zone', 'Linebreaks in Amber Zone',
                             'Tries From Amber Zone', 'Tries From Amber Zone Within 3', 'Tries From Lineout from Amber', 'Tries from Lineout from Amber Within 3', 
                             'Passes in Amber Zone', 'Amber Zone Possessions', 'Amber Zone Lineout Possessions', 'Amber Zone Possession Try', 'Amber Zone Possession Pen Won',
                             'Maul Pens Won Amber Zone', 'Scrum Pens Won Amber Zone', 'Rucks Over 3 Seconds Amber Zone', 'Rucks Under 3 Seconds Amber Zone', 
                             'Turnovers in Amber Zone', 'Bad Pass Amber Zone', 'Dropped Ball Amber Zone')

location_data_green = select(performance_data, 'RESULT', 'Pens in Green Zone', 'Green Zone Entries', 'Green Zone Points Scored %', 'Rucks in Green Zone', 'Defenders Beaten in Green Zone',
                             'Linebreaks in Green Zone', 'Tries From Green Zone', 'Tries From Green Zone Within 3', 'Tries From Lineout from Green', 'Tries from Lineout from Green Within 3',
                             'Passes in Green Zone', 'Maul Pens Won Green Zone', 'Scrum Pens Won Green Zone', 'Green Zone Positive', 'Rucks Over 3 Seconds Green Zone',
                             'Rucks Under 3 Seconds Green Zone', 'Turnovers in Green Zone', 'Bad Pass Green Zone', 'Dropped Ball Green Zone')
                             
ggpairs(location_data_red)
ggpairs(location_data_grey)
ggpairs(location_data_amber)
ggpairs(location_data_green)


# Correlations with Result for Rucks 

ruck_data_1 = select(performance_data, 'RESULT', '0 Rucks <3 Scrum', '0 Rucks <3 Try', '0 Rucks <3 Kick In Play', '0 Rucks <3 Pen Won', '0 Rucks <3 Pen Con', 
                     '0 Rucks <3 Kick Out of Play' , '0 Rucks <3 Other', '0 Rucks <3 Turnover (Scrum)', '0 Rucks <3 Kick Error', '0 Rucks <3 Own Lineout',
                     '0 Rucks <3 End of Play', '0 Rucks <3 Kick In Goal', '1 Rucks <3 Scrum', '1 Rucks <3 Try', '1 Rucks <3 Kick In Play')

ruck_data_2 = select(performance_data, 'RESULT', '1 Rucks <3 Pen Won', '1 Rucks <3 Pen Con', '1 Rucks <3 Kick Out of Play', '1 Rucks <3 Other', 
                     '1 Rucks <3 Turnover (Scrum)', '1 Rucks <3 Kick Error', '1 Rucks <3 Own Lineout', '1 Rucks <3 End of Play', '1 Rucks <3 Kick In Goal',
                     '2 Rucks <3 Scrum', '2 Rucks <3 Try', '2 Rucks <3 Kick In Play', '2 Rucks <3 Pen Won', '2 Rucks <3 Pen Con', '2 Rucks <3 Kick Out of Play')

ruck_data_3 = select(performance_data, 'RESULT', '2 Rucks <3 Other', '2 Rucks <3 Turnover (Scrum)', '2 Rucks <3 Kick Error', '2 Rucks <3 Own Lineout', 
                    '2 Rucks <3 End of Play', '2 Rucks <3 Kick In Goal', '3 Rucks <3 Scrum', '3 Rucks <3 Try', '3 Rucks <3 Kick In Play', '3 Rucks <3 Pen Won',
                     '3 Rucks <3 Pen Con', '3 Rucks <3 Kick Out of Play', '3 Rucks <3 Other', '3 Rucks <3 Turnover (Scrum)', '3 Rucks <3 Kick Error')

ruck_data_4 = select(performance_data, 'RESULT', '3 Rucks <3 Own Lineout', '3 Rucks <3 End of Play', '3 Rucks <3 Kick In Goal', '4+ Rucks <3 Scrum', 
                    '4+ Rucks <3 Try', '4+ Rucks <3 Kick In Play', '4+ Rucks <3 Pen Won', '4+ Rucks <3 Pen Con', '4+ Rucks <3 Kick Out of Play', 
                    '4+ Rucks <3 Other', '4+ Rucks <3 Turnover (Scrum)', '4+ Rucks <3 Kick Error', '4+ Rucks <3 Own Lineout', '4+ Rucks <3 End of Play',
                    '4+ Rucks <3 Kick In Goal')

ggpairs(ruck_data_1)
ggpairs(ruck_data_2)
ggpairs(ruck_data_3)
ggpairs(ruck_data_4)


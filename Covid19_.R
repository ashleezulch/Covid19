#This project is using data about COVID-19 from Kaggle. 
#The data was collected between January 20th and June 1st 2020. 
#My goal is to determine which countries have had the highest number of positive cases against the number of tests.

library(readr)
covid_df = read_csv("covid19.csv")
dim(covid_df)
vector_cols=colnames(covid_df)
print(vector_cols)
head(covid_df)
library(tibble)
glimpse(covid_df)
library(dplyr)
covid_df_all_states = covid19 %>% filter(Province_State == "All States") %>% select(-Province_State)
covid_df_all_states_daily= covid_df_all_states %>% select(Date, Country_Region, active, hospitalizedCurr, daily_tested, daily_positive)
covid_df_all_states_daily_sum =
  covid_df_all_states_daily %>% 
  group_by(Country_Region) %>% 
  summarise(
    tested=sum(daily_tested), 
    positive=sum(daily_positive), 
    active=sum(active),
    hospitalized=sum(hospitalizedCurr)) %>% 
  arrange(-tested)
view(covid_df_all_states_daily_sum)
covid_top_10= head(covid_df_all_states_daily_sum,10)
countries= c(covid_top_10$Country_Region)
tested_cases=c(covid_top_10$tested)
positive_cases=c(covid_top_10$positive)
active_cases=c(covid_top_10$active)
hospitalized_cases=c(covid_top_10$hospitalized)
names(tested_cases)=countries
names(positive_cases)=countries
names(active_cases)=countries
names(hospitalized_cases)=countries
positive_tested_top_3= c(united_kingdom=0.11,united_states=0.10, turkey=0.08)
united_kingdom= c(0.11, 1473672, 166909, 0, 0)
united_states= c(0.10, 17282363, 1877179, 0, 0)
turkey= c(0.08, 2031192, 163941, 2980960, 0)
covid_mat= rbind(united_kingdom, united_states, turkey)
colnames(covid_mat)= c("Ratio", "tested", "positive", "active", "hospitalized")
view(covid_mat)
question <- "Which countries have had the highest number of positive cases against the number of tests?"
answer <- c("Positive tested cases"=positive_tested_top_3)
data_structure_list <- c(covid_df, covid_df_all_states,
                         covid_df_all_states_daily,covid_top_10,covid_mat,
                         vector_cols,countries)
covid_analysis_list <- list(question,answer,data_structure_list)
covid_analysis_list[[2]]

#The data collected by Kaggle that was collected between January 20th and June 1st 2020 about covid19 shows that the three top countries that have the highest number of positive cases against the number of tests are: 
#Number 1 United Kingdom with .11, Number 2 United States with .10 and Number 3 Turkey with .08.

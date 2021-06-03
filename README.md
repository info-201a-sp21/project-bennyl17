# Project Covid-19

By: Benny Leung, Rami Wallaia, Nathan Tuan Lee, Athiwat Pathomtajeancharoen

Go to [index page](https://info-201a-sp21.github.io/project-bennyl17/index)
index url: https://info-201a-sp21.github.io/project-bennyl17/index

## Domain of Interest

We chose to do our topic on covid just because of how much it has impacted our lives this past year. We wanted to research how severe this disease actually is, at many stages throughout this time. As well as the future of covid with people now getting vaccinated and how the vaccine will affect us.

### Examples of other data driven projects related to this domain

1. **[From predictions to prescriptions: A data-driven response to COVID-19](https://link.springer.com/article/10.1007/s10729-020-09542-0)**
   - **URL Link**: _https://link.springer.com/article/10.1007/s10729-020-09542-0_
   - **Description**: This paper's goal is to assess the disease as a whole to provide the scientific community about the virus to confidently make the next steps on beating this disease. A part of the paper also assesses how contagious and deadly this virus is as well as helping to inform operational decisions for government officials, making decisions on the next steps for each state in order to operate like normal.
2. **[Forecast the dynamics of COVID-19 transmission](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0236386)**
   - **URL Link**: _https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0236386_
   - **Description**: This is a data driven project where they use data to help create a model of covid-19. This includes making predictions of the dynamics of COVID-19 transmission in six countries: China, Italy, Spain, France, Germany, and the USA. Which is then compared to other similar diseases to see if COVID-19 is more extreme or not. These forecasts are useful for planning purposes especially on how to deal with covid.
3. **[Optimized control of the COVID-19 epidemics](https://www.nature.com/articles/s41598-021-85496-9)**
   - **URL Link**: _https://www.nature.com/articles/s41598-021-85496-9_
   - **Description**: This is another data drive project where they use data to help control the pandemic by optimization of methods such as social distancing and logistics. This research was made especially within the United States, to help ease the situation of rapid increase in covid cases. They compared the economic costs of these methods and evaluate them if they are worth it or not.

### Data-driven questions related to this domain

1. **What state has the most fully vaccinated people?**
   - _Description_: This question can be answered by sorting through and looking at the dataset to see which state has the most fully vaccinated amount of people.
2. **Which continent had the highest cases, to deaths ratio in March 2021?**
   - _Description_: This question can be answered by analyzing the 2 columns in the dataset, and then dividing confirmed cases by deaths to find the highest ratio.
3. **When will the rate of covid 19 per population will equal to the rate of vaccination?**
   - _Description_: In cases where there are no columns for rates, we would mutate a column that will calculate rates of covid and compare it to the rate of vaccinations to get the exact date.

## Finding Data

1. **[USA COVID-19 Vaccinations](https://www.kaggle.com/paultimothymooney/usa-covid19-vaccinations)**
   - _URL Link_: https://www.kaggle.com/paultimothymooney/usa-covid19-vaccinations
   - _Description_: This data set gives us information about how many daily vaccinations there are daily in every state. I believe that they are partnered up with the CDC and numerous healthcare companies in order to track the vaccination campaign in the US. This is a dataset where they update it daily as well.
   - _Number of rows_ : 14
   - _Number of columns_ : 7628
   - _Questions_:
     - With this dataset, we can use it to analyze and answer the first question in the domain of interest: “What state has the most fully vaccinated people?”
     - How has the number of daily vaccinations improved since the first day?
     - Which state has the highest amount of daily vaccinations?
     - Which day of the week had the highest number of vaccinations?
2. **[Coronavirus (COVID-19) Deaths](https://ourworldindata.org/covid-deaths)**
   - _URL Link_: https://ourworldindata.org/covid-deaths
   - _Description_: The data was collected by a team of researchers and statisticians who drew data from a combination of data sources, lab reportings, and disease surveillance. The data is mainly about the deaths from coronavirus, with information about other stuff available through the csv file.
   - _Number of rows_ : 87,093
   - _Number of columns_ : 59
   - _Questions_:
     - Using this dataset we can use it to address the second question in the domain of interest: “Which continent had the highest death percentage in March 2021?”
     - Which continent had the lowest average deaths?
     - Which continent had the highest death percentage on the last day of March (3-31-2021)?
     - Which continent had the lowest death percentage?
3. **[COVID-19 in Washington State](https://www.doh.wa.gov/Emergencies/COVID19/DataDashboard)**
   - _URL Link_: https://www.doh.wa.gov/Emergencies/COVID19/DataDashboard
   - _Description_: The data was collected by the Washington state department of health COVID-10 in Washington State, where it has cases, hospitalizations, deaths, and vaccination by county in a format of XLSX file. Which I then translated into cases.csv file to make further investigation about cases of covid-19 in Washington. The data set talks about the county, cases, age and time.
   - _Number of rows_ : 2191
   - _Number of columns_ : 13
   - _Questions_:
     - With this dataset we can answer our final question in the domain of interest: “When will the rate of covid 19 per population will equal to the rate of vaccination?”
     - Which county has the most cases of covid-19
     - What age group contacted the most covid-19?
     - Which country has the least amount of cases of covid-19?

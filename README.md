# CodeClan_Final_Project_Video_Game_Sales

This is my final project for CodeClan's Professional Data Analysis course!

### The brief

"You have been hired by Donkey Games, a small games developer in Dundee. They are planning their next release and want to use data to decide what kind of game to make. They have a dataset that contains historical information on the top selling games of all time.
They want to understand what types of games sell a lot of copies. In particular they are looking for analysis that helps them decide which direction to take their company in."

The project can be broken down into 5 steps; Exploration, Cleaning, Visualisation, Modelling and the Final Presentation. All steps were undertaken in Rstudio using R, with the exception of visualisation which was done using python in Rstudio.

### Exploration

The first step I took was to look at the data and understand it, so I could figure out how it needed to be cleaned and what steps I need to take to answer the business question posed.
I looked at how complete the data was and what kind of data I had, and eventually found data online that was more complete, and gave better scope into the sales of videogames.

### Cleaning

After finding better data and gaining an understanding of what I wanted to look at, I started to clean the data. The original data I was given did have some more up to date data - sales from after 2017, so I decided I would join this onto the new dataset. I renamed columns so the datasets could be easily binded, along with grouping into categorical data into larger categories to make it easier to analyse. I also filtered to remove data I deemed unneccessary or could potentially skew my analysis.
Initially, I had wanted to look at the success of videogames by the monetary value of the sales they made, and also critic and user ratings of the games, So I made my data into two datasets for each of these metrics of success.

### Visualisation

As this was my last project I felt that I already had an excellent grasp of visualisations in R, so to challenge myself I undertook the visualisation portion of the project in Python via Rstudio, using the Reticulate package. My conclusion from this is that (in my opinion!) ggplot in R provides a much more comprehensive and user-friendly way of creating visualisations.

I looked at the success of games by different variables that we could control when creating our new game; Genre, maturity rating and the platform the game is released on. After creating the initial visualisations I realised that the critic/user scores did not really provide any meaningful information, so I decided to omit them from my final presentation. I also looked at the popularity of genres over time to determine whether data from earlier years was useful in the analysis.

### Modelling

I created a linear regression model for my data find the optimal kind of game to sell. However, due to the nature of the sales data (the data contained global sales data which was used as our outcome, along with sales by different regions of the world, meaning the model created just used these variables as predictors) the model proved to be ineffective and so I was not able to look into this any further. 
However, the model did give some insight into the importance of different sales region in overall global success.

### Final Presentation

Using powerpoint, I presented my visualisations and explained how different factors affect how successful a game is, and gave a conclusion of what kind of game could be the most popular. The powerpoint files contains speaker notes on what was discussed in the presentation.


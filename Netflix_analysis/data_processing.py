import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

df = pd.read_csv('mymoviedb.csv', lineterminator='\n')

# df.info()
'''
 #   Column             Non-Null Count  Dtype
---  ------             --------------  -----
 0   Release_Date       9827 non-null   object -> Need to change it in Date format
 1   Title              9827 non-null   object
 2   Overview           9827 non-null   object
 3   Popularity         9827 non-null   float64
 4   Vote_Count         9827 non-null   int64
 5   Vote_Average       9827 non-null   float64
 6   Original_Language  9827 non-null   object
 7   Genre              9827 non-null   object
'''

# TO find null values
# print(df.isna().sum())

# to find duplicated
# print(df.duplicated().sum())

# to calculate basic aggregate functions on numeric/float columns use below syntax
# print(df.describe())


'''
Exploration Summary
we have a dataframe consisting of 9827 rows and 9 columns.
our dataset looks a bit tidy with no NaNs nor duplicated values.
Release Date column needs to be casted into date time and to extract only the year value.
Overview, Original_Languege and Poster-Url wouldn't be so useful during analysis, so we'll drop them.
there is noticable outliers in Popularity column
Vote Average bettter be categorised for proper analysis.
Genre column has comma saperated values and white spaces that needs to be handled and casted into category. Exploration Summary
'''

# 1 step convert string to date and get only year as per problem statement
df['Release_Date'] = pd.to_datetime(df['Release_Date'])
df['Release_Date'] = df['Release_Date'].dt.year

# remove unnecessary columns
column = ['Overview', 'Original_Language', 'Poster_Url'] # array of column
df.drop(column, axis=1, inplace=True)
#print(df.columns)

# adding labels based on average vote column - popular, average, below average and not popular

def categorize_col(df, col, labels) :
    edges = [df[col].describe()['min'],
             df[col].describe()['25%'],
             df[col].describe()['50%'],
             df[col].describe()['75%'],
             df[col].describe()['max'] ]

    df[col] = pd.cut(df[col], edges, labels=labels, duplicates='drop' )

    return df

lables = ['not_popular', 'below_average', 'average', 'popular']

categorize_col(df, 'Vote_Average', lables)
# print(df['Vote_Average'].value_counts())
df.dropna(inplace=True)
# print(df.isna().sum())


df['Genre'] = df['Genre'].str.split(', ')
df = df.explode('Genre').reset_index(drop=True)



#casting column into category
df['Genre'] = df['Genre'].astype('category')
# print(df.nunique())

#Visualization

sns.set_style('whitegrid')

# what is the most frequest Genre of movies released on netflix
# print(df['Genre'].describe())
'''
count     25552
unique       19
top       Drama
freq       3715
Name: Genre, dtype: object
'''

# but let's visulaize the data
sns.catplot(y='Genre', data = df, kind='count', order=df['Genre'].value_counts().index, color='#4287f5'  )
plt.title('Genre Column Distribution')


# 2) which has highest votes in vote avg column
sns.catplot(y='Vote_Average', data=df, kind='count', order=df['Vote_Average'].value_counts().index, color='#FFD700')
plt.title("Vote_Average category distribution")
# plt.show()

# 3) what movie get the highest popularity? what is genre?

print(df[df['Popularity'] == df['Popularity'].max()])


# 4) what movie get the lowest popularity? what is genre?
print(df[df['Popularity'] == df['Popularity'].min()])

# 5) which year has the most filmmed movie
df['Release_Date'].hist()
plt.title("Release Data Column Histogram")
plt.show()
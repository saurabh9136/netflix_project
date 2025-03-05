# Netflix & Movie Data Analysis Projects
![](https://github.com/najirh/netflix_sql_project/blob/main/logo.png)
## 1. Netflix SQL Analysis
This project analyzes Netflix data using SQL queries to extract insights about movies, genres, and user interactions.

**Dataset Used:** `netflix_titles.csv`

## 2. Movie Data Analysis with Pandas & Seaborn
This project explores a dataset containing movie information, including:
- Release dates
- Popularity scores
- Vote counts & averages
- Genres

**Dataset Used:** `mymoviedb.csv`

### **Data Cleaning & Preprocessing:**
- Converted `Release_Date` to year format.
- Removed unnecessary columns (`Overview`, `Original_Language`, `Poster_Url`).
- Categorized `Vote_Average` into four labels: `not_popular`, `below_average`, `average`, `popular`.
- Split and exploded `Genre` values for better analysis.

### **Exploratory Data Analysis (EDA):**
- Identified missing & duplicate values.
- Examined outliers in the `Popularity` column.
- Checked the most frequent movie genres.
- Analyzed trends in movie releases over the years.

### **Visualizations:**
- **Genre Distribution** – Count plot of different genres.
- **Vote_Average Distribution** – Categorized vote analysis.
- **Movie Popularity** – Identified the most & least popular movies.
- **Release Year Trends** – Histogram of movie release years.

### **Tech Stack:**
- **Pandas** – Data Cleaning & Transformation
- **NumPy** – Numeric Computation
- **Matplotlib & Seaborn** – Data Visualization

---
This project helps uncover patterns in movie data using Python-based data analysis techniques.




![image](https://github.com/nyssarex/learn_dbt_with_nyssa/assets/69467191/b509fbfb-2363-4a49-bba8-83085e4ee3e3)
##### _This repo will teach you core knowledge to start use dbt-core as confident user (chunin level probably)_
# What is dbt ?
### dbt™ is a SQL-first transformation workflow that lets teams quickly and collaboratively deploy analytics code following software engineering best practices like 
- modularity
- portability
- CI/CD
- documentation
#### Now anyone on the data team can safely contribute to production-grade data pipelines.
# 0. Let's start 
### Prerequisites:
- Python( simple pipeline for source data )
- SQL( for transformation queries )
- Docker( docker-compose for Postgresql + pgAdmin )
- Git ( Github + GithubActions )
### Set up dbt locally
- Clone repo
```
git clone https://github.com/nyssarex/learn_dbt_with_nyssa.git
```
Before we start, we need some initial source of data and database to work with.\
Initial source of data is going to be [NY taxi ride data](https://www.nyc.gov/site/tlc/about/tlc-trip-record-data.page) already downloaded in this repo\
For database we are going to use Postgresql Docker container built using docker-compose.

- Deploy database using docker-compose 
```
docker-compose up
```
  
- Lets activate virtual environment to prepare setup\
Open terminal/cmd and navigate back to directory where you have cloned repo and run:
```
cd dbt 
```

- Activate the virtual environment:
For MacOS/WSL/Linux:
```
source dbt-venv/bin/activate
```
or Windows:
```
dbt-venv\Scripts\activate
```

- Load csv and parquet data from NY taxi rides to our Postgresql database
```
cd ../
```
```
python3 pipeline.py
```
It will take time to load data. Once data is loaded, let's see in pgAdmin what tables looks like. Open any browser and navigate to
```
http:localhost:8888
```
user and password are:
```
admin@admin.com 
```
```
admin
```
Add new server
name:
```
ny_taxi
```
in connection tab we write ip address of postgresql container and use password\
ip ( check ip by running this command in terminal )
```
192.168.208.3
```
or 
```
docker inspect learn_dbt_with_nyssa-pgdatabase-1
```

password
```
admin
```
- Initiate dbt project.
```
  cd dbt/dbt_ny_taxi
```
open vscode
```
code
```
```
dbt run
```
##### Congratulations we have set up dbt locally with ready db and raw data on it
# 1. Describe file structure 
A typical dbt (data build tool) project follows a structured file organization to facilitate the management, transformation, and documentation of data models. Here's an overview of the file structure:
- /models Directory\
Place where transformations .sql files are stored. You can create subdirectories for different type of data like marketing/financial/product

- /analyses Directory\
Contains SQL files for ad-hoc analyses or exploratory queries. Useful for storing queries that are not part of the core data models.

- /seeds Directory\
  Optionally used to store data that is loaded as part of the dbt project. May include sample or test data for development and testing purposes.
  
- /tests Directory\
Contains YAML files defining tests for data models. Tests help ensure that the data transformations produce expected results.

- /macros Directory\
Optional directory for storing reusable SQL macros. Macros are parameterized SQL snippets that can be used across multiple models.

- /snapshots Directory\
Contains SQL files defining snapshot models for type-2 slowly changing dimensions. Used to maintain historical versions of data over time.

- /target Directory\
Automatically generated directory containing compiled SQL files. dbt compiles and runs the SQL files to create tables or views in the target database.

- /logs Directory
Contains run logs and artifacts generated during dbt runs. Helpful for troubleshooting and monitoring the execution of dbt commands.


# 2. Learn about dbt
##### dbt is T from ETL/ELT 
dbt can transoform raw sources into for types(materilization)
- table (it is normal CREATE TABLE under the hood)
- view (it is normal CREATE VIEW under the hood)
- incremental
- ephemeral
  





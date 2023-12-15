import pandas as pd
from sqlalchemy import create_engine
import pyarrow.parquet as pq


df = pd.read_parquet('yellow_tripdata_2023-09.parquet',engine='pyarrow').head(0)
df_zone = pd.read_csv('taxi+_zone_lookup.csv')
parquet_file = pq.ParquetFile('yellow_tripdata_2023-09.parquet')

engine = create_engine('postgresql://admin:admin@localhost:5432/ny_taxi')

df_zone.to_sql(name='taxi_zone_area',con=engine,if_exists='replace')
df.to_sql(name='yellow_taxi_data',con=engine,if_exists='replace')



for i in parquet_file.iter_batches(batch_size=100000):
    i.to_pandas().to_sql(name='yellow_taxi_data',con=engine,if_exists='append')
    
    






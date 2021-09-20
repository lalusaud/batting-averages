## Batting Averages
I created a simple ruby app, which inputs a valid CSV file with data. It then processes the data set and calculates Batting Averages for all records. Finally it displays the properly formated result set in the console.


### run in console as
```
# > ruby program.rb --file Input.csv --years 1877,1878 --teams "Providence Grays",""Louisville Grays"
```
# or
```
# > ruby program.rb -f Input.csv -y 1877 -t "Louisville Grays"
```
##### Notes: 
1. You can pass multiple (comma separated) values for filter params (--years & --teams)
2. filters (--years & --teams) are optional, however input file (--file) is required!

### On successful run, it might display output as:
```
+-----------+--------+------------------+-----------------+
| playerID  | yearID | Team name(s)     | Batting Average |
+-----------+--------+------------------+-----------------+
| hallge01  | 1877   | Louisville Grays | 0.323           |
| gerhajo01 | 1877   | Louisville Grays | 0.304           |
| lathaju01 | 1877   | Louisville Grays | 0.291           |
| shaffor01 | 1877   | Louisville Grays | 0.285           |
| crowlbi01 | 1877   | Louisville Grays | 0.282           |
| devliji01 | 1877   | Louisville Grays | 0.269           |
| haguebi01 | 1877   | Louisville Grays | 0.266           |
| cravebi01 | 1877   | Louisville Grays | 0.265           |
| snydepo01 | 1877   | Louisville Grays | 0.258           |
| nichoal01 | 1877   | Louisville Grays | 0.211           |
| laffefl01 | 1877   | Louisville Grays | 0.059           |
| littlha01 | 1877   | Louisville Grays | 0.0             |
| haldejo01 | 1877   | Louisville Grays | 0.0             |
+-----------+--------+------------------+-----------------+
```

## Limitations
1. No TDD at the moment!
2. The solution may not be scalable when the data volume grows, it will require using database or file streaming methodology to scale it, if the input data set is large. I consider the solution is optimal for few hundreds to thousands rows of data.
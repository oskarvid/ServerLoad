# ServerLoad
A simple server load bash and R script for graphing CPU, disk and RAM usage

Sample CPU usage graph
![Disk-graph](https://raw.githubusercontent.com/oskarvid/ServerLoad/master/.SystemLoad.png)

Sample disk usage graph
![Disk-graph](https://raw.githubusercontent.com/oskarvid/ServerLoad/master/.DiskUsage.png)

Sample RAM usage graph
![Disk-graph](https://raw.githubusercontent.com/oskarvid/ServerLoad/master/.RAM-Usage.png)


## Dependencies
Docker

# Usage
Run `./serverload.sh sda2` (or whatever partition you want to monitor) to start monitoring the system resource usage. An output file named `mylogfile-and-a-long-date` will get created in the `input` directory. 
To create the graph, run `./get-graphs input/mylogfile-and-a-long-date`.

Behind the scenes the get-graphs.sh script will begin by verifying that the syntax is correct with a regular expression, 
it's an experiment, maybe it's not necessary, I don't know, just uncomment it if it's buggy.  
Anyhow, then it runs 
`docker run --rm -ti -u $(id -u $USER):$(id -g $USER) -v $(pwd):/data r-base Rscript /data/systemLoad.R /data/$1` to actually create the graphs.

If you don't already have the `r-base` docker image it will get downloaded automatically when the script runs.

Output files named `DiskUsage.png`, `RAM-Usage.png` and `SystemLoad.png` will get created in the directory that you ran the `get-graphs.sh` script from.

## Disclaimer
The `serverload.sh` script is a severe hack, it works so far, but it's not pretty.

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
Run `./serverload.sh` to start monitoring the system resource usage. An output file named `mylogfile-and-a-long-date` will get created in the `input` directory. 
To create the graph, run `./get-graphs input/mylogfile-and-a-long-date`.

Behind the scenes the get-graphs.sh script will run 
`docker run --rm -ti -u $(id -u $USER):$(id -g $USER) -v $(pwd):/data r-base Rscript /data/systemLoad.R /data/$1`

If you don't already have the `r-base` docker image it will get downloaded automatically

Output files named `DiskUsage.png`, `RAM-Usage.png` and `SystemLoad.png` will get created in the directory that you ran the `get-graphs.sh` script from.

## Disclaimer
The `serverload.sh` script is a severe hack, it works so far, but it's not pretty.

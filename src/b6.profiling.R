# Performance and Profiling

## Rprof
file <- tempfile()
Rprof(file, line.profiling=TRUE, memory.profiling=TRUE)
eval(parse(file = "tasks/task1.R", keep.source=TRUE))
Rprof(NULL)

summaryRprof(file, lines = "show", memory = "both")
file.remove(file)

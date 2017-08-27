ggplot graphing data.table nanotime time-series in R


## data.table nanotime time-series

With these definition, it is possible to graph with ggplot a `data.table` and `nanotime`-based time-series.

Here is an example of such a time-series:

~~~ R
library(data.table)
idx <- nanotime(1) + 1e9*(1:100)
dt <- data.table(idx=idx, a=1:100, b=11:110)
~~~

## Graphing

Using `ggplot` and sourcing "trans-nanotime.R":


~~~ R
source("trans-nanotime.R")


ggplot(dt, aes(x=idx, y=b)) +
    geom_line() +
    theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
    scale_x_nanotime(labels = nanotime_format("%Y-%m-%d %H:%M:%S"))

ggplot(dt, aes(x=idx, y=b)) +
    geom_line()


ggplot(dt, aes(x=idx, y=b)) +
    geom_line() +
    theme(axis.text.x = element_text(angle = 90, hjust = 1))

ggplot(dt, aes(x=idx, y=b)) +
    geom_line() +
    theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
    scale_x_continuous(trans=nanotime_trans(), labels=nanotime_format("%H:%M:%S"))
~~~

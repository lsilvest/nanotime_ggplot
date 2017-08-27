source("trans-nanotime.R")

library(data.table)


idx <- nanotime(1) + 1e9*(1:100)
dt <- data.table(idx=idx, a=1:100, b=11:110)


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



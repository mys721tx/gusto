#!/usr/bin/env Rscript

if (!require("pacman")) {
    install.packages("pacman")
}

pacman::p_load("tidyverse", "optparse")

library(tools)
library(tidyverse)
library(optparse)

parser <- OptionParser(usage = "%prog [options] file")

arguments <- parse_args(parser, positional_arguments = 1)

score_file <- normalizePath(arguments$args)

if (file.access(score_file) == -1) {
    stop(sprintf("Specified file (%s) does not exist", file))
} else {
    score <- read_csv(score_file) %>%
    group_by(name, perm) %>%
    summarize(score = ceiling(sum(score_received) * 1.25))

    path <- dirname(score_file)
    base <- basename(score_file)

    score %>% write_csv(
        file.path(
            path,
            paste0(
                file_path_sans_ext(base),
                "_total.csv"
            )
        )
    )

    (ggplot(score, aes(x = score)) + geom_histogram(bins = 5)) %>%
    ggsave(
        filename = file.path(
            path,
            paste0(
                file_path_sans_ext(base),
                ".png"
            )
        )
    )
}

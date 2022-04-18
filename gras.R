#!/usr/bin/env Rscript

if (!require("pacman")) {
    install.packages("pacman")
}

pacman::p_load("tidyverse", "argparser")

library(tools)
library(tidyverse)
library(argparser)

p <- arg_parser("Grade Result Average Summrizer", hide.opts = TRUE)

p <- add_argument(p, "file", help = "input file")
p <- add_argument(
    p,
    "--scale",
    help = "scaling factor for total score",
    default = "1"
)

args <- parse_args(p)

score_file <- normalizePath(args$file)
scale <- args$scale %>% as.numeric()

if (file.access(score_file) == -1) {
    stop(sprintf("Specified file (%s) does not exist", file))
} else {
    score <- read_csv(score_file) %>%
    group_by(name, perm) %>%
    summarize(score = ceiling(sum(score_received) * scale))

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

    (
        ggplot(score, aes(x = score)) + geom_histogram(bins = 5)
    ) %>%
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

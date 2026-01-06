#!/usr/bin/env Rscript

# libraries
library(OMERarr)

# ---- Simple CLI test script ----
args <- commandArgs(trailingOnly = TRUE)

if (length(args) == 0 || "--help" %in% args) {
  cat("
test_cli.R — dummy CLI for testing

Usage:
  test_cli.R --name NAME --number N [--flag]

Arguments:
  --name     A character string
  --number   A numeric value
  --flag     Optional logical flag

Example:
  test_cli.R --name Alice --number 42 --flag
")
  quit(status = 0)
}

# Simple argument parser (very naive on purpose)
get_arg <- function(flag) {
  i <- match(flag, args)
  if (!is.na(i) && i < length(args)) args[i + 1] else NA
}

name   <- get_arg("--name")
number <- as.numeric(get_arg("--number"))
flag   <- "--flag" %in% args

cat("Parsed arguments:\n")
cat("  name   :", name, "\n")
cat("  number :", number, "\n")
cat("  flag   :", flag, "\n")

cat("\nDoing some fake work...\n")
Sys.sleep(1)
cat("Done ✅\n")
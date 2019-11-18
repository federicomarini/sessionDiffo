args <- (commandArgs(trailingOnly = TRUE))
for (i in seq_len(length(args))) {
  eval(parse(text = args[[i]]))
}

## List the R version and all packages used in the analyses together with the
## version, by parsing the files in the "Routdir" directory. The results are
## written to the "outtxt" text file.

# print(Routdir)
# print(outtxt)
#
# lf <- list.files(Routdir)

parse_si <- function(si) {
  x <- readLines(si)

  # TODO:
  # if it does not start with sessionInfo(), warn?
  # options: attached via namespace, include or not
  # system/platform to be included?

  sil <- list()
  idx1 <- which(x == "> sessionInfo()")
  idx2 <- which(x == "other attached packages:")
  idx3 <- which(x == "loaded via a namespace (and not attached):")
  all_packages <- c()
  if (length(idx1) != 0 & length(idx2) != 0 & length(idx3) != 0) {
    all_packages <-
      unique(c(all_packages,
               # x[idx1 + 1],
               do.call(c, lapply((idx2 + 1):(idx3 - 2), function(i) {
                 grep("\\[", setdiff(setdiff(strsplit(x[i], " ")[[1]], " "), ""),
                      value = TRUE, invert = TRUE)
               }))))
  }

  pkgs_df <- data.frame(
    package = unlist(lapply(strsplit(all_packages,split = "_"), function(arg) arg[[1]])),
    version = unlist(lapply(strsplit(all_packages,split = "_"), function(arg) arg[[2]])),
    stringsAsFactors = FALSE
  )

  sil[["Rversion"]] <- x[idx1 + 1]
  sil[["packages"]] <- pkgs_df

  return(sil)

}

compare_si <- function(si1, si2) {
  sil1 <- si1$packages
  sil2 <- si2$packages

  sils <- merge(sil1, sil2, by = "package", all = TRUE, suffixes = c("_si1", "_si2"))

  sils$comparison <- unlist(lapply(seq_len(nrow(sils)), function(pkg) {
    v_1 <- sils$version_si1[pkg]
    v_2 <- sils$version_si2[pkg]

    if (is.na(v_1)) {
      "Only in 2"
    } else if (is.na(v_2)) {
      "Only in 1"
    } else {
      cv <- compareVersion(v_1, v_2)
      car::recode(cv, "-1='older'; 0='equal'; 1='newer'")
    }
  }))
  return(sils)
}






# all_packages <- c()
# for (f in lf) {
#   x <- readLines(paste0(Routdir, "/", f))
#   idx1 <- which(x == "> sessionInfo()")
#   idx2 <- which(x == "other attached packages:")
#   idx3 <- which(x == "loaded via a namespace (and not attached):")
#   if (length(idx1) != 0 & length(idx2) != 0 & length(idx3) != 0) {
#     all_packages <-
#       unique(c(all_packages, x[idx1 + 1],
#                do.call(c, lapply((idx2 + 1):(idx3 - 2), function(i) {
#                  grep("\\[", setdiff(setdiff(strsplit(x[i], " ")[[1]], " "), ""),
#                       value = TRUE, invert = TRUE)
#                }))))
#   }
# }
# write.table(sort(all_packages), file = outtxt,
#             row.names = FALSE, col.names = FALSE, quote = FALSE, sep = "\t")

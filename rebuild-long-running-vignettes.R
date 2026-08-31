knit_vignettes <- function() {
  old_wd <- getwd()
  do.call(on.exit, list(bquote(setwd(.(old_wd))), add = TRUE))
  setwd("vignettes-raw/")

  knitr::opts_chunk$set(error = FALSE)

  files <- c("lmm_factor", "glmm_factor", "mixed_response",
             "lmm_heteroscedastic", "semiparametric", "optimization",
             "latent_observed_interaction", "scaling", "posterior_sampling")

  for (f in files) {
    message("knitting ", f)
    knitr::knit(paste0(f, ".Rmd"),
                output = file.path("..", "vignettes", paste0(f, ".Rmd")),
                envir = new.env(parent = globalenv()))
  }

  imgs <- list.files(pattern = "\\.png$")
  ok <- file.rename(imgs, file.path("..", "vignettes", imgs))
  if (!all(ok)) stop("failed to move: ", paste(imgs[!ok], collapse = ", "))
}

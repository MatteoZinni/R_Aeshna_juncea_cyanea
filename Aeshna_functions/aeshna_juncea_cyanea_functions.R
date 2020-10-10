# Aeshna cyanea and juncea functions

# 01 range calculation
# 02 coefficient of variation
# 03 enhanced summary function
# 04 custom R function to calculate correlation test values


# 01 range calculation
range_calculation <- function(x)
{
  range <- max(x) - min(x)
  return(range)
}

# 02 coefficient of variation
coefficient_variation <- function(x) 
{
  sqrt(var(x))/mean(x, na.rm = T)
}

# 03 write an enhanced version of summary function
enhanced_summary <- function(x,...)
{
 c(min=min(x, ...),
   first_quartile = quantile(x, 0.25, na.rm = T),
   median = median(x, na.rm = T),
   mean=mean(x, ...),
   third_quartile = quantile(x, 0.75, na.rm = T),
   max=max(x,...), 
   range = (max(x,...) - min(x, ...)),
   sd=sd(x, ...),
   variance = var(x),
   coeff_var = coefficient_variation(x),
   n=as.integer(length(x)))
}

# 04 custom R function to calculate correlation test values
# mat : is a matrix of data
# ... : further arguments to pass to the native R cor.test function
corr_m_test <- function(mat, ...) 
{
   mat <- as.matrix(mat)
   n <- ncol(mat)
   p_mat<- matrix(NA, n, n)
   diag(p_mat) <- 0
   for (i in 1:(n - 1)) {
      for (j in (i + 1):n) {
         tmp <- cor.test(mat[, i], mat[, j], ...)
         p_mat[i, j] <- p_mat[j, i] <- tmp$p.value
         }
   }
   colnames(p_mat) <- rownames(p_mat) <- colnames(mat)
   p_mat
}
# KHP
South Korea's Health Panel data

## [`import_khp.r`](https://github.com/hedgepodge/korea_khp/blob/master/import_khp.r)
Fuction to import KHP data to the global environment in R.

input: directory

output: khp_in (inpatient), khp_ou (outpatient), khp_ind (individual information)

### Example. 
``` r
import_khp("~/panel")
```

-> Outputs are khp_in, khp_ou, khp_ind.

To be specific,
khp_in has 26705 observations of 11 variables, 
khp_ou has 2392339 observations of 8 variables, 
khp_in has 160840 observations of 5 variables.

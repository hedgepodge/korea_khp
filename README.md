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
khp_in has 26,705 observations of 11 variables, 
khp_ou has 2,392,339 observations of 8 variables, 
khp_in has 160,840 observations of 5 variables.


## [`import_khp.py`](https://github.com/hedgepodge/korea_khp/blob/master/import_khp.py)
`Interim` python code to import KHP data to use afterwards.
However, this code fails to read Korean characters.
I have tried four encodings; iso-8859-1, euc-kr, utf-8, cp949. Three encodings(euc-kr, utf-8, cpc949) didn't work. Only iso-8859-1 worked but couldn't read Korean character.

Also, this failed to select strings from columns containing both numeric and character values. The code below only selected strings containing H40 and H42, not 1706. Still working on this.

```python
khp_in_select = khp_in[(khp_in['IN25'].str.contains('1706|H40|H42', na=False)) |
                       (khp_in['IN26'].str.contains('1706|H40|H42', na=False)) |
                       (khp_in['IN27'].str.contains('1706|H40|H42', na=False))]
khp_ou_select = khp_ou[(khp_ou['OU3'].str.contains('1706|H40|H42', na=False)) |
                       (khp_ou['OU4'].str.contains('1706|H40|H42', na=False)) |
                       (khp_ou['OU5'].str.contains('1706|H40|H42', na=False))]
```

input: directory

output: khp_in (inpatient), khp_ou (outpatient), khp_ind (individual information)




## [`khp_preval_incid_ratio.r`](https://github.com/hedgepodge/korea_khp/blob/master/khp_preval_incid_ratio.r)
Fuction to export prevalence-incidence ratio for specific diagnosis codes.
Need to call `khp_code_list.r` function before calling this function. 

### Example. 
input:
```r
directory<-"~/panel"
diagnosis_code <-c(1110, "A41")
claim_free_period <- 2
```

output: 
```r
khp_io_summary_diagnosiscode.txt
khp_io_select_diagnosiscode.txt
Printing annual number of prevalent people, number of incident people, sum of prevalent people's weights, and sum of incident people' weights.
```


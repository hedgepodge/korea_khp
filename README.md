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

run:
```r
khp_preval_incid_ratio(directory, diagnosis_code, claim_free_period)
```
or
```r
khp_preval_incid_ratio("~/panel", c(1110, "A41"), 2)
khp_preval_incid_ratio("~/panel", c(1110, 11101, "A41"), 2)
khp_preval_incid_ratio("~/panel", c(11212, "B02"), 2)
khp_preval_incid_ratio("~/panel", c(11252, "B181, K739"), 2)
khp_preval_incid_ratio("~/panel", c(11253, "B182"), 2)
khp_preval_incid_ratio("~/panel", c(1301, 13011, "D649"), 2)
khp_preval_incid_ratio("~/panel", c(13022, "D69"), 2)
khp_preval_incid_ratio("~/panel", c(14012, "E05"), 2)
khp_preval_incid_ratio("~/panel", c(1402, 14021, "E10", "E11", "E12", "E13", "E14"), 2)
khp_preval_incid_ratio("~/panel", c(16082, "G500"), 2)
khp_preval_incid_ratio("~/panel", c(17052, "H353"), 2)
khp_preval_incid_ratio("~/panel", c(17053, "H360"), 2)
khp_preval_incid_ratio("~/panel", c(1706, 17061, "H40", "H42"), 2)
khp_preval_incid_ratio("~/panel", c(1802, 18021, "H919"), 2)
khp_preval_incid_ratio("~/panel", c(1913, 19131, "I70"), 2)
khp_preval_incid_ratio("~/panel", c(19132, "I70"), 2)
khp_preval_incid_ratio("~/panel", c(2005, 20051, "J12", "J13", "J14", "J15", "J16", "J17", "J18"), 2)
khp_preval_incid_ratio("~/panel", c(20111, "J410"), 2)
khp_preval_incid_ratio("~/panel", c(20113, "J43"), 2)
khp_preval_incid_ratio("~/panel", c(2012, 20121, "J45"), 2)
khp_preval_incid_ratio("~/panel", c(2104, 21041, "K25"), 2)
khp_preval_incid_ratio("~/panel", c(21042, "K26"), 2)
khp_preval_incid_ratio("~/panel", c(21065, "K314"), 2)
khp_preval_incid_ratio("~/panel", c(21066, "K570, K571"), 2)
khp_preval_incid_ratio("~/panel", c(21125, "D126"), 2)
khp_preval_incid_ratio("~/panel", c(21132, "K703"), 2)
khp_preval_incid_ratio("~/panel", c(21141, "K748"), 2)
khp_preval_incid_ratio("~/panel", c(2115, 21151, "K80"), 2)
khp_preval_incid_ratio("~/panel", c(21153, "K81"), 2)
khp_preval_incid_ratio("~/panel", c(22025, "L89"), 2)
khp_preval_incid_ratio("~/panel", c(22028, "L40"), 2)
khp_preval_incid_ratio("~/panel", c(23012, "M10"), 2)
khp_preval_incid_ratio("~/panel", c(23091, "M819"), 2)
khp_preval_incid_ratio("~/panel", c(2403, 24031, "N10", "N11", "N12", "N13", "N14", "N15", "N16"), 2)
khp_preval_incid_ratio("~/panel", c(2404, 24041, "N17", "N18", "N19"), 2)
khp_preval_incid_ratio("~/panel", c(2405, 24051, "N20", "N21", "N22", "N23"), 2)
khp_preval_incid_ratio("~/panel", c(2408, 24081, "N400"), 2)
khp_preval_incid_ratio("~/panel", c(55555), 2)
```

output: 
```r
khp_io_summary_diagnosiscode_claimfreeperiod.txt
khp_io_select_diagnosiscode_claimfreeperiod.txt
Printing annual number of prevalent people, number of incident people, sum of prevalent people's weights, and sum of incident people' weights.
```


import pandas as pd
import glob
import os

folder: str = "D:\\khp_version_1.5_SAS(2008~2016)"
category = ["ind", "in", "ou"]
file_list = []
khp_ind = pd.DataFrame()
khp_in = pd.DataFrame()
khp_ou = pd.DataFrame()

for item in category:
    file_list.append(glob.glob(folder + "\\t" + "[0-9]" + "[0-9]" + item + ".sas7bdat"))

for i in range(0, len(category)):
    for f in file_list[i]:
        basename = os.path.basename(f)
        (file, ext) = os.path.splitext(basename)
        year1 = file[1:3]
        year2 = pd.to_numeric('20' + year1)
        vars()[file] = pd.read_sas(f, encoding='iso-8859-1')
        # iso-8859-1, euc-kr, utf-8, cp949
        vars()[file]['year'] = year2
        if file[3:] == 'ind' and pd.to_numeric(file[1:3]) < 14:
            khp_ind = khp_ind.append(vars()[file][['PIDWON', 'I_WGC', 'C3', 'C4_0', 'year']], sort=True)
        elif file[3:] == 'ind' and pd.to_numeric(file[1:3]) >= 14:
            khp_ind = khp_ind.append(
                vars()[file][['PIDWON', 'I_WGC_TOT', 'C3', 'C4_0', 'year']].rename(columns={'I_WGC_TOT': 'I_WGC'}),
                sort=True)
        if file[3:] == 'in' and pd.to_numeric(file[1:3]) < 12:
            khp_in = khp_in.append(
                vars()[file][['PIDWON', 'IN3', 'IN4', 'IN5', 'IN6', 'IN7', 'IN8', 'IN25', 'IN26', 'IN27', 'year']],
                sort=True)
        elif file[3:] == 'in' and pd.to_numeric(file[1:3]) >= 12:
            khp_in = khp_in.append(vars()[file][['PIDWON', 'IN3', 'IN4', 'IN5', 'IN6', 'IN7', 'IN8', 'IN25_2', 'IN26_2',
                                                 'IN27_2', 'year']].rename(
                columns={'IN25_2': 'IN25', 'IN26_2': 'IN26', 'IN27_2': 'IN27'}), sort=True)
        if file[3:] == 'ou' and pd.to_numeric(file[1:3]) < 12:
            khp_ou = khp_ou.append(vars()[file][['PIDWON', 'OU6', 'OU7', 'OU8', 'OU3', 'OU4', 'OU5', 'year']],
                                   sort=True)
        elif file[3:] == 'ou' and pd.to_numeric(file[1:3]) >= 12:
            khp_ou = khp_ou.append(
                vars()[file][['PIDWON', 'OU6', 'OU7', 'OU8', 'OU3_2', 'OU4_2', 'OU5_5', 'year']].rename(
                    columns={'OU3_2': 'OU3', 'OU4_2': 'OU4', 'OU5_5': 'OU5'}), sort=True)

print(khp_ind.shape, khp_in.shape, khp_ou.shape)
print(khp_ind.dtypes, khp_in.dtypes, khp_ou.dtypes)

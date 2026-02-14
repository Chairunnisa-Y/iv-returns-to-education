/*==============================================================================
Author			: 2406461242
Last Modified	: December 5th, 2024
Assignment		: Instrumental Variable regression for the econometrics grading, refer to Purnastuti, L.(2013) and Angrist, J. D., & Krueger, A. B. (1991)
==============================================================================*/

clear all
estimates clear
set more off

log using Logfile_Econometrics_Assignment_2406461242

cd "D:\IMPORTANCE ABOUT ME !\Lanjut Sekolah\Universitas Indonesia\Semester 1\Ekonometrika\Assist_Assignment_IAD"

global ASSIGN "D:\IMPORTANCE ABOUT ME !\Lanjut Sekolah\Universitas Indonesia\Semester 1\Ekonometrika\Assist_Assignment_IAD"


/////*****INCOME*****/////
*** Since, income and tenure are in the same data file, it is possible to clean the data at the same time. Refers to its paper, it indicates that tenure needs to be square. It needs to be checked the duplication. I use the hhid14_9 as every data has the latest hhid.
use "D:\IMPORTANCE ABOUT ME !\Lanjut Sekolah\Universitas Indonesia\Semester 1\Ekonometrika\Assist_Assignment_IAD\data\b3a_tk2.dta"

gen Income = tk25a1
label variable Income "Monthly Income at The Last Job"
drop if missing(Income)

/////*****TENURE*****/////
gen Tenure = tk23a2y
label variable Tenure "Time Spent for The Primary Job in Years"
drop if missing(Tenure)

gen Tenure2 = Tenure * Tenure
label variable Tenure2 "Tenure Squared"
keep hhid14_9 pid14 Income Tenure Tenure2

duplicates report hhid14_9
duplicates drop hhid14_9, force

save assign_data, replace


/////*****SCHYRS*****/////
***Merge with b3a_dl1, keep the observations available in the both sides, delete the unnecessary observations, and well-defined the educational levels.
merge 1:m hhid14_9 using "D:\IMPORTANCE ABOUT ME !\Lanjut Sekolah\Universitas Indonesia\Semester 1\Ekonometrika\Assist_Assignment_IAD\data\b3a_dl1.dta"

keep if _merge == 3
drop _merge

drop if inlist(dl06, 17, 90, 95, 98, 99)
drop if inlist(dl07, 98, 99) | missing(dl07) & dl06!=14

gen Schyrs = 0

* 1. SD (max 6 yrs)
replace Schyrs = 6 if inlist(dl06, 2, 11, 72) & dl07 >= 6
replace Schyrs = 5 if inlist(dl06, 2, 11, 72) & dl07 == 5
replace Schyrs = 4 if inlist(dl06, 2, 11, 72) & dl07 == 4
replace Schyrs = 3 if inlist(dl06, 2, 11, 72) & dl07 == 3
replace Schyrs = 2 if inlist(dl06, 2, 11, 72) & dl07 == 2
replace Schyrs = 1 if inlist(dl06, 2, 11, 72) & dl07 == 1
replace Schyrs = 0 if inlist(dl06, 2, 11, 72) & dl07 == 0

* 2. SMP (max 3 yrs)
replace Schyrs = 9 if inlist(dl06, 3, 4, 12, 73) & dl07 >= 3
replace Schyrs = 8 if inlist(dl06, 3, 4, 12, 73) & dl07 == 2
replace Schyrs = 7 if inlist(dl06, 3, 4, 12, 73) & dl07 == 1
replace Schyrs = 6 if inlist(dl06, 3, 4, 12, 73) & dl07 == 0

* 3. SMA (max 3 yrs)
replace Schyrs = 12 if inlist(dl06, 5, 6, 14, 15, 74) & dl07 >= 3
replace Schyrs = 11 if inlist(dl06, 5, 6, 14, 15, 74) & dl07 == 2
replace Schyrs = 10 if inlist(dl06, 5, 6, 14, 15, 74) & dl07 == 1
replace Schyrs = 9 if inlist(dl06, 5, 6, 14, 15, 74) & dl07 == 0

* 4. Diploma (max 3 yrs)
replace Schyrs = 15 if dl06 == 60 & dl07 >= 3
replace Schyrs = 14 if dl06 == 60 & dl07 == 2
replace Schyrs = 13 if dl06 == 60 & dl07 == 1
replace Schyrs = 12 if dl06 == 60 & dl07 == 0

* 5. S1 or Open University (max 4 yrs)
replace Schyrs = 16 if inlist(dl06, 13, 61) & dl07 >= 4
replace Schyrs = 15 if inlist(dl06, 13, 61) & dl07 == 3
replace Schyrs = 14 if inlist(dl06, 13, 61) & dl07 == 2
replace Schyrs = 13 if inlist(dl06, 13, 61) & dl07 == 1
replace Schyrs = 12 if inlist(dl06, 13, 61) & dl07 == 0

* 6. S2 (max 2 yrs)
replace Schyrs = 18 if dl06 == 62 & dl07 >= 2
replace Schyrs = 17 if dl06 == 62 & dl07 == 1

* 7. S3 (max 5 yrs)
replace Schyrs = 23 if dl06 == 63 & dl07 >= 5
replace Schyrs = 22 if dl06 == 63 & dl07 == 4
replace Schyrs = 21 if dl06 == 63 & dl07 == 3
replace Schyrs = 20 if dl06 == 63 & dl07 == 2
replace Schyrs = 19 if dl06 == 63 & dl07 == 1
replace Schyrs = 18 if dl06 == 63 & dl07 == 0


label variable Schyrs "Years of Schooling"
keep hhid14_9 pid14 pidlink Income Tenure Tenure2 Schyrs
duplicates report hhid14_9 pid14
duplicates drop hhid14_9 pid14, force

save assign_data, replace

/////*****AGE*****/////
***Since age, month of birth and gender are in the same dataset, it can be merged directly with bk_ar1. Drop the observations that didn't answer or unknown.
merge 1:m hhid14_9 using "D:\IMPORTANCE ABOUT ME !\Lanjut Sekolah\Universitas Indonesia\Semester 1\Ekonometrika\Assist_Assignment_IAD\data\bk_ar1.dta"

keep if _merge == 3
drop _merge

gen Age = ar09
label variable Age "Individual Age in Years"
drop if Age == 0 | Age == 998

gen Age2 = Age * Age
label variable Age2 "Age Squared"

/////*****GENDER, specifically for female*****/////
gen Female = (ar07 == 3)
label variable Female "Gender (1=Female, 0=Male)"


/////*****BIRTH-MONTH*****/////
gen BirthMonth = ar08mth
label variable BirthMonth "Month of Birth"
drop if BirthMonth == 98

keep hhid14_9 pid14 pidlink Income Tenure Tenure2 Schyrs Female Age Age2 BirthMonth


/////*****URBAN*****/////
merge m:1 hhid14_9 using "D:\IMPORTANCE ABOUT ME !\Lanjut Sekolah\Universitas Indonesia\Semester 1\Ekonometrika\Assist_Assignment_IAD\data\bk_sc1.dta"

keep if _merge == 3
drop _merge

drop if missing(sc05)
gen Urban = sc05
replace Urban = 0 if sc05 == 1
replace Urban = 1 if sc05 == 2

label define Urban 1 "Urban" 0 "Non-Urban"
label values Urban Urban
label variable Urban "Urban or Rural"

keep hhid14_9 pid14 pidlink Income Tenure Tenure2 Schyrs Female Age Age2 BirthMonth Urban

duplicates report hhid14_9
duplicates drop hhid14_9, force

save assign_data, replace


/////*****REGRESSION*****/////
***It can be easily compared when putting these two results on the same table together. 
reg Income Schyrs Age Age2 Tenure Tenure2 Urban Female
eststo ols
ivregress 2sls Income (Schyrs = BirthMonth) Age Age2 Tenure Tenure2 Urban Female
eststo IV
esttab ols IV using "Result.doc", b(4) se(4) mtitle("OLS" "IV") r2 title("Table 1. Regression Results")

log close
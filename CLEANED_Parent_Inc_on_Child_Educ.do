use "C:\Users\garfi\OneDrive\Desktop\ECO240 Stata F24\cps_00003.dta", clear 
keep if year > 2008

```BASIC CLEANING'''

// 1 means they're female bc mothers educ and income lvl effects child's education level the most according to research
gen female=.
replace female = 1 if sex_mom == 2
replace female = 0 if sex_pop == 1

// age
replace age=. if age<0
gen agesq=age*age

// 1 means parent is white 
// 0 means parent is black (200) or am. indian (300) or asian/pi (650)
gen white=.
replace white=1 if race_mom == 100 | race_pop == 100
replace white=0 if race_mom == 200 | race_mom == 300 | race_mom == 650 
replace white=0 if race_pop == 200 | race_pop == 300 | race_pop == 650


// employed rn is only armed forces.. trying to fix that rn 

// mom employment status 
// 1 means employed 
// 0 means unemployed 
replace empstat_mom=. if empstat_mom == 0 | empstat_mom >= 30
replace empstat_mom = 1 if empstat_mom == 1 | empstat_mom == 10 | empstat_mom == 12
replace empstat_mom = 0 if empstat_mom == 20 | empstat_mom == 21 | empstat_mom == 22

// dad employment status 
// 1 means employed
// 0 means unemployed 
replace empstat_pop=. if empstat_pop == 0 | empstat_pop >= 30
replace empstat_pop = 1 if empstat_pop == 1 | empstat_pop == 10 | empstat_pop == 12
replace empstat_pop = 0 if empstat_pop == 20 | empstat_pop == 21 | empstat_pop == 22

// parent employed 
gen employed=. 
replace employed = 1 if empstat_mom == 1 | empstat_pop == 1
replace employed = 0 if empstat_mom == 0 | empstat_pop == 0

// mom marital status 
replace marst_mom=. if marst_mom == 9 
replace marst_mom = 1 if marst_mom == 1 | marst_mom == 2
replace marst_mom = 0 if marst_mom >= 3 

// dad marital status 
replace marst_pop=. if marst_pop == 9
replace marst_pop = 1 if marst_pop == 1 | marst_pop == 2 
replace marst_pop = 0 if marst_pop >= 3

// parent married
gen married=. 
replace married = 1 if marst_mom == 1 | marst_pop == 1 
replace married = 0 if marst_pop == 0 | marst_pop == 0

// educ(ation)
// 1 means less than hs education 
// 2 means hs diploma or ged 
// 3 means associates degree
// 4 means bachelors degree
// 5 means masters degree 
// 6 means professional school degree 
// 7 means doctorate degree 
replace educ=. if educ <= 002 | educ > 998
replace educ = 1 if educ == 030
replace educ = 2 if educ == 073
replace educ = 3 if educ == 091
replace educ = 4 if educ == 111
replace educ = 5 if educ == 123
replace educ = 6 if educ == 124 
replace educ = 7 if educ == 125

// 1 means they're past the age of required schooling and \ enter the age of optional higher education
// 0 means they're past the normal age range of higher educ schooling \ (past masters)
gen student_aged =. 
replace student_aged = 1 if age > 18 & age <= 26 
replace student_aged = 0 if age > 26

// 1 if first parent is biological, step, or adopted parent
// 0 if no first parent 
replace pepar1typ = 1 if pepar1typ == 1 | pepar1typ == 2 | pepar1typ == 3
replace pepar1typ = 0 if pepar1typ == 0

// 1 if second parent is biological, step, or adopted parent 
// 0 if no second parent 
replace pepar2typ = 1 if pepar2typ == 1 | pepar2typ == 2 | pepar2typ == 3
replace pepar2typ = 0 if pepar2typ == 0

// is a child with at least 1 parent 
gen is_child=.
replace is_child = 1 if pepar1typ == 1 | pepar2typ == 1
replace is_child = 0 if pepar1typ == 0 & pepar2typ == 0

// child education 
gen child_educ=.
replace child_educ = 1 if student_aged == 1 & educ >= 3
replace child_educ = 0 if student_aged == 1 & educ <= 2

// inctot_mom income 
replace inctot_mom = 30000 if inctot_mom > 0 & inctot_mom <= 30000
replace inctot_mom = 50000 if inctot_mom > 30000 & inctot_mom <= 50000
replace inctot_mom = 100000 if inctot_mom > 50000 & inctot_mom <= 100000
replace inctot_mom = 150000 if inctot_mom > 100000 & inctot_mom <= 150000
replace inctot_mom = 200000 if inctot_mom > 150000 & inctot_mom <= 200000
replace inctot_mom = 250000 if inctot_mom > 200000 & inctot_mom <= 250000
replace inctot_mom = 300000 if inctot_mom > 250000 & inctot_mom <= 300000
replace inctot_mom = 350000 if inctot_mom > 300000 & inctot_mom <= 350000
replace inctot_mom = 400000 if inctot_mom > 350000 & inctot_mom <= 400000
replace inctot_mom = 450000 if inctot_mom > 400000 & inctot_mom <= 450000
replace inctot_mom = 500000 if inctot_mom > 450000 & inctot_mom <= 500000
replace inctot_mom = 1000000 if inctot_mom > 500000

//inctot_pop
replace inctot_pop = 30000 if inctot_pop > 0 & inctot_pop <= 30000
replace inctot_pop = 50000 if inctot_pop > 30000 & inctot_pop <= 50000
replace inctot_pop = 100000 if inctot_pop > 50000 & inctot_pop <= 100000
replace inctot_pop = 150000 if inctot_pop > 100000 & inctot_pop <= 150000
replace inctot_pop = 200000 if inctot_pop > 150000 & inctot_pop <= 200000
replace inctot_pop = 250000 if inctot_pop > 200000 & inctot_pop <= 250000
replace inctot_pop = 300000 if inctot_pop > 250000 & inctot_pop <= 300000
replace inctot_pop = 350000 if inctot_pop > 300000 & inctot_pop <= 350000
replace inctot_pop = 400000 if inctot_pop > 350000 & inctot_pop <= 400000
replace inctot_pop = 450000 if inctot_pop > 400000 & inctot_pop <= 450000
replace inctot_pop = 500000 if inctot_pop > 450000 & inctot_pop <= 500000
replace inctot_pop = 1000000 if inctot_pop > 500000

// total personal income of parents 
replace inctot_mom =. if inctot_mom < 0
replace inctot_pop =. if inctot_pop < 0

// percent change of incoem 
gen lnincome_mom=.
replace lnincome_mom = ln(inctot_mom)
gen lnincome_pop=. 
replace lnincome_pop = ln(inctot_pop)

replace lnincome = lnincome_mom + lnincome_pop

// regressions HOMEWORK 6
reg child_educ lnincome, level(99)
outreg2 using basicreg.doc, replace ctitle ("Model 1")
reg child_educ lnincome female white age agesq, level(99) // the best
outreg2 using basicreg.doc, replace ctitle("Model 2")
reg child_educ lnincome female white age agesq married employed, level(99)
outreg2 using basicreg.doc, replace ctitle("Model 3")


// dtable 
summarize child_educ lnincome female white age agesq married employed 

dtable lnincome female white age agesq married employed, by(child_educ) title("Table 1. Statistics by Parental Income") export("dtableECO_hw6.xlsx")















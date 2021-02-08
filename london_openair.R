# London Air Quality Data
# Enders Analysis: February 7, 2021 [10:24AM]

# install necessary packages
install.packages("devtools")
require(devtools)
#install_github('davidcarslaw/openair', dependencies = TRUE)
install.packages("openair")
install.packages("tidyverse")
library(openair)
library(tidyverse)

# openair book
#https://bookdown.org/david_carslaw/openair/sec-importAURN.html

# get meta data for KCL network (data from sites operated by King's College London, pirmarily including "The London Air Quality Network")
kcl_meta <- importMeta(source = "kcl")

# create list of hand-collected codes for GLA
gla_codes <- c('BG1', 'BG2', 'BX2', 'BX0', 'BQ7', 'BQ8', 'BX1', 'BQ9', 'BT8', 'BT4', 'BT6', 'BT5', 'BY7', 'BL0', 'IM1', 
               'CD1', 'CT4', 'CT2', 'CT3', 'CT8', 'CT6', 'CR5', 'CR8', 'CR9', 'CR7', 'ZR4', 'ZR2', 'EI3', 'EA6', 'EA8', 'EI8', 'EI1', 'EN5',
               'EN1', 'EN4', 'EN7', 'GN0', 'GR7', 'GR4', 'GB6', 'GB0', 'GN4', 'GN6', 'GN3', 'GN5', 'GR9', 'GR8', 'HK6', 'HG4', 'HG1', 'HR2', 
               'HR1', 'HV1', 'HV3', 'LH0', 'HI0', 'IS6', 'IS2', 'MW1', 'MW2',' MW4', 'NB1', 'WMB', 'WM6', 'MY7', 'MY1', 'WM0', 'WMD', 'GV1', 
               'GV2', 'WM5', 'WMC', 'WA2', 'WAB', 'WA8', 'WA7', 'WA9', 'WAC', 'WAA', 'TH2', 'TH4', 'TK3', 'TK8', 'TK1', 'TK9', 'ST6', 'ST4', 
               'ST9', 'ST5', 'SKB', 'SK8', 'SKA', 'SK6', 'SK9', 'SK5', 'ZV1', 'ZV2', 'RI1', 'RI2', 'RG8', 'RG3', 'RG6', 'RG1', 'RG7', 'RB7',
               'RB4', 'RD0', 'ME9', 'ME2', 'ME6', 'ME5', 'TD5', 'LW2', 'LW4', 'HP1', 'LW5', 'LW1', 'LB6', 'LB4', 'LB5', 'KT4', 'KT6', 'KT5', 
               'KF1', 'KC1')

# make datafram kcl which is kcl_meta with only gla_codes (i.e. drop all other codes that are not of intereted from kcl_meta)
kcl <- filter(kcl_meta, code%in% gla_codes)

# export kcl as csv
write.csv(kcl, 'data/gla_codes.csv')


# ----- CONNECTING TO API - CODES DO NOT WORK FOR WHATEVER REASON - WEB SCRAPING METHOD IN PYTHON BEING USSED INSTEAD -----

# put all unique values from kcl column "code" into a vector
kcl_code <- kcl[, 2]
codes <- unique(kcl_code[c("code")])
list_codes <- list(codes['code'])
vector_codes <- unlist(list_codes)
# check for vector conversion
vector_codes[1]

# read in data for all of Greater London Area 2021
data_2020_2021 <- importAURN(site = vector_codes, year = c(2019, 2020, 2021), meta = TRUE, to_narrow = TRUE)

# write data_2020_2021 to csv
write.csv(data_2020_2021, 'data/TEST.csv') #change 'TEST' to something meaninful later


# -----  -----  -----  -----  -----  ----- #

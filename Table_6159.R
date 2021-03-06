source("C:\\MY_FOLDERS\\Asthma_and_Pain\\R_code\\Table_creation\\Set_of_functions.R")

############################## INPUTS FOR PAIN SITES ######################################################

filepath6159_in <- "write the path of your input file"

# you can change the lables that follow, but preservet their order: 
list_of_labels <- c('Prf_no_Ansr', 'Non_Abve', 'All_over', 
                    'Neck_Shldr_pn', 'Hip_pn', 'Back_pn', 'Stom_Abdmn_pn', 'Knee_pn', 'Headch', 'Face_pn')

##########################################################################################################

############################## INPUTS FOR PAIN DURATION ##################################################
# you can change the lables that follow, but preservet their order: 
labels <- c('All_over_3+m', 'Neck_Shldr_pn_3+m', 
            'Hip_pn_3+m', 'Back_pn_3+m', 'Stom_Abdmn_pn_3+m', 
            'Knee_pn_3+m', 'Headch_3+m', 'Face_pn_3+m')

filepath6159_out <- "write the path of your output file"
##########################################################################################################


############################## NOT TO BE CHANGED ##########################################################
n_visits <- 3 # The number of visits can change to 4 when the fourth visit becomes available and is inculded in the UKB table
list_of_sites <- c(-3, -7, 8, 3, 6, 4, 5, 7, 1, 2) # Do not change. 
l_array <- 7  # there are 7 fields for pain siates per visit
start_pos <- 2 # the columns with codes for pain sites start with column 2 and end with column 2+3*7-1 = 22 

#The order of the conditions and the lables is based on the order of the fields from the file First_from_UKB.R
#They were:
#list_of_codes <- c("f.6159.", "f.2956.", "f.3404.", "f.3414.", "f.3571.", "f.3741.", "f.3773.", "f.3799.", "f.4067.")
###########################################################################################################

############################## NOT TO BE CHANGED ##########################################################
#fields <- c("f.3799.", "f.4067.", "f.3404.",  "f.3571.", "f.3741.", "f.3414.",  "f.3773.", "f.2956.")
fields <- c("f.2956.", "f.3404.", "f.3414.", "f.3571.", "f.3741.", "f.3773.", "f.3799.", "f.4067.")
arrays_length <- c(1, 1, 1, 1, 1, 1, 1, 1)
instances   <-   3 * arrays_length
##########################################################################################################


############################## EXECUTE ###################################################################

t6159 <- fread(filepath6159_in)

t_pain <- build_bin_6159(t6159, list_of_sites, list_of_labels, n_visits, l_array, start_pos)

t_pain_duration <- build_duration(t6159, fields, instances, labels, n_visits, l_array, start_pos)

t_pain_duration <- left_join(t_pain, t_pain_duration, by='f.eid')

names(t_pain)[1] <- 'ID'
names(t_pain_duration)[1] <- 'ID'

#write.table(t_pain, "write the path of your output file", append = FALSE, sep = "\t", quote = FALSE, col.names=TRUE, row.names=FALSE)
#write.table(t_duration, "write the path of your output file", append = FALSE, sep = "\t", quote = FALSE, col.names=TRUE, row.names=FALSE)
write.table(t_pain_duration, 
            filepath6159_out,
            append = FALSE, sep = "\t", quote = FALSE, col.names=TRUE, row.names=FALSE)


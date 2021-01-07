# Code Book

The code contained in 'run_analysis.R' works as explained below and uses the data present in the folder 'UCI HAR Dataset'.

First, we start with a clean up of the current environment and loading the necessary libraries: "matrixStats", "plyr" and "dplyr". Following this, we proceed to load (using read.table), the .txt files of interest for the train and test sets:

- 'subject_train(test).txt', which contains the ID of the volunteer who performed each experiment,
- 'y_train(test).txt', which contains the label of the activity (correspondance between numerical labels and activity is given in 'activity_labels.txt' in the 'UCI HAR Dataset'folder),
- 'X_train(test).txt', which contains the variables measured for each experiment.

The test set contains the information of 561 variables about a total of 2,947 individual experiments. The train set contains the information of the same 561 variables about a total of 7,352 individual experiments.

To identify what are the observables corresponding to each of this 561 variables, we load the files 'features.txt'. The features' names is contained in the second column of this dataframe.

As requested by the instructions, we select the variables corresponding to the mean and standard deviation of observables. To do so, we use the grep function as well as a regular expression to locate the presence of "mean" or "std" in the features' names.
After selection, we also "clean" the names of the variables by removing the '()' using gsub and using various other substitutions to make them clearer to understand, and we can slice the test and train dataframes selecting the columns corresponding to the selected features.
The list and names of the 79 selected features is given in the file 'selected_features.txt'.

Once this step is done, we bind the train and test sets to obtain 2 full data sets, with the subject ID, activity ID and the selected features, and we then join both datasets to obtain one full dataset.

We rename the columns so the variables have relevant names, and rearrange the final dataset by ascending subject ID. Finally, we convert the activity ID into a factor, and rename the levels from numeric to text using the correspondance given in 'activity_labels.txt'. What we obtain is a tidy dataset (data_full) containing the information about 81 variables (subject ID, activity ID and the 79 selected features) about a total of 10,299 individual experiments.

To go further, we use the function group_by to create groups in the dataframe based on the subject ID and activity ID. We use then summarise_all to obtain the mean of each variable for each pair of subject and activity present in the dataframe. In the end, we obtain a tidier dataset (data_sum), containing 81 variables for 180 unique pairs of subject ID and activity ID. 






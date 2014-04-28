
specdata <- "C:/Users/andersonhaynes/Documents/specdata" 
specfiles <- list.files(specdata) 
specfiles <- specfiles[grep("[.]csv", specfiles)] 
data_names <- gsub("[.]csv", "", specfiles) 
for(i in 1:length(specfiles)) assign(data_names[i], read.csv(file.path(specdata, specfiles[i]))) 

# Script modified to work with all processors
# Script author: Jesse Bash
# Affiliation: US EPA Office of Research and Development
# This script assumes that the log files are located in ./CCTM/scripts as output by the CMAQ run script 
# These are the single output files, not the CTM_LOG files found in the $OUTDIR/LOGS directory
# Simulation parameters

library(RColorBrewer)
library(stringr)
#sens.dir  <- '/shared/cyclecloud-cmaq/run_scripts/HB120v3_singleVM/'
sens.dir  <- '/shared/cyclecloud-cmaq/run_scripts/HB120v3_12US1_CMAQv54plus/'
base.dir  <- '/shared/cyclecloud-cmaq/run_scripts/HB120v3_12US1_CMAQv54plus/'
#files   <- dir(sens.dir, pattern ='run_cctm5.4plus_Bench_2018_12US1_cb6r5_ae6_20200131_MYR.192.8x12pe.2days.beeond.1x96.log')
files   <- dir(sens.dir, pattern ='run_cctm5.4plus_Bench_2018_12US1_cb6r5_ae6_20200131_MYR.176.16x11pe.2day.1x176.shared.log')
#files   <- dir(sens.dir, pattern ='run_cctm5.4plus_Bench_2018_12US1_cb6r5_ae6_20200131_MYR.96.8x12pe.2days.shared.1x96.log')
#b.files <- dir(base.dir,pattern='run_cctmv5.3.3_Bench_2016_12US2.96.12x8pe.2day.cyclecloud.shared.codemod.nopin.redo.log')
b.files <- c( 'run_cctm5.4plus_Bench_2018_12US1_cb6r5_ae6_20200131_MYR.352.16x22pe.2day.2x176.shared.log', 'run_cctm5.4plus_Bench_2018_12US1_cb6r5_ae6_20200131_MYR.1x176.16x11pe.2day.beeond.log', 'run_cctm5.4plus_Bench_2018_12US1_cb6r5_ae6_20200131_MYR.2x176.16x22pe.2day.beeond.log', 'run_cctm5.4plus_Bench_2018_12US1_cb6r5_ae6_20200131_MYR.1x176.16x10pe.2day.beeond.log', 'run_cctm5.4plus_Bench_2018_12US1_cb6r5_ae6_20200131_MYR.2x176.16x20pe.2day.beeond.log', 'run_cctm5.4plus_Bench_2018_12US1_cb6r5_ae6_20200131_MYR.3x160.20x24pe.2day.beeond.log')
#Compilers <- c('intel','gcc','pgi')
Compilers <- c('gcc')
# name of the base case timing. I am using the current master branch from the CMAQ_Dev repository.
# The project directory name is used for the sensitivity case.
#base.name <- c('data_pin','lustre_pin','shared_pin')
base.name <- c( 's_352', 'b_176', 'b_352' ,'b_160', 'b_320', 'b_480')
sens.name <- c('s_176')





# ------------- Do not change below unless modifying for a different workflow ---------------------
# compilers being considered
#Compilers <- c('intel','gcc','pgi')
#Compilers <- c('intel')
# parse directory and file information
#sens.name <- strsplit(files,'/')
#n.lev     <- length(sens.name[[1]])
#sens.name <- sens.name[[1]][n.lev]
all.names <- NULL
for(i in 1:length(files)){
   all.names <- append(all.names,sens.name)
}
files <- paste(sens.dir,files,sep="")
for(i in 1:length(files)){
   all.names <- append(all.names,base.name)
}
files <- append(files,paste(base.dir,b.files,sep=''))
for( comp in Compilers) {
   bar.data <- NULL
   b.names <- NULL
   for(i in 1:length(files)){
# ignore debug simulations and get compiler information
#      if(i%in%grep('debug',files)==F & i%in%grep(comp,files)){
         file <- files[i]
         b.names <- append(b.names,paste(all.names[i]))
         data.in  <- scan(file,what='character',sep='\n')
# get timing info
         #Timing <-  as.numeric(substr(data.in[grep('completed...',data.in)],36,42))
	 Timing <-  as.numeric(substr(data.in[grep('completed...',data.in)],42,48))

        # master_timing <- as.numeric(substr(data.in[grep('Processing completed...',data.in)],36,42))
        # dataout_timing <- as.numeric(substr(data.in[grep('Data Output completed...',data.in)],36,45))
	 dataout_timing <- as.numeric(substr(data.in[grep('Data Output completed...',data.in)],42,48))
         Process <- substr(data.in[grep('completed...',data.in)],12,22)
        # Timing_sum <-sum(master_timing)
        #dataio_sum <-sum(dataout_timing)
         
         Timing_direct <-  as.numeric(substr(data.in[grep('Total Time =',data.in)],18,26))
        # Timing_missing <- Timing_direct - Timing_sum 
         
         n.proc <- unique(Process)
         n.proc <- n.proc[grep('Proc',n.proc,invert=T)]
 

	       # Aggregate data
         tmp.data <- NULL
         for(i in n.proc){
           valid <- which(i==Process)
           tmp.data <- append(tmp.data,sum(Timing[valid]))
         }
         Timing_sum <- sum(tmp.data)
         Timing_missing <- Timing_direct - Timing_sum
          
         tmp.data <- append(tmp.data,Timing_missing)
         bar.data <- cbind(bar.data,tmp.data)
   #   }
   }

   n.proc.plot <- append(n.proc, "OTHER")
   
   #remove all leading whitespace
   n.proc.plot <- str_trim(n.proc.plot, "left")

      # write csv
   write.csv(bar.data, "/shared/cyclecloud-cmaq/qa_scripts/beeond_shared.csv")
   write.csv(n.proc.plot, "/shared/cyclecloud-cmaq/qa_scripts/beeond_shared_proc.csv")
   write.csv(b.names, "/shared/cyclecloud-cmaq/qa_scripts/beeond_shared_names.csv")
   
   
   
   # plot data
   my.colors <- brewer.pal(12, "Paired")
   #my.colors <- terrain.colors(length(n.proc))
   xmax <- dim(bar.data)[2]*1.5
   png(file = paste('hb176_12US1_CMAQv54+shared_beeond',comp,'.png',sep=''), width = 1024, height = 768, bg='white')
  # png(file = paste(comp,'_',sens.name,'.png',sep=''), width = 1024, height = 768, bg='white')
   barplot(bar.data, main = 'Process Timing CMAQv54+ 2018_12US1 on HB176v4',names.arg = b.names,ylab='seconds', col = my.colors, legend = n.proc.plot, xlim = c(0.,xmax),ylim = c(0.,8000.))
   box()
   dev.off()
 
  totals <- apply(bar.data,c(2),sum)
# print total runtime data to the screen
   for(i in 1:length(b.names)){
     print(paste('Run time for', b.names[i], ':',totals[i],'seconds'))
   }
}

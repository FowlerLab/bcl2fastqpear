# bcl2fastqpear
scripts and instructions for demultiplexing Illumina runs on the GS cluster

# Moving the directory
The entire Illumina directory should be scp'd into a folder in your home directory. In my case, I navigate to the output directory (as of 20250903 we are still using /net/fields/vol2/fieldslab-inst/nextseq/Output) and use: 

scp -r name_of_illumina_directory_in_output_folder nexus.gs.washington.edu:/net/fowler/vol1/home/username/bcl2fastq/subdirectory 

Where name_of_illumina_directory_in_output_folder is the folder with all of the data from the Illumina run, subdirectory is the directory into which you are copying the Illumina directory, and username is your cluster username. You will be prompted to give your password and two-factor authenticate for the copying.

# Setting up the folder

Copy qsub_bcl2fastqpear.sh, run_bcl2fastq_pear.sh, and your sample sheet into the subdirectory mentioned above (the parent of the Illumina directory). The sample sheet should be set-up exactly like the example given here. It must start with "samplesheet" and there must be no special characters other than underscores and no spaces within cells. It also must have the header "[Data],,,,,,,," where each, is for one of the empty column heads below. 

# Giving permission to the bash scripts

You need to give the bash scripts permission to run: 

chmod +x qsub_bcl2fastqpear.sh
chmod +x run_bcl2fastq_pear.sh

# Running the scripts

Run with 

bash qsub_bcl2fastqpear.sh


# Optional step after running

I like to move all of the assembled files into one directory to make it easier for sharing and analysis. I've included xtract.sh for moving those files to another directory

Give it permission first:

chmod +x xtract.sh

Then run:

bash xtract.sh pear_output "*.assembled*" destination_directory

Where destination_directory is where you want to move the files. You can also use pear_output/subdirectory to select individual projects from the sample sheet and move them independently. 

# Monitor the ongoing job with:

qstat -u username 

Where username is your GS cluster username. This will give you a table of ongoing jobs you are running. You will see a QLOGIN job which is your interactive session and if your queued submission is working you should see run_qsub_b... with "state" r (meaning running). If that qsub is missing and you just see your QLOGIN, your run failed and you need to move to troubleshooting (almost always a sample sheet issue). 

# Troubleshooting

Your home directory should have a pair of files containing the readout of the qsub run. You need to open them and see what they are telling you about what went wrong. Alternatively, you can open your sample sheet and compare it to the example sample sheet and make sure there are no mistakes. If you find a mistake, try running it again. This will solve most problems, if you are still having problems, come find me (Dan) and I will try to help.

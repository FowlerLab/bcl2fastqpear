#$ -S /bin/bash

module load bcl2fastq/2.20
module load pear/0.9.11

rundirectory="$1"
samplesheet="$2"

cd ${rundirectory}
cd ..

mkdir ./bcl2fastq_output/

bcl2fastq -R ${rundirectory} -o ./bcl2fastq_output/ --sample-sheet ./${samplesheet} --no-lane-splitting -p 6 -r 1 -w 1 --minimum-trimmed-read-length 10 --mask-short-adapter-reads 10

mkdir ./pear_output/

ls -d ./bcl2fastq_output/*/ | tr '\n' '\0' | xargs -0 -n 1 basename | grep -v -E 'Reports|Stats' | while read FOLDER; do
  echo "$FOLDER"
  mkdir ./pear_output/${FOLDER}

  ls -1 ./bcl2fastq_output/${FOLDER}/*_R1_001.fastq.gz | tr '\n' '\0' | xargs -0 -n 1 basename | sed 's/_R1_001.fastq.gz//' | while read SAMPLE; do
    echo "$SAMPLE"
    mkdir ./pear_output/${FOLDER}/${SAMPLE}
    pear -f ./bcl2fastq_output/${FOLDER}/${SAMPLE}_R1_001.fastq.gz -r ./bcl2fastq_output/${FOLDER}/${SAMPLE}_R2_001.fastq.gz -o ./pear_output/${FOLDER}/${SAMPLE}/${SAMPLE} -q 30 -j 8 -n 10

  done

done

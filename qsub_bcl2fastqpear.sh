#!/bin/bash

CURRENTDIR=$(pwd)
SEQDIR=$(find -type d -exec sh -c '[ -f "$0"/RTAComplete.txt ] && [ -f "$0"/CopyComplete.txt ]' '{}' \; -print)
SAMPLESHEET=$(ls -1 | grep 'sample')
(echo "#!/bin/bash"
echo "cd ${CURRENTDIR}"
echo "./run_bcl2fastq_pear.sh ${SEQDIR} ${SAMPLESHEET}") > run_qsub_bcl2fastq_pear.sh

chmod u+x ./run_qsub_bcl2fastq_pear.sh
qsub -l mfree=8G -pe serial 8 $(pwd)/run_qsub_bcl2fastq_pear.sh

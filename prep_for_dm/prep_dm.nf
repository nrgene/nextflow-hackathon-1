
conf_json = file(params.conf)

process make_directories {
echo true
input:
file conf_json

output:
file reads_directory_file into download_data_ch

script:
file reads_directory_file = "reads_directory_file.txt"

"""
python /mnt/software/GIT_tammy/nextflow-hackathon-1/Prep_for_DM/make_directories.py ${conf_json} > ${reads_directory_file}
cat ${reads_directory_file}
"""
}

process download_data {
echo true
input:
file reads_directory from download_data_ch

"""
awk '{print "aws s3 sync "\$1" "\$2}' $reads_directory > CMDS.sh
bash CMDS.sh
"""
}
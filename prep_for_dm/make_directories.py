
import re
import os
import json
import argparse

# Parse command line args:
parser = argparse.ArgumentParser(
    description='bla')
parser.add_argument('input_conf', help='input_conf')

args = parser.parse_args()

with open(args.input_conf, 'r') as f:
    datastore = json.load(f)

# #make reads directory
reads_directory=datastore["storage"]+"/"+datastore["project_id"]+"/Reads/"
system_cmd="mkdir -p "+ reads_directory
print(datastore["reads_directory"]+"\t"+reads_directory)
os.system(system_cmd)
system_cmd="chmod +w "+reads_directory
os.system(system_cmd)

#make RPP run directory
rpp_directory=datastore["storage"]+"/"+datastore["project_id"]+"/prod/readsPreProcessing_pipeline/"+datastore["organism"]+"/"+datastore["variety"]+"/"+datastore["software_version"]+"_P"+datastore["parameters_version"]+"/"
#moshe = f'nemalaholehet{datastore["storage"]}-bla'
#print(moshe)

system_cmd="mkdir -p " + rpp_directory
#print(system_cmd)
os.system(system_cmd)
system_cmd="chmod +w "+rpp_directory
os.system(system_cmd)

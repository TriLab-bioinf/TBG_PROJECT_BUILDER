#!/usr/bin/env bash
# This script is used to build the project directory structure for the project.

set -o errexit

Help()
{
   # Display Help
   echo "${0} builds the project directory structure following TBG's SOP specifications."
   echo
   echo "Syntax: ${0} -P PI's First_Last name -t TICKET number [-R|-p|-s|-h]"
   echo; echo "options:"; echo
   echo "-P = PI_First_Last name (e.g. Joe_Doe - required - )"
   echo "-t = TICKET number (e.g. TK_123 - required - )"
   echo "-R = Include R directories"
   echo "-p = Include Python directories"
   echo "-s = Include Snakemake directories"
   echo "-h = Prints this help."
   echo
}

# Deals with NULL entry
if [[ -z $1 ]]; then
    Help
    exit 1  
fi    

# Process options
while getopts "hP:t:Rps" option; do
   case $option in
        h) # display Help
                Help
                exit;;
        P) PI=${OPTARG};;
        t) TICKET=${OPTARG};;
        R) INCLUDE_R=true;;
        p) INCLUDE_PYTHON=true;;
        s) INCLUDE_SNAKEMAKE=true;;
       \?) # incorrect option
           echo "Error, Invalid option"
           echo
             Help
           exit 1
           ;;
       :) echo "option -$OPTARG requires an argument." 
            Help
         exit 1
         ;;   
   esac
done

# Main script

# Check PI format allowing for PI names in upper or lower case
if [[ ! $PI =~ ^[a-zA-Z]+_[a-zA-Z]+$ ]]; then 
    echo "Error: PI name is not in the correct format (First_Last)" >&2
    Help
    exit 1
fi

# Check TICKET format allowing for TK prefixes in upper or lower case
if [[ ! $TICKET =~ ^[tkTK]+_[0-9]+$  ]]; then
    echo "Error: TICKET number is not in the correct format (TK_123)" >&2
    Help
    exit 1
fi

PI=${PI^^} # enforce upper case format
TICKET=${TICKET^^} # enforce upper case format

# Define the project directory structure
PROJECT_DIR=/data/${USER}/${PI}/${TICKET}
RAW_DIR="$PROJECT_DIR/data_raw"
DATA="$PROJECT_DIR/data"
CONFIG="$PROJECT_DIR/config"
LOGS="$PROJECT_DIR/logs"
SCRIPTS="$PROJECT_DIR/scripts"
RESULTS="$PROJECT_DIR/results"
DOCUMENTS="$PROJECT_DIR/documents"
# For R projects
R=$PROJECT_DIR/R
R_DATA="$R/data"
R_SCRIPTS="$R/scripts"
R_RESULTS="$R/results"
R_RDSFILES="$R/results/rds_files"
R_TABLES="$R/results/tables"
R_PLOTS="$R/results/plots"
# For Python projects
PYTHON=$PROJECT_DIR/python
PYTHON_DATA="$PYTHON/data"
PYTHON_SCRIPTS="$PYTHON/scripts"
PYTHON_RESULTS="$PYTHON/results"
PYTHON_TABLES="$PYTHON/results/tables"
PYTHON_PLOTS="$PYTHON/results/plots"
# For snakemake projects
SNAKEMAKE=$PROJECT_DIR/snakemake
SNAKEMAKE_DATA="$SNAKEMAKE/data"
SNAKEMAKE_SCRIPTS="$SNAKEMAKE/scripts"
SNAKEMAKE_CONFIG="$SNAKEMAKE/config"
SNAKEMAKE_BENCHMARK="$SNAKEMAKE/benchmark"
SNAKEMAKE_WORKFLOW_RULES="$SNAKEMAKE/workflow/rules"
SNAKEMAKE_WORKFLOW_SCRIPTS="$SNAKEMAKE/workflow/scripts"

# Create the project directory structure
mkdir -p $RAW_DIR $DATA $CONFIG $LOGS $SCRIPTS $RESULTS
echo "# ${PI} - ${TICKET} Project" > $PROJECT_DIR/README.md
if [[ $INCLUDE_R ]]; then
    mkdir -p $R_DATA $R_SCRIPTS $R_RESULTS $R_RDSFILES $R_TABLES $R_PLOTS
fi
if [[ $INCLUDE_PYTHON ]]; then
    mkdir -p $PYTHON_DATA $PYTHON_SCRIPTS $PYTHON_RESULTS $PYTHON_TABLES $PYTHON_PLOTS
fi
if [[ $INCLUDE_SNAKEMAKE ]]; then
    mkdir -p $SNAKEMAKE_DATA $SNAKEMAKE_SCRIPTS $SNAKEMAKE_CONFIG $SNAKEMAKE_WORKFLOW_RULES $SNAKEMAKE_WORKFLOW_SCRIPTS
fi

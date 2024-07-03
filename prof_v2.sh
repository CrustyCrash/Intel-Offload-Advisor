#!/bin/bash
`module load advisor`

# take input from user for target gpu names
echo "Enter Target GPU: "
read target_gpu

# ask the user for path to executable
echo "Enter path to output directory (Enter absolute path): "
read output

# ask user to for path to output file
echo "Enter path to executable file (Enter absolute path): "
read executable

# run the command with advisor profiler
`advisor --collect=offload --config=$target_gpu --project-dir=$output -- $executable`
echo "Opening in firefox"
`firefox ./$output/e000/report/advisor-report.html`


#!/bin/bash

# Display available GPU options
echo "Available GPU options:"
echo "1. xehpg_256xve"
echo "2. xehpg_512xve"
echo "3. gen12_tgl"
echo "4. gen12_dg1"
echo "5. gen11_icl"
echo "6. gen9_gt2"
echo "7. gen9_gt3"
echo "8. gen9_gt4"

# Ask user for target GPU
while true; do
    echo "Enter Target GPU number: "
    read target_gpu

    # Use case statement to set target_gpu variable
    case $target_gpu in
        1) target_gpu="xehpg_256xve"; break;;
        2) target_gpu="xehpg_512xve"; break;;
        3) target_gpu="gen12_tgl"; break;;
        4) target_gpu="gen12_dg1"; break;;
        5) target_gpu="gen11_icl"; break;;
        6) target_gpu="gen9_gt2"; break;;
        7) target_gpu="gen9_gt3"; break;;
        8) target_gpu="gen9_gt4"; break;;
        *)
            echo "Invalid Target GPU. Please try again."
            ;;
    esac
done

# Ask user for path to output directory
echo "Enter path to output directory (Enter absolute path): "
read output

# Ask user for path to executable file
echo "Enter path to executable file (Enter absolute path): "
read executable

# Load advisor module
module load advisor/latest

# Run advisor command with profiler
advisor --collect=offload --config=$target_gpu --project-dir=$output -- $executable
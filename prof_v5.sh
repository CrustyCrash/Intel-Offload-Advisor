#!/bin/bash

echo "Do you want to compile or give executable?"
echo "1. Compile"
echo "2. executable"
read choice

if [[ $choice -eq 1 ]]; then
    echo "Enter the path the file: "
    read path
    if [[ $path == *.cpp ]]; then
        echo "Detected CPP file..compiling with g++"
        g++ -o profilerCPP "$path"
        executable="./profilerCPP"
    elif [[ $path == *.c ]]; then
        echo "Detected C file..compiling with gcc"
        gcc -o profilerC "$path"
        executable="./profilerC"
    fi
elif [[ choice -eq 2 ]]; then
    echo "Give path to executable:"
    read executable

else 
    echo "Invalid choice. Please try again."
    exit 1
fi

module_array=($(module avail | grep advisor))
echo "${#module_array[@]}"
i=1
i=0
for module in "${module_array[@]}"; do
    if [[ $module == advisor* ]]; then
        echo  "$i) $module"
        ((i++))
    fi
done

echo "Choose module to load (select number)"
read module_version

if [ $module_version -le $i ]; then
    module load "${module_array[$module_version]}"
else
    echo "Invalid module version. Please try again."
    exit 1
fi

# Ask user for target GPU

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

# # Ask user for path to executable file
# echo "Enter path to executable file (Enter absolute path): "
# read executable

# Run advisor command with profiler
# echo "Executable file is: $executable"
advisor --collect=offload --config=$target_gpu --project-dir=$output -- $executable
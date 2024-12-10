Template_dir="/home/hexolexo/Documents/Assessments/Template"
Assessments_Dir="/home/hexolexo/Documents/Assessments"
Subject=$(gum choose "Software" "Enterprise" "Legal" "Math" "English")
Year=$(gum choose "Y1" "Y2")
Task=$(gum choose "T1" "T2" "T3" "T4")
dir_path=$(printf "%s/%s/%s_%s\n" "$Assessments_Dir" "$Subject" "$Year" "$Task")
mkdir -p $dir_path
cp -r $Template_dir/* $Template_dir/.* $dir_path/.


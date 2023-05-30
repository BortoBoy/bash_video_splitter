# Constants to use
readonly TIMES_FILE="./times.txt"
readonly INPUT_VIDEO="./video.MOV"
readonly COMMAND_FILE="./command.sh"

# Get video extension
IFS="."
read -ra array <<< "$INPUT_VIDEO"
video_ext="${array[-1]}"

# Create command file
echo "" > "$COMMAND_FILE"

# Create output folder
mkdir ./output

# Check if the file exists
if [ -f "$TIMES_FILE" ]; then
  # Iterate over each line in the file
  while IFS= read -r line; do

    # Read the string and split it into parts
    IFS=" "
    read -ra array <<< "$line"

    # Assign splitted strings into variables    
    section="${array[0]%?}" # section
    start="${array[1]}" # start time
    final="${array[3]}" # final time

    # Split start time and final times
    IFS=":"
    read -ra start_splited <<< "$start"
    read -ra final_splited <<< "$final"

    # Calculate duration
    start_in_seconds=$((${start_splited[0]#0}*60 + ${start_splited[1]#0}))
    final_in_seconds=$((${final_splited[0]#0}*60 + ${final_splited[1]#0}))
    duration=$(($final_in_seconds - $start_in_seconds))

    # Formating parameters
    fstart="00:0$start"
    fduration="00:$(printf "%02d" $((duration / 60))):$(printf "%02d" $((duration % 60)))"

    # Building command
    command="ffmpeg -ss ${fstart}"                    # start
    command="$command -t ${fduration}"                # duration
    command="$command -i video.MOV"                   # input
    command="$command -vcodec copy"                   # video codification
    command="$command -acodec copy"                   # audio codification
    command="$command ./output/$section.$video_ext"   # output
    command="$command -y"                             # force overwrite
    command="$command -loglevel quiet"                # quiet
    
    # Feed command file
    echo "$command" >> "$COMMAND_FILE"
    
  done < "$TIMES_FILE"

  # Excute command file
  chmod +x "$COMMAND_FILE"
  bash "$COMMAND_FILE"
  rm "$COMMAND_FILE"

else
  echo "File $TIMES_FILE does not exist."
fi
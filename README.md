# VIDEO CUTTER

I created this simple bash code to easily cut videos. The inputs to this program are:

- the video as input
- a file containing the scenes do cut

Each line on the scenes file could contain this format of data  
  
*section_name: 0:00 -> 0:30*  
  
The line above will generate a video file named *section_name* containing the slice of the original video that starts on 0:00 and finishes on 0:30. Put how many lines do you want in the file.
In the file top you will find three constants, it is important to preset these constants before to execute the code:

```bash
readonly TIMES_FILE="./times.txt"       # the path of the files containing the scenes cut information
readonly INPUT_VIDEO="./video.MOV"      # the input video
readonly COMMAND_FILE="./command.sh"    # an auxiliary that stores the commands to create the videos
```

The auxiliary file is removed after the execution and the videos are going to be created inside a folder named output, created in the same place where the script is located.

Enjoy it :*
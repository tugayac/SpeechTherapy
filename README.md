# Speech Therapy Application #
This repository contains programs and applications that aim to diagnose different types of Autism using speech methods.

## Audio Extractor ##
The audio extractor allows users to extract audio from several different video filetypes. The audio extracted from the videos are meant to be used to compare with speech samples from users with no Autism.

Decoding and encoding are done using the [Java Audio Video Encoder](http://www.sauronsoftware.it/projects/jave/index.php) (JAVE), a JAVA wrapper library for FFmpeg developed by Carlo Pelliccia.

The most current version is v0.1

### Running the Program ###
To run the audio extractor, go to AudioExtractor/dist/ and run AudioExtractor.jar by double-clicking on it. Alternatively, you can run it from the command line using:
    
``$ java -jar AudioExtractor.jar``
    
You can also open up the project in NetBeans and change it as you like.

### Requirements ###
* Java 7

* The program has been tested on Windows 8 and does run. It should run properly on earlier versions of Windows; however, there is no guarantee.
* The program has been tested on Mac OSX 10.7.5 and <b>does not run</b>. This is because JAVE does not provide an ffmpeg executable for MAC OSX. Latest versions of ffmpeg executables do not work. Apple Mac users can check out [ffmpegX](http://www.ffmpegx.com/download.html) as an alternative.
* The program has been tested on Linux (Ubuntu 12.04) and does run. It should run properly on other versions of Ubuntu/Debian based Linux systems; however, there is no guarantee. 

### Features ###
The Audio Extractor features the following:
* Supports multiple video file types (Currently MP4, M4A, MPEG, MPG, MOV, FLV, AVI)
* Selecting and extracting audio from multiple files at the same time.
* Audio properties displayed for selected video files.
* Several different properties for the output audio files that can be changed
    + Bit Rate
    + Sampling Rate
    + Audio Channels
    + File Type (Currently MP3, AAC, FLAC, WAV, OGG)
* Progress of the files displayed for the convenience of the user.

### Known Issues ###
* Properties of video files can be changed in the table, although this has no effect to the file's metadata.
* Stop Button is grayed out due to some issues with Java Threads. This feature will be fixed in the future.
* Extract button can be clicked multiple times, even when the extrator is running. This will cause it to run the same job again. For now, refrain from clicking the Extract button before the current extraction process is complete.
* An exception is thrown if the program is closed before extraction is completed. However, this exception should not affect the user.

### Possible Features ###
* Allow the user to choose the FFmpeg executable that they would like to use.
* Ability to stop the encoding process.
* Ability to increase the thread priority.
* Ability to run multiple extraction threads at the same time for multiple files.
* Expanding the project to make it a full-fledged Audio-Video Converter.

### External Libraries and License ###
This software is released under the General Public License (GPL) because the JAVE external library uses the GPL license. A copy of the license is included with the program.

## Audio Analysis with Praat ##
After extracting the audio from the video, [Formant Analysis](http://en.wikipedia.org/wiki/Formant) can be performed to extract vowel information using a software called [Praat](http://www.fon.hum.uva.nl/praat/). A script is included under the Praat/Scripts folder.

### Running the Script ###
The script provided with the project will allow you to extract the formant frequencies from audio files in a given folder. The information will be extracted into a text file.

1. First of all, you will need to install [Praat](http://www.fon.hum.uva.nl/praat/).
2. Assuming you are running a Linux machine, run the script by executing the following command from the terminal (The example below assumes that you're in the same folder as the script:
    
    ``$ praat sound_data.praat /home/user/Documents/SpeechTherapy/Praat/Test_Files .wav 0.001 75 600 4 5000 0.025 50``

This command will run the praat script `sound_data.praat` on the files located in `/home/user/Documents/SpeechTherapy/Praat/Test_Files`, which are `.wav` files. Numeric parameters represent the following:
* Pitch Settings
    + Time Step (s) - Default: 0.001 => The time step between each value sampled from the audio file. Also used for extracting formant frequencies.
    + Pitch Floor (Hz) - Default: 75 => Candidates below this frequency will be ignored.
    + Pitch Ceiling (Hz) - Default: 600 => Candidates above this frequency will be ignored.
* Formant Settings
    + Maximum Number of Formants - Default: 4 => Number of formant frequencies that will be extracted. Changing this feature will not affect anything as it is <b>Not Yet Implemented!</b>
    + Maximum Formant (Hz) - Default: 5000 => Maximum value for Formant searching. The value has to be different depending on who the speaker is. Default value for males is 5000 and females is 5500.
    + Window Length (s) - Default: 0.025 => Duration of the analysis window.
    + Pre-Empahsis From (Hz) - Default: 50 => Enhances frequencies starting at this frequency and above.

You can follow the links for more information on [Pitch Settings](http://www.fon.hum.uva.nl/praat/manual/Sound__To_Pitch___.html) and [Formant Settings](http://www.fon.hum.uva.nl/praat/manual/Sound__To_Formant__burg____.html).

3. The output file has the following format (no headers are included in output files to make is easier for parsing):

`Time   Pitch   F1  F2  F3  F4`

A value of `--undefined--` indicates that no value exists at that time. Note that there are a lot less pitch values. These pitch values indicate which formant frequency values are valid to use.

### Further Improvements and Additions ###
* Running the script on Windows and Mac OSX Machines.
* Running the script using the Praat GUI.
* A program to compare audio files for patient diagnosis.
* Changing command line arguments based on patient's age.
* Extracting different number of formant frequencies.

### License ###
<TODO>
    
## Contact ##
Please contact Arda C. Tugay at arda.tugay@gmail.com for any questions, concerns, or suggestions.
    
## About the Project ##
The applications in this project are developed by Arda C. Tugay, an undergraduate Computer Science & Software Engineering student from Rose-Hulman Institute of Technology. The project is part of the ERWiN REU program funded by the National Science Foundation.

The project is supervised by Dr. Poellabauer and Dr. Flynn of the Computer Science & Engineering department at University of Notre Dame.

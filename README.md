# Speech Therapy Application #
This repository contains programs and applications that aim to diagnose different types of Autism using speech methods.

## Audio Extractor ##
The audio extractor allows users to extract audio from several different video filetypes. The audio extracted from the videos are meant to be used to compare with speech samples from users with no Autism.

The decoding and encoding are done using the [Java Audio Video Encoder](http://www.sauronsoftware.it/projects/jave/index.php) (JAVE), a JAVA wrapper library for FFmpeg developed by Carlo Pelliccia.

The most current version is v0.1

### Running the Program ###
To run the audio extractor, go to AudioExtractor/dist/ and run AudioExtractor.jar by double-clicking on it. Alternatively, you can run it from the command line using:
    
    $ java -jar AudioExtractor.jar
    
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

## About the Project ##
The applications in this project are developed by Arda C. Tugay, an undergraduate Computer Science & Software Engineering student from Rose-Hulman Institute of Technology.

The project is supervised by Dr. Poellabauer and Dr. Flynn of the Computer Science & Engineering department at University of Notre Dame.

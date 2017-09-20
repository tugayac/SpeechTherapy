# Speech Therapy Application #
This repository contains programs and applications that were used for research in using speech methods to help diagnose different types of Autism. Please note this is only research and programs and applications provided in this repository have not been proven to solely diagnose Autism.

## Table of Contents ##
1. [Audio Extractor](#ae)<br />
    1.1. [Running the Program](#ae_running)<br />
    1.2. [Requirements](#ae_req)<br />
    1.3. [Features](#ae_feat)<br />
    1.4. [Known Issues](#ae_issues)<br />
    1.5. [Possible Features](#ae_pos_feat)<br />
    1.6. [External Libraries and License](#ae_license)<br />
2. [Audio Analysis with Praat](#aap)<br />
    2.1. [Running the Script](#aap_run)<br />
    2.2. [Further Improvements and Additions](#aap_imp)<br />
    2.3. [License](#aap_license)<br />
3. [iPad Application for Audio Recording Tests](#ipad_app)<br />
    3.1. [How to Create New Voice Recording Tests](#ipad_app_new_test)<br />
    3.2. [Limitations of the Application](#ipad_app_limit)<br />
    3.3. [License](#ipad_app_license)<br />
4. [Contact](#contact)<br />
5. [About the Project](#about)<br />

<a name="ae"/>

## Audio Extractor ##
The audio extractor allows users to extract audio from several different video filetypes. The audio extracted from the videos are meant to be used to compare with speech samples from users with no Autism.

Decoding and encoding are done using the [Java Audio Video Encoder](http://www.sauronsoftware.it/projects/jave/index.php) (JAVE), a JAVA wrapper library for FFmpeg developed by Carlo Pelliccia.

The most current version is v0.1

<a name="ae_running"/>

### Running the Program ###
To run the audio extractor, go to AudioExtractor/dist/ and run AudioExtractor.jar by double-clicking on it. Alternatively, you can run it from the command line using:
    
``$ java -jar AudioExtractor.jar``
    
You can also open up the project in NetBeans and change it as you like.

<a name="ae_req"/>
### Requirements ###

* Java 7
* The program has been tested on Windows 8 and does run. It should run properly on earlier versions of Windows; however, there is no guarantee.
* The program has been tested on Mac OSX 10.7.5 and <b>does not run</b>. This is because JAVE does not provide an ffmpeg executable for MAC OSX. Latest versions of ffmpeg executables do not work. Apple Mac users can check out [ffmpegX](http://www.ffmpegx.com/download.html) as an alternative.
* The program has been tested on Linux (Ubuntu 12.04) and does run. It should run properly on other versions of Ubuntu/Debian based Linux systems; however, there is no guarantee. 

<a name="ae_feat"/>

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

<a name="ae_issues"/>

### Known Issues ###
* Properties of video files can be changed in the table, although this has no effect to the file's metadata.
* Stop Button is grayed out due to some issues with Java Threads. This feature will be fixed in the future.
* Extract button can be clicked multiple times, even when the extrator is running. This will cause it to run the same job again. For now, refrain from clicking the Extract button before the current extraction process is complete.
* An exception is thrown if the program is closed before extraction is completed. However, this exception should not affect the user.

<a name="ae_pos_feat"/>

### Possible Features ###
* Allow the user to choose the FFmpeg executable that they would like to use.
* Ability to stop the encoding process.
* Ability to increase the thread priority.
* Ability to run multiple extraction threads at the same time for multiple files.
* Expanding the project to make it a full-fledged Audio-Video Converter.

<a name="ae_license"/>

### External Libraries and License ###
This software is released under the General Public License (GPL) because the JAVE external library uses the GPL license. A copy of the license is included with the program.

<a name="aap"/>

## Audio Analysis with Praat ##
After extracting the audio from the video, [Formant Analysis](http://en.wikipedia.org/wiki/Formant) can be performed to extract vowel information using a software called [Praat](http://www.fon.hum.uva.nl/praat/). A script is included under the Praat/Scripts folder.

<a name="aap_run"/>

### Running the Script ###
The script provided with the project will allow you to extract the formant frequencies from audio files in a given folder. The information will be extracted into a text file.

1. First of all, you will need to install [Praat](http://www.fon.hum.uva.nl/praat/).
2. Assuming you are running a Linux machine, run the script by executing the following command from the terminal (The example below assumes that you're in the same folder as the script:

```
$ praat sound_data.praat /home/user/Documents/SpeechTherapy/Praat/Test_Files .wav 0.001 50 150 4 5000 0.025 50
```

This command will run the praat script `sound_data.praat` on the files located in `/home/user/Documents/SpeechTherapy/Praat/Test_Files`, which are `.wav` files. Numeric parameters represent the following:
* Pitch Settings
    + Time Step (s) - Default: 0.001 => The time step between each value sampled from the audio file. Also used for extracting formant frequencies.
    + Pitch Floor (Hz) - Default: 50 => Candidates below this frequency will be ignored. The deeper a person's voice, the lower the value should be, such as 50 Hz.
    + Pitch Ceiling (Hz) - Default: 150 => Candidates above this frequency will be ignored. The higher a person's voice, the higher the value should be, such as 300 Hz.
* Formant Settings
    + Maximum Number of Formants - Default: 4 => Number of formant frequencies that will be extracted. Changing this feature will not affect anything as it is <b>Not Yet Implemented!</b>
    + Maximum Formant (Hz) - Default: 5000 => Maximum value for Formant searching. The value has to be different depending on who the speaker is. Default value for males is 5000 and females is 5500.
    + Window Length (s) - Default: 0.025 => Duration of the analysis window.
    + Pre-Empahsis From (Hz) - Default: 50 => Enhances frequencies starting at this frequency and above.

You can follow the links for more information on [Pitch Settings](http://www.fon.hum.uva.nl/praat/manual/Sound__To_Pitch___.html) and [Formant Settings](http://www.fon.hum.uva.nl/praat/manual/Sound__To_Formant__burg____.html).

3. The output file has the following format (no headers are included in output files to make is easier for parsing):

```
Time   Pitch   F1  F2  F3  F4
```

A value of `--undefined--` indicates that no value exists at that time. Note that there are a lot less pitch values. These pitch values indicate which formant frequency values are valid to use.

<a name="aap_imp"/>

### Further Improvements and Additions ###
* Running the script on Windows and Mac OSX Machines.
* Running the script using the Praat GUI.
* A program to compare audio files for patient diagnosis.
* Changing command line arguments based on patient's age.
* Extracting different number of formant frequencies.

<a name="aap_license"/>

### License ###
The script uses the same license as Praat (GNU General Public License), since it can only be used with Praat. A copy of the license can be found on the [Praat License](http://www.fon.hum.uva.nl/praat/GNU_General_Public_License.txt) page.

<a name="ipad_app"/>

## iPad Application for Audio Recording Tests ##
App usage should be intuative for anyone who is familiar with voice recording on the iPad. If you need more information on how to use the app, you can watch the [YouTube Tutorial](http://youtu.be/Mlpd7l-lAdg).

<a name="ipad_app_new_test"/>

### How to Create New Voice Recording Tests ###
Creating a new voice recording test is fairly easy for anyone who is experienced with object-oriented programming.<br />
1. Find the TestWithPictureViewController.h file, which contains the source code for "Voice Test 1". The related .m and .xib files have the same file name, if you want to view them.<br />
2. Now find the SecondTestViewController.h file. Notice that this class inherits the TestWithPictureViewController class. This means that SecondTestViewController has all the properties that TestWithPictureViewController class has. If you switch to the corresponding .m file, you will notice the original -setImages method being overriden. It should look like this:

``` objective-c
- (void)setImages
{
    self.listOfImageFiles = [[NSArray alloc] initWithObjects:@"head.png", @"tree.png", @"green.png", @"sleep.png", @"ear.png", nil];
}
```

Recall that the original method looks like this:

``` objective-c
- (void)setImages
{
    self.listOfImageFiles = [[NSArray alloc] initWithObjects:@"head.png", @"tree.png", @"green.png", @"sleep.png", @"ear.png", @"teeth.png", @"needle.png", @"cheese.png", @"sneeze.png", @"wheel.png", nil];
}
```

3. Therefore, in order to create a new test, create a new Objective-C Class and make it a Subclass of TestWithPictureViewController. For the sake of this tutorial, we will call the new test class <b>ThirdTestViewController</b>.<br />
4. Once the class is created, go to the .m file of your new class and override the -setImages method as you see above. <b>Make sure that the image file names refer to what the picture shows. For example, if the image is a tree, then the file name should be tree.png or tree.jpg</b> (make sure you use either PNG or JPG images). This is important because the app generates the text label for each image based on the file name. Also, make sure that the image files are added to the project. This is all you have to do to create the new test!<br />
5. Now you need to get your new test to show up on the new tests view. Go to TestsViewController.m and find the -viewDidLoad method. It should look something like this:

``` objective-c
- (void)viewDidLoad
{
    self.tests = [[NSMutableArray alloc] init];
    
    // Add new test name here
    [self.tests addObject:@"Voice Test 1"];
    [self.tests addObject:@"Voice Test 2"];
}
```

Now add the name of your new test after the line:
``` objective-c 
[self.tests addObject:@"Voice Test 2"];
```

-viewDidLoad should now look something like this (I named the new test "Voice Test 3")
``` objective-c
- (void)viewDidLoad
{
    self.tests = [[NSMutableArray alloc] init];
    
    // Add new test name here
    [self.tests addObject:@"Voice Test 1"];
    [self.tests addObject:@"Voice Test 2"];
    [self.tests addObject:@"Voice Test 3"];
}
```

6. Finally, the test has to be called whenever it's touched on the view. Again in TestsViewController.m, go to the -collectionView:collectionView didSelectItemAtIndexPath:indexPath method. It should look something like this:

``` objective-c
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row] == 0) {
        TestWithPictureViewController *tpvc = [[TestWithPictureViewController alloc] init];
        [self initializeAndDisplayTestWithPictureViewController:tpvc];
    } else if ([indexPath row] == 1) {
        SecondTestViewController *stvc = [[SecondTestViewController alloc] init];
        [self initializeAndDisplayTestWithPictureViewController:stvc];
    }
    // Add the next else if statement here
}
```

Since the new test is added after the second test, we will need to check when the indexPath.row value equals 2 (indices start at 0) and fill in the body for that else-if statement. The body of the else-if statement should look something like this:

``` objective-c
ThirdTestViewController *ttvc = [[ThirdTestViewController alloc] init];
[self initializeAndDisplayTestWithPictureViewController:ttvc];
```

-collectionView:collectionView didSelectItemAtIndexPath:indexPath should now look something like this:

``` objective-c
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row] == 0) {
        TestWithPictureViewController *tpvc = [[TestWithPictureViewController alloc] init];
        [self initializeAndDisplayTestWithPictureViewController:tpvc];
    } else if ([indexPath row] == 1) {
        SecondTestViewController *stvc = [[SecondTestViewController alloc] init];
        [self initializeAndDisplayTestWithPictureViewController:stvc];
    } else if ([indexPath row] == 2) {
       ThirdTestViewController *ttvc = [[ThirdTestViewController alloc] init];
        [self initializeAndDisplayTestWithPictureViewController:ttvc]; 
    }
    // Add the next else if statement here
}
```

You're done! The new test should now be functioning properly. If it's not, make sure the image files are added to the project and that all the syntax is correct.

<a name="ipad_app_limit">

### Limitations of the Application ###
* The application is designed to work only in portrait mode. As such, you won't be able to flip it into Landscape mode. This can be changed from the project settings, but there is no guarantee that anything will function properly.
* There are no settings for the audio recording. Right now, the application records at a sampling rate of 44100 Hz, very high quality, and 2 channels.
* The audio can only be uploaded to Dropbox, given that the user has a Dropbox account to use with the application
* It is distributed as-is and has been tested to work on an iPad 2 with iOS 6.1. The results are unknown for newer or older versions of the iPads, but it is guarenteed to <b>not work</b> with iOS versions older than 6.1. 

<a name="ipad_app_license">

### License ###
This software is released under the General Public License (GPL). By using this application, you agree that this software may not work as intended. The developer cannot be held responsible for any damage caused to the device by this software.

<a name="contact"/>

## Contact ##
Please contact Arda C. Tugay at ardactugay@gmail.com for any questions, concerns, or suggestions.

<a name = "about"/>

## About the Project ##
The applications in this project were developed in 2013, by Arda C. Tugay, then undergraduate Computer Science & Software Engineering student from Rose-Hulman Institute of Technology. The project was part of the ERWiN REU program funded by the National Science Foundation.

The project was supervised by Dr. Poellabauer and Dr. Flynn of the Computer Science & Engineering department at University of Notre Dame.

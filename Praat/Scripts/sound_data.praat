# Get the path to the sound file
form Enter the directory of the file
	comment Directory of Sound Files
	text directory /home/user/Desktop
	comment Sound File Extension
	text extension .wav
	comment Time Step (s)
	positive timeStep 0.001
	comment Pitch Floor (Hz)
	positive pitchFloor 25.0
	comment Pitch Ceiling (Hz)
	positive pitchCeiling 300.0
	comment Maximum Number of Formants
	positive maxFormants 4
	comment Maximum Formant (Hz)
	positive maxFormantFreq 5000 (= adult male)
	comment Window Length (s)
	positive windowLength 0.025
	comment Pre-emphasis from (Hz)
	positive preemphasisFrom 50
endform

writeInfoLine("Starting analysis...")
totalRuntime = 0
do("Create Strings as file list...", "fileList", directory$ + "/*" + extension$)
numberOfFiles = do("Get number of strings")
for ifile to numberOfFiles
	selectObject("Strings fileList")
	fileName$ = do$("Get string...", ifile)
	appendInfoLine("Reading file " + fileName$ + "...")
	do("Read from file...", directory$ + "/" + fileName$)
	appendInfoLine("File successfully read!")

	# Repeat all the following commands for each file
	soundName$ = selected$ ("Sound", 1)
	tmin = do("Get start time")
	tmax = do("Get end time")
	
	appendInfoLine("Analyzing pitch information...")
	stopwatch
	do("To Pitch...", timeStep, pitchFloor, pitchCeiling)
	runtime1 = stopwatch
	appendInfoLine("Completed analysis in " + fixed$(runtime1, 3) + " seconds.")

	do("Rename...", "pitch")
	selectObject("Sound " + soundName$)

	appendInfoLine("Analyzing formant frequencies...")
	stopwatch
	do("To Formant (burg)...", timeStep, maxFormants, maxFormantFreq, windowLength, preemphasisFrom)
	runtime2 = stopwatch
	appendInfoLine("Completed analysis in " + fixed$(runtime2, 3) + " seconds.")

	do("Rename...", "formant")

	appendInfoLine("Writing information to " + soundName$ + ".txt")
	stopwatch
	for i to (tmax - tmin) / 0.01
		time = tmin + i * 0.01
		selectObject("Pitch pitch")
		pitch = do("Get value at time...", time, "Hertz", "Linear")
		selectObject("Formant formant")
		formantOne = do("Get value at time...", 1, time, "Hertz", "Linear")
		formantTwo = do("Get value at time...", 2, time, "Hertz", "Linear")
		formantThree = do("Get value at time...", 3, time, "Hertz", "Linear")
		formantFour = do("Get value at time...", 4, time, "Hertz", "Linear")
		line$ = fixed$(time, 2) + " " + fixed$(pitch, 4) + " " + fixed$(formantOne, 4) + " " + fixed$(formantTwo, 4) + " " + fixed$(formantThree, 4) + " " + fixed$(formantFour, 4)
		appendFileLine(directory$ + "/" + soundName$ + ".txt", line$)
	endfor
	runtime3 = stopwatch
	appendInfoLine("Wrote information to file in " + fixed$(runtime3, 3) + " seconds.")
	fileRuntime = runtime1 + runtime2 + runtime3
	appendInfoLine("Completed analyzing file in " + fixed$(fileRuntime, 3) + " seconds.")
	totalRuntime = totalRuntime + fileRuntime
	appendInfoLine("===================================================================")

	# Remove objects that are not needed
	selectObject("Sound " + soundName$)
	plusObject("Pitch pitch")
	plusObject("Formant formant")
	do("Remove")
endfor
removeObject("Strings fileList")
appendInfoLine("Completed running script in " + fixed$(totalRuntime, 3) + " seconds.")

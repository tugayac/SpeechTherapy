#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
#include <stdlib.h>
#include <vector>
using namespace std;

typedef struct Formant {
	double time;
	double pitch;
	double f1;
	double f2;
	double f3;
	double f4;
} Formant;

typedef struct AvgFormant {
	double timeframe;
	double avgPitch;
	double avgF1;
	double avgF2;
	double avgF3;
	double avgF4;
} AvgFormant;

int main() {
	std::ifstream readFile("test.txt");

	vector<AvgFormant> avgFormants;
	if (!readFile.is_open()) {
		cout << "Could not read file!" << endl;
	}

	vector<Formant> formants(50);
	formants.clear();
	string pitchValue;
	string line;
	Formant *formant = (Formant *) malloc(sizeof(Formant));
	bool pitchIsNotUndefined = false;
	while (getline(readFile, line)) {
		istringstream read(line);
		read >> formant->time;
		read >> pitchValue;
		if (pitchValue == "--undefined--") {
			if (pitchIsNotUndefined) {
				pitchIsNotUndefined = false;
				double timeTaken = formants[formants.size() - 1].time - formants[0].time;
				if (timeTaken <= 0.05) { // Temporary solution to get rid of pitch generated by noise
					continue;
				}

				double sum = 0;
				for (int i = 0; i < formants.size(); i++) {
					sum += formants[i].pitch;
				}

				AvgFormant *avgFormant = (AvgFormant *) malloc(sizeof(AvgFormant));
				avgFormant->timeframe = timeTaken;
				avgFormant->avgPitch = sum / formants.size();
				avgFormants.push_back(*avgFormant);
				delete avgFormant;

				formants.clear();
			} else {
				continue;
			}
		} else {
			pitchIsNotUndefined = true;

			formant->pitch = atof(pitchValue.c_str());
			read >> formant->f1 >> formant->f2 >> formant->f3 >> formant->f4;
			formants.push_back(*formant);
		}
	}
	readFile.close();

	for (int i = 0; i < avgFormants.size(); i++) {
		cout << "Time Taken: " << avgFormants[i].timeframe << " Avg. Pitch: " << avgFormants[i].avgPitch << endl;
	}

	return 0;
}
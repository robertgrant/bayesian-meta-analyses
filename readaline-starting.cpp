#include <iostream>
#include <string>
#include <fstream>
#include <sstream>
using std::cin;
using std::cout;
using std::cerr;
using std::endl;
using std::string;
using std::to_string; // this will require -std=c++11 when compiling
using std::ifstream;
using std::ofstream;
using std::stringstream;

int main(int argc, char *argv[]) {
    string filename = argv[1];
    string findstart = argv[2];
    int startlen = findstart.length();
    string findend;
    int endlen;
    if(argc==4) {
        findend = argv[3];
        endlen = findend.length();
    }
    string line;
    bool done = false;
    string linestart;
	ifstream rfile;
    rfile.open(filename,ifstream::in);
	if(rfile) {
	    while(!rfile.eof() && !done) {
            getline(rfile,line);
            line = line.substr(0,line.length()-1);
            linestart = line.substr(0,startlen); // will this throw error for line.length()<startlen?
            if(linestart==findstart) {
                while(!done && !rfile.eof()) {
                    cout << line << endl;
                    getline(rfile,line);
                    line = line.substr(0,line.length()-1);
                    if(argc==4) {
                        done = (line.substr(0,endlen)==findend);
                    }
                    else {
                        done = true;
                    }
                }
            }
	    }
	}
    return 0;
}
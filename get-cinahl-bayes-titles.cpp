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
	stringstream sarg;
    string bigfile;
    string outfile;

	if(argc!=3) {
	    cerr << "Arguments error";
	    return -1;
	}
    bigfile=argv[1];
	if(bigfile=="") {
	    cerr << "bigfile is missing..." << endl;
	    return -1;
	}
    outfile=argv[2];
	if(outfile=="") {
	    cerr << "outfile is missing..." << endl;
	    return -1;
	}
	
	string line;
	string prev = "";
	ifstream rfile;
    ofstream wfile;
    rfile.open(bigfile,ifstream::in);
    wfile.open(outfile,ofstream::out);
	if(rfile) {
        while(!rfile.eof()) {
            getline(rfile,line);
            if(prev=="Title:") {
                wfile << line << endl;
            }
            prev = line;
            cout << prev << endl;
        }
        wfile.close();
        rfile.close();
    	return 0;
    }
    else {
        cerr << bigfile << " does not exist" << endl;
        return -1;
    }
}

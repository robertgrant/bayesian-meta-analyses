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
	string prev = "x";
	string prev2 = "x";
	int npaper=1;
	ifstream rfile;
    ofstream wfile;
    rfile.open(bigfile,ifstream::in);
    wfile.open(outfile,ofstream::out);

	if(rfile) {
        while(!rfile.eof()) {
            //cout << "Compare line "+to_string(lnum)+" to "+linematch << endl;
            getline(rfile,line);
            // get rid of windows eol
            line = line.substr(0,line.length()-1);
            // have we just passed 2 blank lines?
            if(prev2=="" && prev=="") {
                // keep going until the next single blank line
                /*while(!(prev2!="" && prev=="")) {
                    prev2 = prev;
                    prev = line;
                    getline(rfile,line);
                    // get rid of windows eol
                    line = line.substr(0,line.length()-1);
                }*/
                // now capture lines until the next blank one
                //wfile << to_string(npaper) << endl;
                while(line!="") {
                    wfile << line;
                    prev2 = prev;
                    prev = line;
                    getline(rfile,line);
                    // get rid of windows eol
                    line = line.substr(0,line.length()-1);
                }
                wfile << endl;
                ++npaper;
            }
            prev2 = prev;
            prev = line;
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

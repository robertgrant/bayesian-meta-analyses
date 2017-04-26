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
	int lnum=1;
	int npaper=1;
	string spaper;
	string linematch;
	int spaperlen;
	ifstream rfile;
    ofstream wfile;
    rfile.open(bigfile,ifstream::in);
    wfile.open(outfile,ofstream::out);

	if(rfile) {
        spaper=to_string(npaper);
        spaperlen = spaper.length();
        if(spaperlen > 3) {
            linematch = spaper.substr(0,(spaperlen-3))+","+spaper.substr((spaperlen-3),3)+".";
        }
        else {
            linematch = spaper+".";
        }
        while(!rfile.eof()) {
            getline(rfile,line);
            // get rid of windows eol
            line = line.substr(0,line.length()-1);
            if(prev==linematch) {
                // move down two lines
								prev=line;
								getline(rfile,line);
								prev=line;
								getline(rfile,line);
								// write citation
                wfile << line << endl;
                ++npaper;
                spaper=to_string(npaper);
                spaperlen = spaper.length();
                if(spaperlen > 3) {
                    linematch = spaper.substr(0,(spaperlen-3))+","+spaper.substr((spaperlen-3),3)+".";
                }
                else {
                    linematch = spaper+".";
                }
            }
            else {
            }
            prev = line;
            ++lnum;
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

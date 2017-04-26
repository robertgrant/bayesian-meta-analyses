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
	if(argc!=3) {
	    cerr << "Arguments error";
	    return -1;
	}
	
	string infile = argv[1];
	string outfile = argv[2];
	ifstream rfile;
	ofstream wfile;
	string line="";
	string prev="";
	int npaper=1;
	bool writing=false;
	
	rfile.open(infile,ifstream::in);
    wfile.open(outfile,ofstream::out);
    
    while(!rfile.eof()) {
        prev=line;
        getline(rfile,line);
        if(prev==to_string(npaper)) {
            wfile << line;
            ++npaper;
            writing=true;
        }
        else if(writing && (prev=="" | line!="")) {
            wfile << " " << line;
        }
        else if(prev!="" && line=="") {
            wfile << endl;
            writing=false;
        }
    }
    
    rfile.close();
    wfile.close();
    return 0;
}

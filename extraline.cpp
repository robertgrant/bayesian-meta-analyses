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
	ifstream rfile;
    ofstream wfile;
    string line;
    rfile.open("medline-MA.txt",ifstream::in);
    wfile.open("medline-MA2.txt",ofstream::out);
    wfile << endl;
    while(!rfile.eof()) {
        getline(rfile,line);
        wfile << line << endl;
    }
    wfile.close();
    rfile.close();
	return 0;
}

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
	if(argc!=4) {
	    cerr << "Arguments error";
	    return -1;
	}

    string mat=argv[1];
    string bayest=argv[2];
    string outfile=argv[3];

	string matline;
	string bayestline;
	int malinenum=1;
	int bayeslinenum=1;
	int i;
	bool done=false;
	bool done2=false;
	ifstream matfile;
	ifstream bayestfile;
  ofstream wfile;
    bayestfile.open(bayest,ifstream::in);
    wfile.open(outfile,ofstream::out);

    while(!bayestfile.eof()) { // loop through the lines of the bayest file
        getline(bayestfile,bayestline);
        cout << to_string(bayeslinenum) << endl;

        // loop through lines of ma titles
        done=false;
        malinenum=1;
				matfile.open(mat,ifstream::in);
        while(!matfile.eof() && !done) {
            getline(matfile,matline);
            if(matline==bayestline) {
                done=true;
                wfile << "Bayes item #"+to_string(bayeslinenum)+" matches MA item #"+to_string(malinenum) << endl;
                wfile << "########## Bayes title "+to_string(bayeslinenum)+"##########" << endl;
                wfile << bayestline << endl;
                wfile <<"########## MA title "+to_string(malinenum)+"##########" << endl;
                wfile << matline << endl;
                wfile << endl;
            }
            ++malinenum; // remember this will be the line number+1
        }
        matfile.close();
        ++bayeslinenum; // next bayes title
    }
    matfile.close();
    bayestfile.close();
    wfile.close();
    return 0;
}

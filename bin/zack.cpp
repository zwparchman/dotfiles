#include <iostream>
#include <stdlib.h>
#include <vector>
#include <iomanip>
#include <sys/types.h>
#include <unistd.h>

const char * light_dm = "systemctl restart lightdm.service";
const char * network_manager = "systemctl restart network-manager.service";

using namespace std;

int main(){

    int choice;
    std::vector<const char*> strs = { light_dm, network_manager };

    cout<<"Run which command?\n";
    int count=1;
    for( auto i : strs ){
        cout<<setw(3)<<count<<") "<<i<<endl;
        count++;
    }

    cin>>choice;
    if(!cin.good()){
        cerr<<"Bad stdin read\n";
        return 1;
    }

    choice--;

    try{
        const char * s = strs.at(choice);
        cout<<s<<endl;
        return system(s);
    } catch ( std::out_of_range &){
        cerr<<"Out of range, aborting\n";
        return 1;
    }
}

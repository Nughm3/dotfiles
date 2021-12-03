#include <iostream>
using namespace std;

int main() {
    string input;
    cin >> input;

    long longest = 0;
    long count = 0;

    for (long i = 1; i < input.length(); i++) {
        if (input[i] == input[i-1]) {
            count++;
        } else if (count > longest) {
            longest = count;
            count = 0;
        }
    }
    
    if (count > longest) {
        longest = count;
    }

    cout << longest + 1;

    return 0;
}

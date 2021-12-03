#include <iostream>
#include <bits/stdc++.h>
using namespace std;

int main() {
    int count;
    cin >> count;
    int v[count - 1];

    // Get input
    for (int i = 0; i < count - 1; i++) {
        int input;
        cin >> input;
        v[i] = input;
    }

    std::qsort(v);

    // Solve
    for (int i = 0; i < count - 1; i++) {
        if (v[i] != i) {
            cout << i;
        }
    }

    return 0;
}

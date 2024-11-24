#include <iostream>
#include <algorithm>
#include <vector>

using namespace std;

// Function to check if the current assignment is a valid solution
bool is_solution(int e, int a, int s, int t, int w, int r) {
    int east = e * 1000 + a * 100 + s * 10 + t;
    int west = w * 1000 + e * 100 + s * 10 + t;
    int area = a * 1000 + r * 100 + e * 10 + a;
    return (east + west == area);
}

int main() {
    vector<int> digits = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9};

    // Try all permutations of the digits
    do {
        int e = digits[0], a = digits[1], s = digits[2], t = digits[3];
        int w = digits[4], r = digits[5];

        // E, W, and A cannot be zero (leading digits)
        if (e != 0 && w != 0 && a != 0) {
            if (is_solution(e, a, s, t, w, r)) {
                // Print the solution with the letter assignments
                cout << "Solution found:\n";
                cout << "E = " << e << "\n";
                cout << "A = " << a << "\n";
                cout << "S = " << s << "\n";
                cout << "T = " << t << "\n";
                cout << "W = " << w << "\n";
                cout << "R = " << r << "\n";
                return 0; // Exit after finding the first solution
            }
        }
    } while (next_permutation(digits.begin(), digits.end()));

    cout << "No solution found." << endl;
    return 0;
}

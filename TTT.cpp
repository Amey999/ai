//ticTac toe hardcoded 
#include <iostream>
using namespace std;

// Function to check if a player has won
char checkWinner(char board[3][3])
{
    // Check rows and columns
    for (int i = 0; i < 3; i++)
    {
        if (board[i][0] == board[i][1] && board[i][1] == board[i][2] && board[i][0] != ' ')
            return board[i][0]; // Row win
        if (board[0][i] == board[1][i] && board[1][i] == board[2][i] && board[0][i] != ' ')
            return board[0][i]; // Column win
    }

    // Check diagonals
    if (board[0][0] == board[1][1] && board[1][1] == board[2][2] && board[0][0] != ' ')
        return board[0][0]; // Main diagonal
    if (board[0][2] == board[1][1] && board[1][1] == board[2][0] && board[0][2] != ' ')
        return board[0][2]; // Secondary diagonal

    // No winner
    return ' ';
}

int main()
{
    // Hardcoded board configuration
    char board[3][3] = {
        {'X', 'O', 'X'},
        {'O', 'O', 'O'},
        {'O', 'X', 'X'}};

    // Display the board
    cout << "Current board state:" << endl;
    for (int i = 0; i < 3; i++)
    {
        for (int j = 0; j < 3; j++)
        {
            cout << board[i][j] << " ";
        }
        cout << endl;
    }

    // Check for winner
    char winner = checkWinner(board);

    if (winner == 'X' || winner == 'O')
    {
        cout << "Player " << winner << " wins!" << endl;
    }
    else
    {
        cout << "It's a draw!" << endl;
    }

    return 0;
}
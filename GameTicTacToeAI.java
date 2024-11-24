import java.util.Scanner;

public class GameTicTacToeAI {
    private static final char EMPTY = ' ';
    private static final char HUMAN = 'X';
    private static final char COMPUTER = 'O';
    private static char[] board = new char[9];

    public static void main(String[] args) {
        initializeBoard();
        printBoard();

        while (true) {
            humanMove();
            printBoard();
            if (checkWinner(HUMAN)) {
                System.out.println("Human wins!");
                break;
            }
            if (checkDraw()) {
                System.out.println("It's a draw!");
                break;
            }

            computerMove();
            printBoard();
            if (checkWinner(COMPUTER)) {
                System.out.println("Computer wins!");
                break;
            }
            if (checkDraw()) {
                System.out.println("It's a draw!");
                break;
            }
        }

        System.out.println("Thanks for playing!");
    }

    private static void initializeBoard() {
        for (int i = 0; i < 9; i++) {
            board[i] = (char) ('1' + i); // Initialize board with indices 1-9
        }
    }

    private static void printBoard() {
        System.out.println();
        for (int i = 0; i < 9; i++) {
            System.out.print(" " + board[i]);
            if (i % 3 != 2) System.out.print(" |");
            if (i % 3 == 2 && i != 8) System.out.println("\n---|---|---");
        }
        System.out.println("\n");
    }

    private static void humanMove() {
        Scanner scanner = new Scanner(System.in);
        int move;
        while (true) {
            System.out.print("Enter your move (1-9): ");
            move = scanner.nextInt() - 1;
            if (move >= 0 && move < 9 && board[move] != HUMAN && board[move] != COMPUTER) {
                board[move] = HUMAN;
                break;
            } else {
                System.out.println("This move is not valid.");
            }
        }
    }

    private static void computerMove() {
        int bestMove = -1;
        int bestValue = Integer.MIN_VALUE;

        for (int i = 0; i < 9; i++) {
            if (board[i] != HUMAN && board[i] != COMPUTER) {
                board[i] = COMPUTER;
                int moveValue = minimax(0, false);
                board[i] = (char) ('1' + i); // Reset to index after checking
                if (moveValue > bestValue) {
                    bestMove = i;
                    bestValue = moveValue;
                }   
            }
        }
        board[bestMove] = COMPUTER;
    }

    private static int minimax(int depth, boolean isMaximizing) {
        if (checkWinner(COMPUTER)) {
            return 10 - depth;
        }
        if (checkWinner(HUMAN)) {
            return depth - 10;
        }
        if (checkDraw()) {
            return 0;
        }

        if (isMaximizing) {
            int bestValue = Integer.MIN_VALUE;
            for (int i = 0; i < 9; i++) {
                if (board[i] != HUMAN && board[i] != COMPUTER) {
                    board[i] = COMPUTER;
                    bestValue = Math.max(bestValue, minimax(depth + 1, false));
                    board[i] = (char) ('1' + i); // Reset to index after checking
                }
            }
            return bestValue;
        } else {
            int bestValue = Integer.MAX_VALUE;
            for (int i = 0; i < 9; i++) {
                if (board[i] != HUMAN && board[i] != COMPUTER) {
                    board[i] = HUMAN;
                    bestValue = Math.min(bestValue, minimax(depth + 1, true));
                    board[i] = (char) ('1' + i); // Reset to index after checking
                }
            }
            return bestValue;
        }
    }

    private static boolean checkWinner(char player) {
        return (board[0] == player && board[1] == player && board[2] == player) ||
                (board[3] == player && board[4] == player && board[5] == player) ||
                (board[6] == player && board[7] == player && board[8] == player) ||
                (board[0] == player && board[3] == player && board[6] == player) ||
                (board[1] == player && board[4] == player && board[7] == player) ||
                (board[2] == player && board[5] == player && board[8] == player) ||
                (board[0] == player && board[4] == player && board[8] == player) ||
                (board[2] == player && board[4] == player && board[6] == player);
    }

    private static boolean checkDraw() {
        for (char c : board) {
            if (c != HUMAN && c != COMPUTER) {
                return false;
            }
        }
        return true;
    }
}

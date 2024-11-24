import java.util.Random;
import java.util.Scanner;

public class TicTacToe {
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
            board[i] = (char) (i + '1');
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
        Random rand = new Random();
        int move;
        while (true) {
            move = rand.nextInt(9);
            if (board[move] != HUMAN && board[move] != COMPUTER) {
                board[move] = COMPUTER;
                break;
            }
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
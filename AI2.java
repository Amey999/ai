import java.util.*;//TTTMinMax

public class TicTacToe {
    static char[] board = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9'};
    static char player = 'X';
    static char computer = 'O';

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Welcome to Tic Tac Toe!");
        System.out.print("Do you want to play first? (y/n): ");
        String choice = scanner.nextLine().trim().toLowerCase();

        boolean isPlayerTurn = choice.equals("y");

        displayBoard();

        while (true) {
            if (isPlayerTurn) {
                playerMove(scanner);
                if (isWinner(player)) {
                    displayBoard();
                    System.out.println("You win!");
                    break;
                }
                if (isDraw()) {
                    displayBoard();
                    System.out.println("It's a draw!");
                    break;
                }
                isPlayerTurn = false;
            } else {
                computerMove();
                if (isWinner(computer)) {
                    displayBoard();
                    System.out.println("Computer wins!");
                    break;
                }
                if (isDraw()) {
                    displayBoard();
                    System.out.println("It's a draw!");
                    break;
                }
                isPlayerTurn = true;
            }
        }
    }

    static void displayBoard() {
        System.out.println("\nCurrent Board:");
        System.out.println(" " + board[1] + " | " + board[2] + " | " + board[3]);
        System.out.println("---|---|---");
        System.out.println(" " + board[4] + " | " + board[5] + " | " + board[6]);
        System.out.println("---|---|---");
        System.out.println(" " + board[7] + " | " + board[8] + " | " + board[9]);
    }

    static void playerMove(Scanner scanner) {
        int move;
        while (true) {
            System.out.println("Enter your move (1-9): ");
            move = scanner.nextInt();
            if (move >= 1 && move <= 9 && board[move] != player && board[move] != computer) {
                board[move] = player;
                break;
            }
            System.out.println("Invalid move. Try again.");
        }
        displayBoard();
    }

    static void computerMove() {
        int bestMove = -1;
        int bestValue = Integer.MIN_VALUE;

        for (int i = 1; i <= 9; i++) {
            if (board[i] != player && board[i] != computer) {
                char original = board[i];
                board[i] = computer;
                int moveValue = minimax(false);
                board[i] = original;

                if (moveValue > bestValue) {
                    bestValue = moveValue;
                    bestMove = i;
                }
            }
        }
        board[bestMove] = computer;
        System.out.println("Computer chose position: " + bestMove);
        displayBoard();
    }

    static int minimax(boolean isMaximizing) {
        if (isWinner(computer)) return 10;
        if (isWinner(player)) return -10;
        if (isDraw()) return 0;

        if (isMaximizing) {
            int maxEval = Integer.MIN_VALUE;
            for (int i = 1; i <= 9; i++) {
                if (board[i] != player && board[i] != computer) {
                    char original = board[i];
                    board[i] = computer;
                    int eval = minimax(false);
                    board[i] = original;
                    maxEval = Math.max(maxEval, eval);
                }
            }
            return maxEval;
        } else {
            int minEval = Integer.MAX_VALUE;
            for (int i = 1; i <= 9; i++) {
                if (board[i] != player && board[i] != computer) {
                    char original = board[i];
                    board[i] = player;
                    int eval = minimax(true);
                    board[i] = original;
                    minEval = Math.min(minEval, eval);
                }
            }
            return minEval;
        }
    }

    static boolean isWinner(char ch) {
        return (board[1] == ch && board[2] == ch && board[3] == ch) ||
               (board[4] == ch && board[5] == ch && board[6] == ch) ||
               (board[7] == ch && board[8] == ch && board[9] == ch) ||
               (board[1] == ch && board[4] == ch && board[7] == ch) ||
               (board[2] == ch && board[5] == ch && board[8] == ch) ||
               (board[3] == ch && board[6] == ch && board[9] == ch) ||
               (board[1] == ch && board[5] == ch && board[9] == ch) ||
               (board[3] == ch && board[5] == ch && board[7] == ch);
    }

    static boolean isDraw() {
        for (int i = 1; i <= 9; i++) {
            if (board[i] != player && board[i] != computer) {
                return false;
            }
        }
        return true;
    }
}
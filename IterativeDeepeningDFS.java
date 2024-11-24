import java.util.Scanner;

public class IterativeDeepeningDFS {
    private int[][] adjacencyMatrix;
    private int numberOfVertices;

    public IterativeDeepeningDFS(int[][] adjacencyMatrix) {
        this.adjacencyMatrix = adjacencyMatrix;
        this.numberOfVertices = adjacencyMatrix.length; // Count vertices starting from 0
    }

    public void performIDDFS(int startVertex, int targetVertex) {
        for (int depth = 0; depth < numberOfVertices; depth++) {
            boolean[] visited = new boolean[numberOfVertices];
            System.out.println("Searching at depth: " + depth);
            boolean found = depthLimitedDFS(startVertex, targetVertex, depth, visited, 0);

            if (found) {
                System.out.println("Target vertex " + targetVertex + " found.");
                return;
            }
        }
        System.out.println("Target vertex " + targetVertex + " not found within the maximum depth.");
    }

    private boolean depthLimitedDFS(int currentVertex, int targetVertex, int depthLimit, boolean[] visited, int currentDepth) {
        System.out.println("Checking vertex " + currentVertex + " at depth " + currentDepth);
        if (currentVertex == targetVertex) {
            return true;
        }
        if (currentDepth >= depthLimit) {
            return false;
        }
        visited[currentVertex] = true;

        for (int i = 0; i < numberOfVertices; i++) { // Iterate from 0 to numberOfVertices
            if (adjacencyMatrix[currentVertex][i] == 1 && !visited[i]) {
                System.out.println("Moving to vertex " + i);
                if (depthLimitedDFS(i, targetVertex, depthLimit, visited, currentDepth + 1)) {
                    return true;
                }
            }
        }
        return false;
    }

    public static void main(String[] args) {
        int[][] adjacencyMatrix = {
                { 0, 1, 1, 0, 0, 0, 0, 0, 0, 0 }, // A (0) connected to B (1), C (2)
                { 1, 0, 0, 1, 1, 0, 0, 0, 0, 0 }, // B (1) connected to A (0), D (3), E (4)
                { 1, 0, 0, 0, 0, 1, 1, 0, 0, 0 }, // C (2) connected to A (0), F (5), G (6)
                { 0, 1, 0, 0, 0, 0, 0, 1, 0, 0 }, // D (3) connected to B (1), H (7)
                { 0, 1, 0, 0, 0, 0, 0, 0, 1, 0 }, // E (4) connected to B (1), I (8)
                { 0, 0, 1, 0, 0, 0, 0, 0, 0, 1 }, // F (5) connected to C (2), J (9)
                { 0, 0, 1, 0, 0, 0, 0, 0, 0, 0 }, // G (6) connected to C (2)
                { 0, 0, 0, 1, 0, 0, 0, 0, 0, 0 }, // H (7) connected to D (3)
                { 0, 0, 0, 0, 1, 0, 0, 0, 0, 0 }, // I (8) connected to E (4)
                { 0, 0, 0, 0, 0, 1, 0, 0, 0, 0 }  // J (9) connected to F (5)
        };

        IterativeDeepeningDFS iddfs = new IterativeDeepeningDFS(adjacencyMatrix);
        int startVertex;
        int targetVertex;

        Scanner sc = new Scanner(System.in);
        System.out.println("Please enter the start vertex (0-based index): ");
        startVertex = sc.nextInt();
        System.out.println("Please enter the target vertex (0-based index): ");
        targetVertex = sc.nextInt();

        iddfs.performIDDFS(startVertex, targetVertex);
        sc.close();
    }
}
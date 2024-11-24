import java.util.*;

class Node implements Comparable<Node> {
    char name;
    List<Edge> neighbors;
    int distance;
    int heuristic;

    public Node(char name) {
        this.name = name;
        this.neighbors = new ArrayList<>();
        this.distance = Integer.MAX_VALUE;
        this.heuristic = 0;
    }

    public void addNeighbor(Node neighbor, int cost) {
        Edge edge = new Edge(this, neighbor, cost);
        neighbors.add(edge);
    }

    @Override
    public int compareTo(Node other) {
        return Integer.compare(this.distance + this.heuristic, other.distance + other.heuristic);
    }
}

class Edge {
    Node source;
    Node target;
    int cost;

    public Edge(Node source, Node target, int cost) {
        this.source = source;
        this.target = target;
        this.cost = cost;
    }
}

public class A {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        System.out.print("Enter the number of nodes: ");
        int numberOfNodes = sc.nextInt();
        sc.nextLine();

        Map<Character, Node> nodes = new HashMap<>();

        for (int i = 0; i < numberOfNodes; i++) {
            System.out.print("Enter node name: ");
            char nodeName = sc.nextLine().charAt(0);
            nodes.put(nodeName, new Node(nodeName));
        }

        System.out.print("\n\nEnter the number of edges: ");
        int numberOfEdges = sc.nextInt();
        sc.nextLine();

        for (int i = 0; i < numberOfEdges; i++) {
            System.out.print("Enter edge (source target cost) (e.g., A B 1): ");
            String[] edgeInput = sc.nextLine().split(" ");
            char sourceName = edgeInput[0].charAt(0);
            char targetName = edgeInput[1].charAt(0);
            int cost = Integer.parseInt(edgeInput[2]);
            Node sourceNode = nodes.get(sourceName);
            Node targetNode = nodes.get(targetName);
            sourceNode.addNeighbor(targetNode, cost);
        }

        System.out.print("\n\nEnter the start node: ");
        char start = sc.next().charAt(0);
        System.out.print("Enter the goal node: ");
        char goal = sc.next().charAt(0);

        System.out.println("\n");
        for (char nodeName : nodes.keySet()) {
            System.out.print("Enter straight-line distance for node " + nodeName + ": ");
            nodes.get(nodeName).heuristic = sc.nextInt();
        }

        Node startNode = nodes.get(start);
        Node goalNode = nodes.get(goal);

        aStarSearch(startNode, goalNode);
    }

    public static void aStarSearch(Node start, Node goal) {
        PriorityQueue<Node> traversal = new PriorityQueue<>();//determined by the total cost(distance+heuristic).
        Map<Node, Node> prev = new HashMap<>();//stores the previous node for each node.
        Set<Node> visited = new HashSet<>();//keeps track of visited nodes.

        start.distance = 0;
        traversal.add(start);

        System.out.println("\n");
        while (!traversal.isEmpty()) {
            Node current = traversal.poll();
            System.out.println("Visiting node: " + current.name + "\tDistance traversed: " + current.distance + "\tStraight-line distance: " + current.heuristic);

            if (current.equals(goal)) {
                System.out.println("\n\nGoal node reached: " + current.name + "\nTotal distance traversed: " + current.distance);
                printPath(goal, prev);
                return;
            }

            visited.add(current);

            for (Edge edge : current.neighbors) {
                Node neighbor = edge.target;
                int tempDist = current.distance + edge.cost;

                if (!visited.contains(neighbor) && tempDist < neighbor.distance) {
                    neighbor.distance = tempDist;
                    prev.put(neighbor, current);

                    if (!traversal.contains(neighbor)) {
                        traversal.add(neighbor);
                    } else {
                        traversal.remove(neighbor);
                        traversal.add(neighbor);
                    }
                }
            }
        }

        System.out.println("Goal node not reachable");
    }

    public static void printPath(Node goal, Map<Node, Node> prev) {
        List<Node> path = new ArrayList<>();
        Node current = goal;
        while (current != null) {
            path.add(current);
            current = prev.get(current);
        }
        Collections.reverse(path);
        System.out.print("Path: ");
        for (Node node : path) {
            System.out.print(node.name + " ");
        }
        System.out.println();
    }
}


// import java.util.*;

// class Node implements Comparable<Node> {
//     char name;
//     List<Edge> neighbors = new ArrayList<>();
//     int distance = Integer.MAX_VALUE; // Initialize to infinity
//     int heuristic = 0;

//     public Node(char name) {
//         this.name = name;
//     }

//     public void addNeighbor(Node neighbor, int cost) {
//         neighbors.add(new Edge(neighbor, cost));
//     }

//     @Override
//     public int compareTo(Node other) {
//         return Integer.compare(this.distance + this.heuristic, other.distance + other.heuristic);
//     }
// }

// class Edge {
//     Node target;
//     int cost;

//     public Edge(Node target, int cost) {
//         this.target = target;
//         this.cost = cost;
//     }
// }

// public class AStarSearch {
//     public static void main(String[] args) {
//         // Define nodes
//         Map<Character, Node> nodes = new HashMap<>();
//         for (char name : new char[]{'S', 'A', 'B', 'C', 'D', 'G'}) {
//             nodes.put(name, new Node(name));
//         }

//         // Define edges
//         nodes.get('S').addNeighbor(nodes.get('A'), 1);
//         nodes.get('S').addNeighbor(nodes.get('G'), 10);
//         nodes.get('A').addNeighbor(nodes.get('C'), 1);
//         nodes.get('A').addNeighbor(nodes.get('B'), 2);
//         nodes.get('B').addNeighbor(nodes.get('D'), 5);
//         nodes.get('C').addNeighbor(nodes.get('D'), 3);
//         nodes.get('C').addNeighbor(nodes.get('G'), 4);
//         nodes.get('D').addNeighbor(nodes.get('G'), 2);

//         // Define heuristics
//         nodes.get('S').heuristic = 5;
//         nodes.get('A').heuristic = 3;
//         nodes.get('B').heuristic = 4;
//         nodes.get('C').heuristic = 2;
//         nodes.get('D').heuristic = 6;
//         nodes.get('G').heuristic = 0;

//         // Start and goal nodes
//         Node start = nodes.get('S');
//         Node goal = nodes.get('G');

//         // Run A* Search
//         aStarSearch(start, goal);
//     }

//     public static void aStarSearch(Node start, Node goal) {
//         PriorityQueue<Node> pq = new PriorityQueue<>();
//         Map<Node, Node> prev = new HashMap<>();
//         Set<Node> visited = new HashSet<>();

//         start.distance = 0;
//         pq.add(start);

//         while (!pq.isEmpty()) {
//             Node current = pq.poll();
//             if (visited.contains(current)) continue;
//             visited.add(current);

//             System.out.println("Visiting node: " + current.name + "\tDistance traversed: " + current.distance + "\tStraight-line distance: " + current.heuristic);

//             if (current.equals(goal)) {
//                 printPath(goal, prev);
//                 return;
//             }

//             for (Edge edge : current.neighbors) {
//                 Node neighbor = edge.target;
//                 int newDist = current.distance + edge.cost;

//                 if (newDist < neighbor.distance && !visited.contains(neighbor)) {
//                     neighbor.distance = newDist;
//                     prev.put(neighbor, current);
//                     pq.add(neighbor);
//                 }
//             }
//         }
//         System.out.println("Goal not reachable");
//     }

//     private static void printPath(Node goal, Map<Node, Node> prev) {
//         List<Character> path = new ArrayList<>();
//         for (Node at = goal; at != null; at = prev.get(at)) {
//             path.add(at.name);
//         }
//         Collections.reverse(path);
//         System.out.println("\nGoal node reached: " + goal.name);
//         System.out.println("Total distance traversed: " + goal.distance);
//         System.out.println("Path: " + String.join(" -> ", path.stream().map(String::valueOf).toArray(String[]::new)));
//     }
// }

import java.util.*;

class BestFirstSearch {
    static class Node implements Comparable<Node> {
        String name;
        int heuristic;

        Node(String name, int heuristic) {
            this.name = name;
            this.heuristic = heuristic;
        }

        @Override
        public int compareTo(Node other) {
            return Integer.compare(this.heuristic, other.heuristic);
        }
    }

    static class Graph {
        private final List<Edge> edges = new ArrayList<>();

        static class Edge {
            String from, to;
            int heuristic;

            Edge(String from, String to, int heuristic) {
                this.from = from;
                this.to = to;
                this.heuristic = heuristic;
            }
        }

        void addEdge(String from, String to, int heuristic) {
            edges.add(new Edge(from, to, heuristic));
        }

        void bestFirstSearch(String start, String goal) {
            PriorityQueue<Node> pq = new PriorityQueue<>();
            Set<String> visited = new HashSet<>();

            pq.add(new Node(start, 0));

            System.out.println("Path followed:");
            while (!pq.isEmpty()) {
                Node current = pq.poll();

                if (!visited.add(current.name)) {
                    continue; // Skip already visited nodes
                }

                System.out.println(current.name);

                if (current.name.equals(goal)) {
                    System.out.println("Goal reached!");
                    return;
                }

                for (Edge edge : edges) {
                    if (edge.from.equals(current.name) && !visited.contains(edge.to)) {
                        pq.add(new Node(edge.to, edge.heuristic));
                    }
                }
            }
            System.out.println("Goal not reachable.");
        }
    }

    public static void main(String[] args) {
        Graph graph = new Graph();

        // Example graph with heuristic values
        graph.addEdge("A", "B", 1);
        graph.addEdge("A", "C", 3);
        graph.addEdge("B", "D", 4);
        graph.addEdge("B", "E", 2);
        graph.addEdge("C", "F", 5);
        graph.addEdge("E", "G", 1);

        // Perform Best First Search from A to G
        graph.bestFirstSearch("A", "G");
    }
}

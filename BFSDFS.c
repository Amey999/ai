#include <stdio.h>
#include <stdlib.h>
int queue[7];
int front = -1;
int rear = -1;
int i;
int visited[7] = {0, 0, 0, 0, 0, 0, 0};
int a[7][7] = {
    {0, 1, 0, 1, 0, 0, 0},
    {1, 0, 1, 0, 0, 1, 1},
    {0, 1, 0, 1, 0, 1, 0},
    {1, 0, 1, 0, 1, 0, 0},
    {0, 0, 0, 1, 0, 0, 1},
    {0, 1, 1, 0, 0, 0, 0},
    {0, 0, 0, 0, 1, 0, 0},
};


void BFS(int a[7][7], int startVertex)
{


    int visited[7];
    for (int i = 0; i < 7; i++)
    {
        visited[i] = 0;
    }
    // insert the start vertex in the queue first
    rear++;
    queue[rear] = startVertex;
    // mark the startVertex as visited
    visited[startVertex] = 1;


    // When front equals rear, it means that
    // all vertices that were added to the queue have been processed,
    // and the queue is effectively empty
    while (front < rear)
    {
        int i;
        int current;
        front++;
        current = queue[front];
        printf("%d ", current);


        for (i = 0; i < 7; i++)
        {
            if (a[current][i] == 1 && visited[i] == 0)
            {
                rear++;
                queue[rear] = i;
                visited[i] = 1;
            }
        }
    }
    // check if the it is not visited if not then insert in the queue
}
void DFS(int i)
{


    printf("%d ", i);
    visited[i] = 1;
    for (int j = 0; j < 7; j++)
    {
        if (a[i][j] == 1 && !visited[j])
        {
            DFS(j);
        }
    }
}
int main()
{
    printf("Enter the start vertex for DFS: ");
    int STV;
    scanf("%d", &STV);
    DFS(STV);


    printf("\nenter the startvertex for BFS: ");
    int stv;
    scanf("%d", &stv);
    BFS(a, stv);
    return 0;
}



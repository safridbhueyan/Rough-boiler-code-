def is_safe(position, row, col):
    for r in range(row):
        c = position[r]
        if c == col or abs(c - col) == abs(r - row):
            return False
    return True

def solve_n_queens_dfs(n):
    def dfs(row, position):
        if row == n:
            solutions.append(position[:])
            return
        for col in range(n):
            if is_safe(position, row, col):
                position[row] = col
                dfs(row + 1, position)

    solutions = []
    dfs(0, [-1] * n)
    return solutions
from collections import deque

def is_safe_bfs(state, row, col):
    for r in range(row):
        c = state[r]
        if c == col or abs(c - col) == abs(r - row):
            return False
    return True



//========================================================================================================================



def solve_n_queens_bfs(n):
    queue = deque()
    queue.append((0, []))  # (row, current_state)
    solutions = []

    while queue:
        row, state = queue.popleft()
        if row == n:
            solutions.append(state)
            continue
        for col in range(n):
            if is_safe_bfs(state, row, col):
                queue.append((row + 1, state + [col]))

    return solutions

func satisfyBoard (board : [[Int]], row : Int, column : Int, num : Int) -> Bool{
    if board[row].contains(num) {return false}

    for row in board {if row[column] == num {return false}}
    
    let boxRow = (row / 3) * 3
    let boxCol = (column / 3) * 3
    
    if board[boxRow][boxCol...boxCol + 2].contains(num) || board[boxRow + 1][boxCol...boxCol + 2].contains(num) || board[boxRow + 2][boxCol...boxCol + 2].contains(num) {return false}
    
    return true
}

func boardFull (board : [[Int]]) -> Bool {
    for row in board {if row.contains(0) {return false}}
    return true
}

func solveBoard (board : [[Int]]) -> [[Int]]{
    var newBoard = board
    for rNum in 0...8 {
        for cNum in 0...8 {
            if newBoard[rNum][cNum] == 0 {
                for num in 1...9 {
                    if satisfyBoard(board: newBoard, row: rNum, column: cNum, num: num) {
                        newBoard[rNum][cNum] = num
                        newBoard = solveBoard(board: newBoard)
                        if boardFull(board: newBoard) {break}
                        newBoard[rNum][cNum] = 0
                    }
                }
                return newBoard
            }
        }
    }
    return newBoard
}

var board = [ // Edit this list
    [0, 0, 0, 3, 0, 0, 8, 0, 7],
    [0, 0, 8, 0, 0, 0, 9, 0, 0],
    [0, 2, 0, 1, 0, 0, 0, 4, 0],
    [0, 1, 0, 5, 0, 0, 0, 0, 0],
    [5, 0, 9, 7, 0, 8, 3, 0, 1],
    [0, 0, 0, 0, 0, 6, 0, 7, 0],
    [0, 5, 0, 0, 0, 7, 0, 8, 0],
    [0, 0, 3, 0, 0, 0, 2, 0, 0],
    [1, 0, 6, 0, 0, 2, 0, 0, 0],
]

var answer = solveBoard(board: board)
for row in answer {print(row)}


func satisfyBoard (board: [[Int]], num : Int, rowIndex : Int, colIndex : Int) -> Bool {
    if board[rowIndex].contains(num) {
        return false
    }
    for row in board {
        if row[colIndex] == num {
            return false
        }
    }
    return true
}

func boardFull (board: [[Int]]) -> Bool {
    for row in board {
        for val in row {
            if val == 0 {
                return false
            }
        }
    }
    return true
}

func solveBoard (board: [[Int]]) -> ([[Int]], Bool){
    var newBoard = board
    if boardFull(board: newBoard) {
        return (newBoard, true)
    }
    var rowIndex = 0
    
    var value = 0
    while rowIndex < newBoard.count {
        var colIndex = 0
        var row = newBoard[rowIndex]
        while colIndex < row.count {
            value = row[colIndex]
            if value == 0 {
                for n in 1...9 {
                    if satisfyBoard(board: newBoard, num: n, rowIndex: rowIndex, colIndex: colIndex) {
                        row[colIndex] = n
                        newBoard[rowIndex] = row
                        let status = solveBoard(board: newBoard)
                        if status.1 {
                            newBoard = status.0
                            return (newBoard, true)
                        }
                        else {
                            continue
                        }
                    }
                    else if n == 9{
                        return (newBoard, false)
                    }
                }
            }
            colIndex += 1
        }
        rowIndex += 1
    }
    return (newBoard, true)
}

var board = [ // Edit this list
    [1, 0, 0, 4, 8, 9, 0, 0, 6],
    [7, 3, 0, 0, 0, 0, 0, 4, 0],
    [0, 0, 0, 0, 0, 1, 2, 9, 5],
    [0, 0, 7, 1, 2, 0, 6, 0, 0],
    [5, 0, 0, 7, 0, 3, 0, 0, 8],
    [0, 0, 6, 0, 9, 5, 7, 0, 0],
    [9, 1, 4, 6, 0, 0, 0, 0, 0],
    [0, 2, 0, 0, 0, 0, 0, 3, 7],
    [8, 0, 0, 5, 1, 2, 0, 0, 4],
]

var answer = solveBoard(board: board)
var newAnswer = answer.0
for row in newAnswer {
    print(row)
}

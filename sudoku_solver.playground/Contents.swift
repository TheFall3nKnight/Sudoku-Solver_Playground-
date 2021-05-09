func makeBoxes (board: [[Int]]) -> [[Int]] {
    var boxes = [[Int]]()
    var box1 = [Int]()
    var box2 = [Int]()
    var box3 = [Int]()
    var index = 0
    for row in board {
        if index % 3 == 0 && index != 0{
            boxes.append(box1);boxes.append(box2);boxes.append(box3)
            box1 = [Int]()
            box2 = [Int]()
            box3 = [Int]()
        }
        box1 += row[0...2]
        box2 += row[3...5]
        box3 += row[6...8]
        index += 1
        if index == 9 {
            boxes.append(box1);boxes.append(box2);boxes.append(box3)
        }
        
    }
    return boxes
}


func satisfyBoard (board: [[Int]], num : Int, rowIndex : Int, colIndex : Int) -> Bool {
    if board[rowIndex].contains(num) {
        return false
    }
    for row in board {
        if row[colIndex] == num {
            return false
        }
    }
    var boxNum = 0
    if 0 <= rowIndex && rowIndex <= 2 {
        if 0 <= colIndex && colIndex <= 2 {
            boxNum = 0
        }
        else if 3 <= colIndex && colIndex <= 5 {
            boxNum = 1
        }
        else if 6 <= colIndex && colIndex <= 8 {
            boxNum = 2
        }
    }
    else if 3 <= rowIndex && rowIndex <= 5 {
        if 0 <= colIndex && colIndex <= 2 {
            boxNum = 3
        }
        else if 3 <= colIndex && colIndex <= 5 {
            boxNum = 4
        }
        else if 6 <= colIndex && colIndex <= 8 {
            boxNum = 5
        }
    }
    else if 6 <= rowIndex && rowIndex <= 8 {
        if 0 <= colIndex && colIndex <= 2 {
            boxNum = 6
        }
        else if 3 <= colIndex && colIndex <= 5 {
            boxNum = 7
        }
        else if 6 <= colIndex && colIndex <= 8 {
            boxNum = 8
        }
    }
    let boxes = makeBoxes(board: board)
    if boxes[boxNum].contains(num) {
        return false
    }
    return true
}

func boardFull (board: [[Int]]) -> Bool {
    for row in board {
        if row.contains(0) {return false}
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
                        print(row)
                        print("----------------")
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
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
]

var answer = solveBoard(board: board)
var newAnswer = answer.0
if !boardFull(board: newAnswer) {
    print("No Solution")
}
for row in newAnswer {
    print(row)
}

//
//  PvAIGameController.swift
//  FinalProgcat0050Su19
//
//  Created by Christopher Tillery on 7/17/19.
//  Copyright © 2019 Christopher Tillery. All rights reserved.
//

import UIKit
import AVFoundation

class PvAIGameController: UIViewController {
    
    var board = ["", "", "", "", "", "", "", "", ""]
    var boardTemp = ["", "", "", "", "", "", "", "", ""]
    var pairs = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
    var AIDifficulty = "Easy"
    var unbeatableMode = UserDefaults.standard.bool(forKey: "unbeatableMode")
    var imageMode = UserDefaults.standard.integer(forKey: "pickerRow")
    var currentVolume = UserDefaults.standard.integer(forKey: "currentVolume")
    var gameStatus = 0
    var copyStatus = 0
    var P1WinCount = 0, AIWinCount = 0, P1LossCount = 0, AILossCount = 0, P1TieCount = 0, AITieCount = 0
    var xImage = UIImage(named: "X")
    var oImage = UIImage(named: "O")

    @IBOutlet weak var cell1Button: UIButton!
    @IBOutlet weak var cell2Button: UIButton!
    @IBOutlet weak var cell3Button: UIButton!
    @IBOutlet weak var cell4Button: UIButton!
    @IBOutlet weak var cell5Button: UIButton!
    @IBOutlet weak var cell6Button: UIButton!
    @IBOutlet weak var cell7Button: UIButton!
    @IBOutlet weak var cell8Button: UIButton!
    @IBOutlet weak var cell9Button: UIButton!
    @IBOutlet weak var P1Win: UILabel!
    @IBOutlet weak var P1Loss: UILabel!
    @IBOutlet weak var P1Tie: UILabel!
    @IBOutlet weak var AIWin: UILabel!
    @IBOutlet weak var AILoss: UILabel!
    @IBOutlet weak var AITie: UILabel!
    
    @IBAction func resetBoard(_ sender: UIBarButtonItem) {
        resetGame()
        P1WinCount = 0
        AIWinCount = 0
        P1LossCount = 0
        AILossCount = 0
        P1TieCount = 0
        AITieCount = 0
        P1Win.text = "Win: "
        P1Loss.text = "Loss: "
        P1Tie.text = "Tie: "
        AIWin.text = "Win: "
        AILoss.text = "Loss: "
        AITie.text = "Tie: "
        reloadSettings()
        executeAITurn()
    }
    
    @IBAction func cell1(_ sender: UIButton) {
        cell1Button.setImage(xImage, for: .normal)
        cell1Button.isEnabled = false
        board[0] = "X"
        executeAITurn()
    }
    
    @IBAction func cell2(_ sender: UIButton) {
        cell2Button.setImage(xImage, for: .normal)
        cell2Button.isEnabled = false
        board[1] = "X"
        playSound()
        executeAITurn()
    }
    
    @IBAction func cell3(_ sender: UIButton) {
        cell3Button.setImage(xImage, for: .normal)
        cell3Button.isEnabled = false
        board[2] = "X"
        playSound()
        executeAITurn()
    }
    
    @IBAction func cell4(_ sender: UIButton) {
        cell4Button.setImage(xImage, for: .normal)
        cell4Button.isEnabled = false
        board[3] = "X"
        playSound()
        executeAITurn()
    }
    
    @IBAction func cell5(_ sender: UIButton) {
        cell5Button.setImage(xImage, for: .normal)
        cell5Button.isEnabled = false
        board[4] = "X"
        playSound()
        executeAITurn()
    }
    
    @IBAction func cell6(_ sender: UIButton) {
        cell6Button.setImage(xImage, for: .normal)
        cell6Button.isEnabled = false
        board[5] = "X"
        playSound()
        executeAITurn()
    }
    
    @IBAction func cell7(_ sender: UIButton) {
        cell7Button.setImage(xImage, for: .normal)
        cell7Button.isEnabled = false
        board[6] = "X"
        playSound()
        executeAITurn()
    }
    
    @IBAction func cell8(_ sender: UIButton) {
        cell8Button.setImage(xImage, for: .normal)
        cell8Button.isEnabled = false
        board[7] = "X"
        playSound()
        executeAITurn()
    }

    @IBAction func cell9(_ sender: UIButton) {
        cell9Button.setImage(xImage, for: .normal)
        cell9Button.isEnabled = false
        board[8] = "X"
        playSound()
        executeAITurn()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if imageMode == 2 {
            xImage = UIImage(named: "dot")
            oImage = UIImage(named: "circle")
        }
        else if imageMode == 1 {
            xImage = UIImage(named: "plus")
            oImage = UIImage(named: "minus")
        }
        if UserDefaults.standard.string(forKey: "difficulty") != nil {
            AIDifficulty = UserDefaults.standard.string(forKey: "difficulty")!
        }
        else {
            UserDefaults.standard.set(AIDifficulty, forKey: "difficulty")
            UserDefaults.standard.synchronize()
        }
        executeAITurn()
    }
    
    func executeAITurn() {
        if unbeatableMode {
            let turn = searchPossibleMoves()
            if turn >= 0 {
                board[turn] = "O"
                printToBoard(node: turn)
            }
        }
        else if percentageChance() {
            let turn = searchPossibleMoves()
            if turn >= 0 {
                board[turn] = "O"
                printToBoard(node: turn)
            }
        }
        else {
            chooseRandomFirstNode()
        }
        gameStatus = checkWinCondition(boardCopy: board, copyStatus: copyStatus)
        if gameStatus != 0 {
            disableButtons()
            switch gameStatus {
            case -1:
                P1WinCount = P1WinCount + 1
                P1Win.text = "Win: " + String(P1WinCount)
                AILossCount = AILossCount + 1
                AILoss.text = "Loss: " + String(AILossCount)
                break
            case 1:
                AIWinCount = AIWinCount + 1
                AIWin.text = "Win: " + String(AIWinCount)
                P1LossCount = P1LossCount + 1
                P1Loss.text = "Loss: " + String(P1LossCount)
                break
            case 2:
                P1TieCount = P1TieCount + 1
                P1Tie.text = "Tie: " + String(P1TieCount)
                AITieCount = AITieCount + 1
                AITie.text = "Tie: " + String(AITieCount)
                break
            default: break
            }
            displayCompletionAlert(winner: gameStatus)
        }
    }
    
    func searchPossibleMoves() -> Int {
        return spanBoard(boardCopy: board, depth: 0, type: "O")[1]
    }
    
    func spanBoard(boardCopy: [String], depth: Int, type: String) -> [Int] {
        var bestMove = -1
        var score = 0, bestScore = 0
        
        if unbeatableMode == true && board[4] == "" {
            return [0, 4]
        }
        else if !board.contains("O") || !board.contains("X") {
            return [0, Int(arc4random_uniform(9))]
        }
        
        let moves = getAllMoves(boardCopy: boardCopy)
        copyStatus = checkWinCondition(boardCopy: boardCopy, copyStatus: copyStatus)
        if type == "O" {
            bestScore = Int.min
        }
        else {
            bestScore = Int.max
        }
        if copyStatus != 0 || moves.count == 0 {
            return scoreKeeper(depth: depth, bestMove: bestMove, copyStatus: copyStatus)
        }
        
        for move in moves {
            var newBoard = boardCopy
            newBoard[move] = type
            if type == "O" {
                score = spanBoard(boardCopy: newBoard, depth: depth + 1, type: "X")[0]
                if score > bestScore {
                    bestScore = score
                    bestMove = move
                }
            }
            else {
                score = spanBoard(boardCopy: newBoard, depth: depth + 1, type: "O")[0]
                if score < bestScore {
                    bestScore = score
                    bestMove = move
                }
            }
        }
        
        return [bestScore, bestMove]
    }
    
    func scoreKeeper(depth: Int, bestMove: Int, copyStatus: Int) -> [Int] {
        if copyStatus == -1 {
            return [depth - 10, bestMove]
        }
        else if copyStatus == 1 {
            return [-depth + 10, bestMove]
        }
        else {
            return [0, bestMove]
        }
    }
    
    func getAllMoves(boardCopy: [String]) -> [Int] {
        var allMoves = [Int]()
        for node in 0...8 {
            if boardCopy[node] == "" {
               allMoves.append(node)
            }
        }
        return allMoves
    }

    func checkWinCondition(boardCopy: [String], copyStatus: Int) -> Int {
        for pair in pairs {
            if boardCopy[pair[0]] != "" && boardCopy[pair[0]] == boardCopy[pair[1]] && boardCopy[pair[1]] == boardCopy[pair[2]] {
                if boardCopy[pair[0]] == "X" {
                    return -1
                }
                else {
                    return 1
                }
            }
        }
        if !boardCopy.contains("") {
            return 2
        }
        return 0
    }
    
    func chooseRandomFirstNode() {
        var column = Int(arc4random_uniform(3))
        var row = Int(arc4random_uniform(3))
        while board[(3 * row) + column] == "O" || board[(3 * row) + column] == "X" {
            column = Int(arc4random_uniform(3))
            row = Int(arc4random_uniform(3))
        }
        printToBoard(node: (3 * row) + column)
    }
    
    func percentageChance() -> Bool {
        if AIDifficulty == "Easy" {
            return arc4random_uniform(4) >= 3
        }
        else if AIDifficulty == "Medium" {
            return arc4random_uniform(4) >= 2
        }
        else {
            return arc4random_uniform(4) >= 1
        }
    }
    
    func printToBoard(node: Int) {
        board[node] = "O"
        switch node {
        case 0:
            cell1Button.setImage(oImage, for: .normal)
            cell1Button.isEnabled = false
            break
        case 1:
            cell2Button.setImage(oImage, for: .normal)
            cell2Button.isEnabled = false
            break
        case 2:
            cell3Button.setImage(oImage, for: .normal)
            cell3Button.isEnabled = false
            break
        case 3:
            cell4Button.setImage(oImage, for: .normal)
            cell4Button.isEnabled = false
            break
        case 4:
            cell5Button.setImage(oImage, for: .normal)
            cell5Button.isEnabled = false
            break
        case 5:
            cell6Button.setImage(oImage, for: .normal)
            cell6Button.isEnabled = false
            break
            
        case 6:
            cell7Button.setImage(oImage, for: .normal)
            cell7Button.isEnabled = false
            break
        case 7:
            cell8Button.setImage(oImage, for: .normal)
            cell8Button.isEnabled = false
            break
        case 8:
            cell9Button.setImage(oImage, for: .normal)
            cell9Button.isEnabled = false
            break
        default: break
        }
    }
    
    func disableButtons() {
        cell1Button.isEnabled = false
        cell2Button.isEnabled = false
        cell3Button.isEnabled = false
        cell4Button.isEnabled = false
        cell5Button.isEnabled = false
        cell6Button.isEnabled = false
        cell7Button.isEnabled = false
        cell8Button.isEnabled = false
        cell9Button.isEnabled = false
    }
    
    func displayCompletionAlert(winner: Int) {
        var message = ""
        if winner == -1 {
            message = "Congratulations! You won."
        }
        else if winner == 1 {
            message = "Sorry, you lost. Try again?"
        }
        else {
            message = "You tied. You'll get 'em next time!"
        }
        let completionAlert = UIAlertController(title: "Round Complete", message: message, preferredStyle: UIAlertControllerStyle.alert)
        completionAlert.addAction(UIAlertAction(title: "Play Again", style: .default, handler: nil))
        present(completionAlert, animated: true, completion: {() in self.alertDismissed()})
        completionAlert.addAction(UIAlertAction(title: "Main Menu", style: .cancel, handler: {_ in let menuVC = self.storyboard?.instantiateViewController(withIdentifier: "menuController") as! MenuController
            self.present(menuVC, animated: true, completion: nil)
        }))
    }
    
    func alertDismissed() {
        resetGame()
        executeAITurn()
    }
    
    func resetGame() {
        board = ["", "", "", "", "", "", "", "", ""]
        gameStatus = 0
        copyStatus = 0
        cell1Button.setImage(nil, for: .normal)
        cell2Button.setImage(nil, for: .normal)
        cell3Button.setImage(nil, for: .normal)
        cell4Button.setImage(nil, for: .normal)
        cell5Button.setImage(nil, for: .normal)
        cell6Button.setImage(nil, for: .normal)
        cell7Button.setImage(nil, for: .normal)
        cell8Button.setImage(nil, for: .normal)
        cell9Button.setImage(nil, for: .normal)
        cell1Button.isEnabled = true
        cell2Button.isEnabled = true
        cell3Button.isEnabled = true
        cell4Button.isEnabled = true
        cell5Button.isEnabled = true
        cell6Button.isEnabled = true
        cell7Button.isEnabled = true
        cell8Button.isEnabled = true
        cell9Button.isEnabled = true
        reloadSettings()
    }
    
    func reloadSettings() {
        currentVolume = UserDefaults.standard.integer(forKey: "currentVolume")
        if UserDefaults.standard.string(forKey: "difficulty") != nil {
            AIDifficulty = UserDefaults.standard.string(forKey: "difficulty")!
        }
        else {
            UserDefaults.standard.set(AIDifficulty, forKey: "difficulty")
            UserDefaults.standard.synchronize()
        }
        unbeatableMode = UserDefaults.standard.bool(forKey: "unbeatableMode")
        imageMode = UserDefaults.standard.integer(forKey: "pickerRow")
        if imageMode == 2 {
            xImage = UIImage(named: "dot")
            oImage = UIImage(named: "circle")
        }
        else if imageMode == 1 {
            xImage = UIImage(named: "plus")
            oImage = UIImage(named: "minus")
        }
        else {
            xImage = UIImage(named: "X")
            oImage = UIImage(named: "O")
        }
    }
    
    func playSound() {
        let path = Bundle.main.path(forResource: "scribble.wav", ofType: nil)!
        let url = URL(fileURLWithPath: path)
        do {
            let audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.setVolume(Float(currentVolume), fadeDuration: 0)
            audioPlayer.play()
        } catch {}
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}



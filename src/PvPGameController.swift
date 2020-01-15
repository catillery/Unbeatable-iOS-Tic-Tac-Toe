//
//  PvPGameController.swift
//  FinalProgcat0050Su19
//
//  Created by Christopher Tillery on 7/17/19.
//  Copyright © 2019 Christopher Tillery. All rights reserved.
//

import UIKit
import AVFoundation

class PvPGameController: UIViewController {
    
    var xImage = UIImage(named: "X")
    var oImage = UIImage(named: "O")
    var board = ["", "", "", "", "", "", "", "", ""]
    var pairs = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
    var imageMode = UserDefaults.standard.integer(forKey: "pickerRow")
    var currentVolume = UserDefaults.standard.integer(forKey: "currentVolume")
    var turn = 0
    var gameStatus = 0
    var P1WinCount = 0, AIWinCount = 0, P1LossCount = 0, AILossCount = 0, P1TieCount = 0, AITieCount = 0
    
    @IBOutlet weak var P1Win: UILabel!
    @IBOutlet weak var P1Loss: UILabel!
    @IBOutlet weak var P1Tie: UILabel!
    @IBOutlet weak var AIWin: UILabel!
    @IBOutlet weak var AILoss: UILabel!
    @IBOutlet weak var AITie: UILabel!
    
    @IBOutlet weak var cell1Button: UIButton!
    @IBAction func cell1(_ sender: UIButton) {
        if turn == 0 {
            cell1Button.setImage(xImage, for: .normal)
            cell1Button.isEnabled = false
            board[0] = "X"
            turn = 1
        }
        else if turn == 1 {
            cell1Button.setImage(oImage, for: .normal)
            cell1Button.isEnabled = false
            board[0] = "O"
            turn = 0
        }
        playSound()
        checkGameStatus()
    }
    
    @IBOutlet weak var cell2Button: UIButton!
    @IBAction func cell2(_ sender: UIButton) {
        if turn == 0 {
            cell2Button.setImage(xImage, for: .normal)
            cell2Button.isEnabled = false
            board[1] = "X"
            turn = 1
        }
        else if turn == 1 {
            cell2Button.setImage(oImage, for: .normal)
            cell2Button.isEnabled = false
            board[1] = "O"
            turn = 0
        }
        playSound()
        checkGameStatus()
    }
    
    @IBOutlet weak var cell3Button: UIButton!
    @IBAction func cell3(_ sender: UIButton) {
        if turn == 0 {
            cell3Button.setImage(xImage, for: .normal)
            cell3Button.isEnabled = false
            board[2] = "X"
            turn = 1
        }
        else if turn == 1 {
            cell3Button.setImage(oImage, for: .normal)
            cell3Button.isEnabled = false
            board[2] = "O"
            turn = 0
        }
        playSound()
        checkGameStatus()
    }
    
    @IBOutlet weak var cell4Button: UIButton!
    @IBAction func cell4(_ sender: UIButton) {
        if turn == 0 {
            cell4Button.setImage(xImage, for: .normal)
            cell4Button.isEnabled = false
            board[3] = "X"
            turn = 1
        }
        else if turn == 1 {
            cell4Button.setImage(oImage, for: .normal)
            cell4Button.isEnabled = false
            board[3] = "O"
            turn = 0
        }
        playSound()
        checkGameStatus()
    }

    @IBOutlet weak var cell5Button: UIButton!
    @IBAction func cell5(_ sender: UIButton) {
        if turn == 0 {
            cell5Button.setImage(xImage, for: .normal)
            cell5Button.isEnabled = false
            board[4] = "X"
            turn = 1
        }
        else if turn == 1 {
            cell5Button.setImage(oImage, for: .normal)
            cell5Button.isEnabled = false
            board[4] = "O"
            turn = 0
        }
        playSound()
        checkGameStatus()
    }
    
    @IBOutlet weak var cell6Button: UIButton!
    @IBAction func cell6(_ sender: UIButton) {
        if turn == 0 {
            cell6Button.setImage(xImage, for: .normal)
            cell6Button.isEnabled = false
            board[5] = "X"
            turn = 1
        }
        else if turn == 1 {
            cell6Button.setImage(oImage, for: .normal)
            cell6Button.isEnabled = false
            board[5] = "O"
            turn = 0
        }
        playSound()
        checkGameStatus()
    }
    
    @IBOutlet weak var cell7Button: UIButton!
    @IBAction func cell7(_ sender: UIButton) {
        if turn == 0 {
            cell7Button.setImage(xImage, for: .normal)
            cell7Button.isEnabled = false
            board[6] = "X"
            turn = 1
        }
        else if turn == 1 {
            cell7Button.setImage(oImage, for: .normal)
            cell7Button.isEnabled = false
            board[6] = "O"
            turn = 0
        }
        playSound()
        checkGameStatus()
    }
    
    @IBOutlet weak var cell8Button: UIButton!
    @IBAction func cell8(_ sender: UIButton) {
        if turn == 0 {
            cell8Button.setImage(xImage, for: .normal)
            cell8Button.isEnabled = false
            board[7] = "X"
            turn = 1
        }
        else if turn == 1 {
            cell8Button.setImage(oImage, for: .normal)
            cell8Button.isEnabled = false
            board[7] = "O"
            turn = 0
        }
        playSound()
        checkGameStatus()
    }
    
    @IBOutlet weak var cell9Button: UIButton!
    @IBAction func cell9(_ sender: UIButton) {
        if turn == 0 {
            cell9Button.setImage(xImage, for: .normal)
            cell9Button.isEnabled = false
            board[8] = "X"
            turn = 1
        }
        else if turn == 1 {
            cell9Button.setImage(oImage, for: .normal)
            cell9Button.isEnabled = false
            board[8] = "O"
            turn = 0
        }
        playSound()
        checkGameStatus()
    }
    
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
        turn = 1
        reloadSettings()
    }
    
    func checkWinCondition(board: [String], gameStatus: Int) -> Int {
        for pair in pairs {
            if board[pair[0]] != "" && board[pair[0]] == board[pair[1]] && board[pair[1]] == board[pair[2]] {
                if board[pair[0]] == "X" {
                    return -1
                }
                else {
                    return 1
                }
            }
        }
        if !board.contains("") {
            return 2
        }
        return 0
    }

    func checkGameStatus() {
        gameStatus = checkWinCondition(board: board, gameStatus: gameStatus)
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
    
    func displayCompletionAlert(winner: Int) {
        var message = ""
        if winner == -1 {
            message = "Congratulations P1! You won."
        }
        else if winner == 1 {
            message = "Congratulations P2! You won."
        }
        else {
            message = "You tied!"
        }
        let completionAlert = UIAlertController(title: "Round Complete", message: message, preferredStyle: UIAlertControllerStyle.alert)
        completionAlert.addAction(UIAlertAction(title: "Play Again", style: .default, handler: nil))
        present(completionAlert, animated: true, completion: {() in self.alertDismissed()})
        completionAlert.addAction(UIAlertAction(title: "Main Menu", style: .cancel, handler: {_ in let menuVC = self.storyboard?.instantiateViewController(withIdentifier: "menuController") as! MenuController
            self.present(menuVC, animated: true, completion: nil)
        }))
    }
    
    func reloadSettings() {
        currentVolume = UserDefaults.standard.integer(forKey: "currentVolume")
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
    
    func alertDismissed() {
        resetGame()
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
    
    func resetGame() {
        board = ["", "", "", "", "", "", "", "", ""]
        gameStatus = 0
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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

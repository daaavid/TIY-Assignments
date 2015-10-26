//
//  ViewController.swift
//  TackyTacTac
//
//  Created by david on 10/26/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    var grid = [[0,0,0], [0,0,0], [0,0,0]]
    
    var isPlayer1Turn = true
    
    var player1Score = 0
    var player2Score = 0
    var stalemateScore = 0
    
    let gameStatusLabel = UILabel(frame: CGRect(x: 0, y: 80, width: 200, height: 50))
    let gameClearButton = UIButton(frame: CGRect(x: 0, y: 600, width: 130, height: 50))
    let scoreClearButton = UIButton(frame: CGRect(x: 0, y: 600, width: 80, height: 50))
    
    let player1ScoreLabel = UILabel(frame: CGRect(x: 0, y: 80, width: 200, height: 50))
    let player2ScoreLabel = UILabel(frame: CGRect(x: 0, y: 80, width: 200, height: 50))

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.backgroundColor = UIColor.whiteColor()
        
        showButtonsLabels()
        
        setButtons()

        showTacs()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - ACTION HANDLERS 5: RISE OF THE PLANET OF THE HANDLERS

    func spacePressed(button: TTTButton)
    {
        if isPlayer1Turn
        {
            gameStatusLabel.text = "Player 2 Turn"
        }
        else
        {
            gameStatusLabel.text = "Player 1 Turn"
        }
        
        if button.player == 0
        {
//            if isPlayer1Turn
//            {
//                button.player = 1
//            }
//            else
//            {
//                button.player = 2
//            }
            
            button.player = isPlayer1Turn ? 1 : 2
            
            grid[button.row][button.col] = isPlayer1Turn ? 1 : 2
            
            isPlayer1Turn = !isPlayer1Turn
            
            checkForWinner()
        }
    }
    
    // MARK: - View
    
    func showButtonsLabels()
    {
        gameClearButton.setTitle("New Game", forState: UIControlState.Normal)
        gameClearButton.center.x = view.center.x + 60
        gameClearButton.backgroundColor = UIColor.darkGrayColor()
        
        view.addSubview(gameClearButton)
        
        scoreClearButton.setTitle("Reset", forState: UIControlState.Normal)
        scoreClearButton.center.x = view.center.x - 60
        scoreClearButton.backgroundColor = UIColor.darkGrayColor()
        
        view.addSubview(scoreClearButton)
        
        gameStatusLabel.text = "Player 1 Turn"
        gameStatusLabel.textAlignment = .Center
        gameStatusLabel.center.x = view.center.x
        
        view.addSubview(gameStatusLabel)
        
        player1ScoreLabel.text = "P1: 0"
        player1ScoreLabel.textAlignment = .Center
        player1ScoreLabel.center.x = view.center.x - 100
        
        view.addSubview(player1ScoreLabel)
        
        player2ScoreLabel.text = "P2: 0"
        player2ScoreLabel.textAlignment = .Center
        player2ScoreLabel.center.x = view.center.x + 100
        
        view.addSubview(player2ScoreLabel)
    }
    
    func showTacs()
    {
        let screenHeight = Int(UIScreen.mainScreen().bounds.height)
        let screenWidth = Int(UIScreen.mainScreen().bounds.width)
        
        let buttonHW = 100
        let buttonSpacing = 4
        
        let gridHW = (buttonHW * 3) + (buttonSpacing * 2)
        
        let leftSpacing = (screenWidth - gridHW) / 2
        let topSpacing = (screenHeight - gridHW) / 2
        
        let randomNumber = Int(arc4random() % 8)
        
        for (r, row) in grid.enumerate()
        {
            for (c, _) in row.enumerate()
            {
                let x = c * (buttonHW + buttonSpacing) + leftSpacing
                let y = r * (buttonHW + buttonSpacing) + topSpacing
                
                let button = TTTButton(frame: CGRect(x: x, y: y, width: buttonHW, height: buttonHW))
                //button.playe = 0
                //button.backgroundColor = UIColor.cyanColor()
                button.setColor(randomNumber)
                
                button.row = r
                button.col = c
                
                button.addTarget(self, action: "spacePressed:", forControlEvents: .TouchUpInside)
                
                view.addSubview(button)
            }
        }
    }
    
    func setButtons()
    {
        gameClearButton.addTarget(self, action: "gameClearButton:", forControlEvents: UIControlEvents.TouchUpInside)
        scoreClearButton.addTarget(self, action: "scoreClearButton:", forControlEvents: UIControlEvents.TouchUpInside)
    }

    // MARK: - Misc
    
    func checkForWinner()
    {
        let possibilities =
        [
            ((0,0),(0,1),(0,2)),
            ((1,0),(1,1),(1,2)),
            ((2,0),(2,1),(2,2)),
            ((0,0),(1,0),(2,0)),
            ((0,1),(1,1),(2,1)),
            ((0,2),(1,2),(2,2)),
            ((0,0),(1,1),(2,2)),
            ((2,0),(1,1),(0,2))
        ]
        
        for possibility in possibilities
        {
            let (p1,p2,p3) = possibility
            
            let value1 = grid[p1.0][p1.1]
            let value2 = grid[p2.0][p2.1]
            let value3 = grid[p3.0][p3.1]
            
            if value1 == value2 && value2 == value3
            {
                if value1 != 0
                {
                    print("Player \(value1) wins!")
                    
                    playerWon(value1)
                }
                else
                {
                    print("No winner: all zeroes")
                }
            }
            else
            {
                print("Does not match")
            }
        }
    }
    
    func playerWon(player: Int)
    {
        switch player
        {
        case 1:
            gameStatusLabel.text = "Player 1 wins!"
            player1Score++
            player1ScoreLabel.text = "P1 \(player1Score)"
        default:
            gameStatusLabel.text = "Player 2 wins!"
            player2Score++
            player2ScoreLabel.text = "P2 \(player2Score)"
        }
    }
    
    func gameClearButton(sender: UIButton)
    {
        clearGame()
    }
    
    func scoreClearButton(sender: UIButton)
    {
        player1Score = 0
        player2Score = 0
        
        player1ScoreLabel.text = "P1 \(player1Score)"
        player2ScoreLabel.text = "P1 \(player1Score)"
        
        gameStatusLabel.text = "Player 1 Turn"
        
        clearGame()
    }
    
    func clearGame()
    {
        grid = [[0,0,0], [0,0,0], [0,0,0]]
        showTacs()
        
        gameStatusLabel.text = "Player 1 Turn"
    }
}

class TTTButton: UIButton
{
    let p1Color = Int(arc4random() % 8)
    let p2Color = Int(arc4random() % 8)
    
    var row = 0
    var col = 0
    
    var player = 0
    {
        didSet
        {
            switch player
            {
            case 1: setColor(p1Color)
            case 2: setColor(p2Color)
                
            default: setColor(0)
                
                //            case 1: backgroundColor = UIColor.magentaColor()
                //            case 2: backgroundColor = UIColor.yellowColor()
                //            default: backgroundColor = UIColor.cyanColor()
                //            }

            }
        }
    }
    
    func setColor(colorSet: Int)
    {
        switch colorSet
        {
        case 1: backgroundColor = UIColor.magentaColor()
        case 2: backgroundColor = UIColor.yellowColor()
        case 3: backgroundColor = UIColor.purpleColor()
        case 4: backgroundColor = UIColor.orangeColor()
        case 5: backgroundColor = UIColor.grayColor()
        case 6: backgroundColor = UIColor.greenColor()
        case 7: backgroundColor = UIColor.redColor()
        default: backgroundColor = UIColor.cyanColor()
        }
    }
}

class color
{
    
}

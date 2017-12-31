//
//  Player2StatisticsViewController.swift
//  StatSquash
//
//  Created by Tucker van Eck on 1/29/16.
//  Copyright © 2016 Tucker van Eck and Akira Shindo. All rights reserved.
//

import UIKit

class Player2StatisticsViewController: UIViewController {
    
    @IBOutlet weak var player2StatisticsTitle: UILabel!
    @IBOutlet weak var player2WonPointsTitleLabel: UILabel!
    @IBOutlet weak var winnersPercentageLabel: UILabel!
    @IBOutlet weak var opponentErrorsPercentageLabel: UILabel!
    @IBOutlet weak var strokesToPlayerPercentage: UILabel!
    @IBOutlet weak var player2LostPointsTitleLabel: UILabel!
    @IBOutlet weak var opponentWinnersPercentageLabel: UILabel!
    @IBOutlet weak var playerErrorsPercentageLabel: UILabel!
    @IBOutlet weak var strokesToOpponentLabel: UILabel!
    
    //Variables that store information about player 2's winning points
    internal static var player1GotBageled = false
    internal static var player2NumWonGames: Int = 0
    internal static var player2NumWonPoints: Int = 0
    internal static var numPlayerWinners: Int = 0
    internal static var numOpponentErrors: Int = 0
    internal static var numStrokesToPlayer: Int = 0
    internal static var wonPointsWinnersPercentage: Double = 0.0
    internal static var wonPointsOpponentErrorsPercentage: Double = 0.0
    internal static var wonPointsStrokesPercentage: Double = 0.0
    
    //Variables that store information about player 2's losing points
    internal static var player2GotBageled = false
    internal static var player1NumWonGames: Int = 0 //player2NumLostgames
    internal static var player2NumLostPoints: Int = 0
    internal static var numOpponentWinners: Int = 0
    internal static var numPlayerErrors: Int = 0
    internal static var numStrokesToOpponent: Int = 0
    internal static var lostPointsOpponentWinnersPercentage: Double = 0.0
    internal static var lostPointsErrorsPercentage: Double = 0.0
    internal static var lostPointsOpponentStrokesPercentage: Double = 0.0
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Do any additional setup after loading the view, typically from a nib.
        
        if (PlayMatchViewController.player2Won)
        {
            player2StatisticsTitle.text = PreMatch.player2Name + ": Match Winner"
        }
        else
        {
            player2StatisticsTitle.text = PreMatch.player2Name + ": Match Loser"
        }
        
        inputData()
        player2CalculateStatistics()
        displayStatistics()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func resetApp(_ sender: UIButton) {
        let alertController1 = UIAlertController(title:"Confirmation", message:"Do you want to keep track of the next match? Note: The data of this match will be lost", preferredStyle: .alert)
        let okAction1 = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            
            UIAlertAction in
            
            PlayMatchViewController.matchEndedDecider = false
            
            PreMatch.player1Name = nil
            PreMatch.player2Name = nil
            PreMatch.player1TeamName = nil
            PreMatch.player2TeamName = nil
            
            PlayMatchViewController.player1TotalGames = 0
            PlayMatchViewController.player1TotalPoints = 0
            PlayMatchViewController.player1CurrentPoints = 0
            PlayMatchViewController.player1TotalWinners = 0
            PlayMatchViewController.player1CurrentWinners = 0
            PlayMatchViewController.player2TotalErrors = 0
            PlayMatchViewController.player2CurrentErrors = 0
            PlayMatchViewController.totalStrokesToPlayer1 = 0
            PlayMatchViewController.currentStrokesToPlayer1 = 0
            
            PlayMatchViewController.player2TotalGames = 0
            PlayMatchViewController.player2TotalPoints = 0
            PlayMatchViewController.player2CurrentPoints = 0
            PlayMatchViewController.player2TotalWinners = 0
            PlayMatchViewController.player2CurrentWinners = 0
            PlayMatchViewController.player1TotalErrors = 0
            PlayMatchViewController.player1CurrentErrors = 0
            PlayMatchViewController.totalStrokesToPlayer2 = 0
            PlayMatchViewController.currentStrokesToPlayer2 = 0
            
            Player1StatisticsViewController.player1GotBageled = false
            Player1StatisticsViewController.player2GotBageled = false
            Player2StatisticsViewController.player1GotBageled = false
            Player2StatisticsViewController.player2GotBageled = false
            
            PreMatch.pickerRow = 0
            PreMatch.previousPickerRow = 0
            
            self.performSegue(withIdentifier: "segue1", sender: self)
        }
        
        let cancel1 = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel){
            
            UIAlertAction in
        }

        alertController1.addAction(okAction1)
        alertController1.addAction(cancel1)
        
        self.present(alertController1, animated: true, completion: nil)
    }
    
    fileprivate func inputData()
    {
        Player2StatisticsViewController.player2NumWonPoints = PlayMatchViewController.player2TotalPoints
        Player2StatisticsViewController.numPlayerWinners = PlayMatchViewController.player2TotalWinners
        Player2StatisticsViewController.numOpponentErrors = PlayMatchViewController.player1TotalErrors
        Player2StatisticsViewController.numStrokesToPlayer = PlayMatchViewController.totalStrokesToPlayer2
        
        Player2StatisticsViewController.player2NumLostPoints = PlayMatchViewController.player1TotalPoints
        Player2StatisticsViewController.numOpponentWinners = PlayMatchViewController.player1TotalWinners
        Player2StatisticsViewController.numPlayerErrors = PlayMatchViewController.player2TotalErrors
        Player2StatisticsViewController.numStrokesToOpponent = PlayMatchViewController.totalStrokesToPlayer1
        
        Player2StatisticsViewController.player1NumWonGames = PlayMatchViewController.player2TotalGames
        Player2StatisticsViewController.player2NumWonGames = PlayMatchViewController.player1TotalGames
    }
    
    fileprivate func displayStatistics()
    {
        if(Player2StatisticsViewController.player2GotBageled) {
            player2WonPointsTitleLabel.text = "Total points won: " + String(Player2StatisticsViewController.player2NumWonPoints) + " points"
            winnersPercentageLabel.text = "Winners: " + PreMatch.player2Name + " did not win any points"
            opponentErrorsPercentageLabel.text = "Opponent Errors: " + PreMatch.player2Name + " did not win any points"
            strokesToPlayerPercentage.text = "Strokes: " + PreMatch.player2Name + " did not win any points"
        } else {
            if(Player2StatisticsViewController.player2NumWonPoints == 1) {
                player2WonPointsTitleLabel.text = "Total points won: " + String(Player2StatisticsViewController.player2NumWonPoints) + " point"}
            else {
            player2WonPointsTitleLabel.text = "Total points won: " + String(Player2StatisticsViewController.player2NumWonPoints) + " points"}
            
            if(Player2StatisticsViewController.numPlayerWinners == 1) {
                winnersPercentageLabel.text = "Winners: " + String(Player2StatisticsViewController.numPlayerWinners) + " point (" + String(Player2StatisticsViewController.wonPointsWinnersPercentage) + "%)"}
            else {
            winnersPercentageLabel.text = "Winners: " + String(Player2StatisticsViewController.numPlayerWinners) + " points (" + String(Player2StatisticsViewController.wonPointsWinnersPercentage) + "%)"}
            
            if(Player2StatisticsViewController.numOpponentErrors == 1) {
                opponentErrorsPercentageLabel.text = "Opponent Errors: " + String(Player2StatisticsViewController.numOpponentErrors) + " point (" + String(Player2StatisticsViewController.wonPointsOpponentErrorsPercentage) + "%)"}
            else {
            opponentErrorsPercentageLabel.text = "Opponent Errors: " + String(Player2StatisticsViewController.numOpponentErrors) + " points (" + String(Player2StatisticsViewController.wonPointsOpponentErrorsPercentage) + "%)"}
            
            if(Player2StatisticsViewController.numStrokesToPlayer == 1) {
                strokesToPlayerPercentage.text = "Strokes: " + String(Player2StatisticsViewController.numStrokesToPlayer) + " point (" + String(Player2StatisticsViewController.wonPointsStrokesPercentage) + "%)"}
            else {
            strokesToPlayerPercentage.text = "Strokes: " + String(Player2StatisticsViewController.numStrokesToPlayer) + " points (" + String(Player2StatisticsViewController.wonPointsStrokesPercentage) + "%)"}
        }
        
        if(Player2StatisticsViewController.player1GotBageled) {
            player2LostPointsTitleLabel.text = "Total points lost: " + String(Player2StatisticsViewController.player2NumLostPoints) + " points"
            opponentWinnersPercentageLabel.text = "Opponent Winners: " + PreMatch.player2Name + " did not lose any points"
            playerErrorsPercentageLabel.text = "Player Errors: " + PreMatch.player2Name + " did not lose any points"
            strokesToOpponentLabel.text = "Strokes given: " + PreMatch.player2Name + " did not lose any points"
        } else {
            if(Player2StatisticsViewController.player2NumLostPoints == 1) {
                player2LostPointsTitleLabel.text = "Total points lost: " + String(Player2StatisticsViewController.player2NumLostPoints) + " point"}
            else {
            player2LostPointsTitleLabel.text = "Total points lost: " + String(Player2StatisticsViewController.player2NumLostPoints) + " points"}
            
            if(Player2StatisticsViewController.numOpponentWinners == 1) {
                opponentWinnersPercentageLabel.text = "Opponent Winners: " + String(Player2StatisticsViewController.numOpponentWinners) + " point (" + String(Player2StatisticsViewController.lostPointsOpponentWinnersPercentage) + "%)"}
            else {
            opponentWinnersPercentageLabel.text = "Opponent Winners: " + String(Player2StatisticsViewController.numOpponentWinners) + " points (" + String(Player2StatisticsViewController.lostPointsOpponentWinnersPercentage) + "%)"}
            
            if(Player2StatisticsViewController.numPlayerErrors == 1) {
                playerErrorsPercentageLabel.text = "Player Errors: " + String(Player2StatisticsViewController.numPlayerErrors) + " point (" + String(Player2StatisticsViewController.lostPointsErrorsPercentage) + "%)"}
            else {playerErrorsPercentageLabel.text = "Player Errors: " + String(Player2StatisticsViewController.numPlayerErrors) + " points (" + String(Player2StatisticsViewController.lostPointsErrorsPercentage) + "%)"}
            
            if(Player2StatisticsViewController.numStrokesToOpponent == 1) {
                strokesToOpponentLabel.text = "Strokes given: " + String(Player2StatisticsViewController.numStrokesToOpponent) + " point (" + String(Player2StatisticsViewController.lostPointsOpponentStrokesPercentage) + "%)"}
            else {
                strokesToOpponentLabel.text = "Strokes given: " + String(Player2StatisticsViewController.numStrokesToOpponent) + " points (" + String(Player2StatisticsViewController.lostPointsOpponentStrokesPercentage) + "%)"
            }
        }
    }
    
    
    fileprivate func player2CalculateStatistics()
    {
        if(Player2StatisticsViewController.player2NumWonPoints == 0) {
            Player2StatisticsViewController.player2GotBageled = true
        } else {
            Player2StatisticsViewController.player2GotBageled = false
            Player2StatisticsViewController.wonPointsWinnersPercentage = Double(round(100 * (Double(Player2StatisticsViewController.numPlayerWinners) / Double(Player2StatisticsViewController.player2NumWonPoints)) * 10) / 10)
            
            Player2StatisticsViewController.wonPointsOpponentErrorsPercentage = Double(round(100 * (Double(Player2StatisticsViewController.numOpponentErrors) / Double(Player2StatisticsViewController.player2NumWonPoints)) * 10) / 10)
        
            Player2StatisticsViewController.wonPointsStrokesPercentage = Double(round(100 * (Double(Player2StatisticsViewController.numStrokesToPlayer) / Double(Player2StatisticsViewController.player2NumWonPoints)) * 10) / 10)
        }
        
        if(Player2StatisticsViewController.player2NumLostPoints == 0) {
            Player2StatisticsViewController.player1GotBageled = true
        } else {
            Player2StatisticsViewController.player1GotBageled = false
            Player2StatisticsViewController.lostPointsOpponentWinnersPercentage = Double(round(100 * (Double(Player2StatisticsViewController.numOpponentWinners) / Double (Player2StatisticsViewController.player2NumLostPoints)) * 10) / 10)
        
            Player2StatisticsViewController.lostPointsErrorsPercentage = Double(round(100 * (Double(Player2StatisticsViewController.numPlayerErrors) / Double (Player2StatisticsViewController.player2NumLostPoints)) * 10) / 10)
        
            Player2StatisticsViewController.lostPointsOpponentStrokesPercentage = Double(round(100 * (Double(Player2StatisticsViewController.numStrokesToOpponent) / Double (Player2StatisticsViewController.player2NumLostPoints)) * 10) / 10)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


}

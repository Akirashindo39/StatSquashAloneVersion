//
//  Player1StatisticsViewController.swift
//  StatSquash
//
//  Created by Tucker van Eck on 1/29/16.
//  Copyright © 2016 Tucker van Eck and Akira Shindo. All rights reserved.
//

import UIKit

class Player1StatisticsViewController: UIViewController {

    @IBOutlet weak var player1StatisticsTitleLabel: UILabel!
    @IBOutlet weak var player1WonPointsTitleLabel: UILabel!
    @IBOutlet weak var winnersPercentageLabel: UILabel!
    @IBOutlet weak var opponentErrorsPercentageLabel: UILabel!
    @IBOutlet weak var strokesToPlayerPercentage: UILabel!
    @IBOutlet weak var player1LostPointsTitleLabel: UILabel!
    @IBOutlet weak var opponentWinnersPercentageLabel: UILabel!
    @IBOutlet weak var playerErrorsPercentageLabel: UILabel!
    @IBOutlet weak var strokesToOpponentLabel: UILabel!
    
    //Variables that store informatoin about player 1's winning points
    internal static var player2GotBageled = false
    internal static var player1NumWonGames: Int = 0
    internal static var player1NumWonPoints: Int = 0
    internal static var numPlayerWinners: Int = 0
    internal static var numOpponentErrors: Int = 0
    internal static var numStrokesToPlayer: Int = 0
    internal static var wonPointsWinnersPercentage: Double = 0.0
    internal static var wonPointsOpponentErrorsPercentage: Double = 0.0
    internal static var wonPointsStrokesPercentage: Double = 0.0
    
    //Variables that store information about player 1's losing points
    internal static var player1GotBageled = false
    internal static var player2NumWonGames: Int = 0 //player1NumLostGames
    internal static var player1NumLostPoints: Int = 0
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
        
        if (PlayMatchViewController.player1Won)
        {
           player1StatisticsTitleLabel.text = PreMatch.player1Name + ": Match Winner"
        }
        else
        {
            player1StatisticsTitleLabel.text = PreMatch.player1Name + ": Match Loser"
        }
        
        inputData()
        player1CalculateStatistics()
        displayStatistics()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func inputData()
    {
        Player1StatisticsViewController.player1NumWonPoints = PlayMatchViewController.player1TotalPoints
        Player1StatisticsViewController.numPlayerWinners = PlayMatchViewController.player1TotalWinners
        Player1StatisticsViewController.numOpponentErrors = PlayMatchViewController.player2TotalErrors
        Player1StatisticsViewController.numStrokesToPlayer = PlayMatchViewController.totalStrokesToPlayer1
        
        Player1StatisticsViewController.player1NumLostPoints = PlayMatchViewController.player2TotalPoints
        Player1StatisticsViewController.numOpponentWinners = PlayMatchViewController.player2TotalWinners
        Player1StatisticsViewController.numPlayerErrors = PlayMatchViewController.player1TotalErrors
        Player1StatisticsViewController.numStrokesToOpponent = PlayMatchViewController.totalStrokesToPlayer2
        
        Player1StatisticsViewController.player1NumWonGames = PlayMatchViewController.player1TotalGames
        Player1StatisticsViewController.player2NumWonGames = PlayMatchViewController.player2TotalGames
    }
    
    fileprivate func displayStatistics()
    {
        if(Player1StatisticsViewController.player1GotBageled) {
            player1WonPointsTitleLabel.text = "Total points won: " + String(Player1StatisticsViewController.player1NumWonPoints) + " points"
            winnersPercentageLabel.text = "Winners: " + PreMatch.player1Name + " did not win any points"
            opponentErrorsPercentageLabel.text = "Opponent Errors: " + PreMatch.player1Name + " did not win any points"
            strokesToPlayerPercentage.text = "Strokes: " + PreMatch.player1Name + " did not win any points"
        } else {
            if(Player1StatisticsViewController.player1NumWonPoints == 1) {
                player1WonPointsTitleLabel.text = "Total points won: " + String(Player1StatisticsViewController.player1NumWonPoints) + " point"}
            else {
                player1WonPointsTitleLabel.text = "Total points won: " + String(Player1StatisticsViewController.player1NumWonPoints) + " points"}
            //space
            if(Player1StatisticsViewController.numPlayerWinners == 1) {
                winnersPercentageLabel.text = "Winners: " + String(Player1StatisticsViewController.numPlayerWinners) + " point (" + String(Player1StatisticsViewController.wonPointsWinnersPercentage) + "%)"}
            else {
                winnersPercentageLabel.text = "Winners: " + String(Player1StatisticsViewController.numPlayerWinners) + " points (" + String(Player1StatisticsViewController.wonPointsWinnersPercentage) + "%)"}
            //space
            if(Player1StatisticsViewController.numOpponentErrors == 1) {
                opponentErrorsPercentageLabel.text = "Opponent Errors: " + String(Player1StatisticsViewController.numOpponentErrors) + " point (" + String(Player1StatisticsViewController.wonPointsOpponentErrorsPercentage) + "%)"}
            else {
                opponentErrorsPercentageLabel.text = "Opponent Errors: " + String(Player1StatisticsViewController.numOpponentErrors) + " points (" + String(Player1StatisticsViewController.wonPointsOpponentErrorsPercentage) + "%)"}
            //space
            if(Player1StatisticsViewController.numStrokesToPlayer == 1) {
                strokesToPlayerPercentage.text = "Strokes: " + String(Player1StatisticsViewController.numStrokesToPlayer) + " point (" + String(Player1StatisticsViewController.wonPointsStrokesPercentage) + "%)"}
            else {
            strokesToPlayerPercentage.text = "Strokes: " + String(Player1StatisticsViewController.numStrokesToPlayer) + " points (" + String(Player1StatisticsViewController.wonPointsStrokesPercentage) + "%)"}
        }
        
        if(Player1StatisticsViewController.player2GotBageled) {
            player1LostPointsTitleLabel.text = "Total points lost: " + String(Player1StatisticsViewController.player1NumLostPoints) + " points"
            opponentWinnersPercentageLabel.text = "Opponent Winners: " + PreMatch.player1Name + " did not lose any points"
            playerErrorsPercentageLabel.text = "Player Errors: " + PreMatch.player1Name + " did not lose any points"
            strokesToOpponentLabel.text = "Strokes given: " + PreMatch.player1Name + " did not lose any points"
        } else {
            if(Player1StatisticsViewController.player1NumLostPoints == 1) {
                player1LostPointsTitleLabel.text = "Total points lost: " + String(Player1StatisticsViewController.player1NumLostPoints) + " point"}
            else {
                player1LostPointsTitleLabel.text = "Total points lost: " + String(Player1StatisticsViewController.player1NumLostPoints) + " points"}
            
            if(Player1StatisticsViewController.numOpponentWinners == 1) {
                opponentWinnersPercentageLabel.text = "Opponent Winners: " + String(Player1StatisticsViewController.numOpponentWinners) + " point (" + String(Player1StatisticsViewController.lostPointsOpponentWinnersPercentage) + "%)"}
            else {
            opponentWinnersPercentageLabel.text = "Opponent Winners: " + String(Player1StatisticsViewController.numOpponentWinners) + " points (" + String(Player1StatisticsViewController.lostPointsOpponentWinnersPercentage) + "%)"}
            
            if(Player1StatisticsViewController.numPlayerErrors == 1) {
                playerErrorsPercentageLabel.text = "Player Errors: " + String(Player1StatisticsViewController.numPlayerErrors) + " point (" + String(Player1StatisticsViewController.lostPointsErrorsPercentage) + "%)"}
            else {
            playerErrorsPercentageLabel.text = "Player Errors: " + String(Player1StatisticsViewController.numPlayerErrors) + " points (" + String(Player1StatisticsViewController.lostPointsErrorsPercentage) + "%)"}
            
            if(Player1StatisticsViewController.numStrokesToOpponent == 1) {
                strokesToOpponentLabel.text = "Strokes given: " + String(Player1StatisticsViewController.numStrokesToOpponent) + " point (" + String(Player1StatisticsViewController.lostPointsOpponentStrokesPercentage) + "%)"}
            else {
            strokesToOpponentLabel.text = "Strokes given: " + String(Player1StatisticsViewController.numStrokesToOpponent) + " points (" + String(Player1StatisticsViewController.lostPointsOpponentStrokesPercentage) + "%)"}
        }
    }
    
    fileprivate func player1CalculateStatistics()
    {
        if(Player1StatisticsViewController.player1NumWonPoints == 0) {
            Player1StatisticsViewController.player1GotBageled = true
        } else {
            Player1StatisticsViewController.player1GotBageled = false
            Player1StatisticsViewController.wonPointsWinnersPercentage = Double(round((100 * Double(Player1StatisticsViewController.numPlayerWinners) / Double(Player1StatisticsViewController.player1NumWonPoints)) * 10) / 10)
        
            Player1StatisticsViewController.wonPointsOpponentErrorsPercentage = Double(round((100 * Double(Player1StatisticsViewController.numOpponentErrors) / Double(Player1StatisticsViewController.player1NumWonPoints)) * 10) / 10)
        
            Player1StatisticsViewController.wonPointsStrokesPercentage = Double(round((100 * Double(Player1StatisticsViewController.numStrokesToPlayer) / Double(Player1StatisticsViewController.player1NumWonPoints)) * 10) / 10)
        }
        
        if(Player1StatisticsViewController.player1NumLostPoints == 0){
            Player1StatisticsViewController.player2GotBageled = true
        } else {
            Player1StatisticsViewController.player2GotBageled = false
            Player1StatisticsViewController.lostPointsOpponentWinnersPercentage = Double(round((100 * Double(Player1StatisticsViewController.numOpponentWinners) / Double (Player1StatisticsViewController.player1NumLostPoints)) * 10) / 10)
        
            Player1StatisticsViewController.lostPointsErrorsPercentage = Double(round((100 * Double(Player1StatisticsViewController.numPlayerErrors) / Double (Player1StatisticsViewController.player1NumLostPoints)) * 10) / 10)
        
            Player1StatisticsViewController.lostPointsOpponentStrokesPercentage = Double(round((100 * Double(Player1StatisticsViewController.numStrokesToOpponent) / Double (Player1StatisticsViewController.player1NumLostPoints)) * 10) / 10)
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

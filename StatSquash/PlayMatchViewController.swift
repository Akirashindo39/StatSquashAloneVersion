//
//  PlayMatchViewController.swift
//  StatSquash
//
//  Created by Tucker van Eck on 1/27/16.
//  Copyright © 2016 Tucker van Eck and Akira Shindo. All rights reserved.
//

import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func >= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l >= r
  default:
    return !(lhs < rhs)
  }
}


class PlayMatchViewController: UIViewController {
    
    internal static var matchEndedDecider = false
    internal static var player1Won = false
    internal static var player2Won = false
    internal static var playMatchHasBeenVisited = false
    
    internal static var numGamesToWin = 1
    
    internal static var player1TotalGames = 0
    internal static var player1TotalPoints = 0
    internal static var player1CurrentPoints = 0
    internal static var player1TotalWinners = 0
    internal static var player1CurrentWinners = 0
    internal static var player2TotalErrors = 0
    internal static var player2CurrentErrors = 0
    internal static var totalStrokesToPlayer1 = 0
    internal static var currentStrokesToPlayer1 = 0
    
    internal static var player2TotalGames = 0
    internal static var player2TotalPoints = 0
    internal static var player2CurrentPoints = 0
    internal static var player2TotalWinners = 0
    internal static var player2CurrentWinners = 0
    internal static var player1TotalErrors = 0
    internal static var player1CurrentErrors = 0
    internal static var totalStrokesToPlayer2 = 0
    internal static var currentStrokesToPlayer2 = 0
    
    //Doing the sutff for the Player and Team Names
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet weak var toStatisticsButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    
    @IBOutlet weak var endMatchPostTop: UILabel!
    @IBOutlet weak var endMatchPostBottom: UILabel!
    
    @IBOutlet weak var player1TeamNameLab: UILabel!
    @IBOutlet weak var player2TeamNameLab: UILabel!
    
    @IBOutlet weak var player1NameLab: UILabel!
    @IBOutlet weak var player2NameLab: UILabel!
    
    @IBOutlet weak var player1GamesLab: UILabel!
    @IBOutlet weak var player2GamesLab: UILabel!
    
    //Initializing
    @IBOutlet weak var PlayOnePoints: UILabel!
    @IBOutlet weak var PlayTwoPoints: UILabel!
    
    @IBOutlet weak var StepOneWinners: UIStepper!
    @IBOutlet weak var PlayOneWinners: UILabel!
    
    @IBAction func StepOneWinnersChanged(_ sender: UIStepper) {
        PlayOneWinners.text = Int(sender.value).description
        //PlayMatchViewController.player1CurrentWinners = Int(sender.value)
        PlayMatchViewController.player1CurrentWinners = Int(PlayOneWinners.text!)!
        
        PlayMatchViewController.player1CurrentPoints = PlayMatchViewController.player1CurrentWinners + PlayMatchViewController.player2CurrentErrors + PlayMatchViewController.currentStrokesToPlayer1
        PlayOnePoints.text = String(PlayMatchViewController.player1CurrentPoints)
        
        if(Int(PlayOnePoints.text!) >= 11)
        {
            if((Int(PlayOnePoints.text!)! - Int(PlayTwoPoints.text!)!) >= 2)
            {
                let alertController1 = UIAlertController(title:"Confirmation", message:"Did " + PreMatch.player1Name + " win the game?", preferredStyle: .alert)
                let okAction1 = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                    
                    UIAlertAction in
                    
                    PlayMatchViewController.player1TotalGames = PlayMatchViewController.player1TotalGames + 1
                    
                    PlayMatchViewController.player1TotalPoints += PlayMatchViewController.player1CurrentPoints
                    PlayMatchViewController.player1TotalWinners += PlayMatchViewController.player1CurrentWinners
                    PlayMatchViewController.player2TotalErrors += PlayMatchViewController.player2CurrentErrors
                    PlayMatchViewController.totalStrokesToPlayer1 += PlayMatchViewController.currentStrokesToPlayer1
                    
                    PlayMatchViewController.player2TotalPoints += PlayMatchViewController.player2CurrentPoints
                    PlayMatchViewController.player2TotalWinners += PlayMatchViewController.player2CurrentWinners
                    PlayMatchViewController.player1TotalErrors += PlayMatchViewController.player1CurrentErrors
                    PlayMatchViewController.totalStrokesToPlayer2 += PlayMatchViewController.currentStrokesToPlayer2
                    
                    PlayMatchViewController.player1CurrentPoints = 0
                    PlayMatchViewController.player1CurrentWinners = 0
                    PlayMatchViewController.player2CurrentErrors = 0
                    PlayMatchViewController.currentStrokesToPlayer1 = 0
                    
                    PlayMatchViewController.player2CurrentPoints = 0
                    PlayMatchViewController.player2CurrentWinners = 0
                    PlayMatchViewController.player1CurrentErrors = 0
                    PlayMatchViewController.currentStrokesToPlayer2 = 0
                    
                    self.StepOneWinners.value = 0
                    self.StepTwoWinners.value = 0
                    self.StepOneErrors.value = 0
                    self.StepTwoErrors.value = 0
                    self.StepOneStrokes.value = 0
                    self.StepTwoStrokes.value = 0
                    
                    self.player1GamesLab.text = String(PlayMatchViewController.player1TotalGames)
                    
                    self.PlayOnePoints.text = String(PlayMatchViewController.player1CurrentPoints)
                    self.PlayOneWinners.text = String(PlayMatchViewController.player1CurrentWinners)
                    self.PlayOneErrors.text = String(PlayMatchViewController.player2CurrentErrors)
                    self.PlayOneStrokes.text = String(PlayMatchViewController.currentStrokesToPlayer1)
                    
                    self.PlayTwoPoints.text = String(PlayMatchViewController.player2CurrentPoints)
                    self.PlayTwoWinners.text = String(PlayMatchViewController.player2CurrentWinners)
                    self.PlayTwoErrors.text = String(PlayMatchViewController.player1CurrentErrors)
                    self.PlayTwoStrokes.text = String(PlayMatchViewController.currentStrokesToPlayer2)
                    
                    if (PlayMatchViewController.player1TotalGames == PlayMatchViewController.numGamesToWin)
                    {
                        self.endMatchPostTop.text = "Match Ended!"
                        self.endMatchPostBottom.text = "Now view your stats!"
                        PlayMatchViewController.matchEndedDecider = true
                        self.toStatisticsButton.isHidden = false
                        self.previousButton.isHidden = true
                        self.StepOneWinners.isHidden = true
                        self.StepOneErrors.isHidden = true
                        self.StepOneStrokes.isHidden = true
                        self.StepTwoWinners.isHidden = true
                        self.StepTwoErrors.isHidden = true
                        self.StepTwoStrokes.isHidden = true
                        
                        PlayMatchViewController.player1Won = true
                        PlayMatchViewController.player2Won = false
                    }
                }
                
                let cancel1 = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel){
                    
                    UIAlertAction in
                    
                    PlayMatchViewController.player1CurrentPoints -= 1
                    self.PlayOnePoints.text = String(PlayMatchViewController.player1CurrentPoints)
                    
                    PlayMatchViewController.player1CurrentWinners -= 1
                    self.StepOneWinners.value -= 1
                    self.PlayOneWinners.text = String(PlayMatchViewController.player1CurrentWinners)
                }
                alertController1.addAction(okAction1)
                alertController1.addAction(cancel1)
                
                self.present(alertController1, animated: true, completion: nil)
            }
        }
    }
    
    @IBOutlet weak var StepTwoWinners: UIStepper!
    @IBOutlet weak var PlayTwoWinners: UILabel!
    
    @IBAction func StepTwoWinnersChanged(_ sender: UIStepper) {
        PlayTwoWinners.text = Int(sender.value).description
        //PlayMatchViewController.player2CurrentWinners = Int(sender.value)
        PlayMatchViewController.player2CurrentWinners = Int(PlayTwoWinners.text!)!
        
        PlayMatchViewController.player2CurrentPoints = PlayMatchViewController.player2CurrentWinners + PlayMatchViewController.player1CurrentErrors + PlayMatchViewController.currentStrokesToPlayer2
        PlayTwoPoints.text = String(PlayMatchViewController.player2CurrentPoints)
        
        if(Int(PlayTwoPoints.text!) >= 11)
        {
            if((Int(PlayTwoPoints.text!)! - Int(PlayOnePoints.text!)!) >= 2)
            {
                let alertController2 = UIAlertController(title:"Confirmation", message:"Did " + PreMatch.player2Name + " win the game?", preferredStyle: .alert)
                let okAction2 = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                    
                    UIAlertAction in
                    
                    PlayMatchViewController.player2TotalGames = PlayMatchViewController.player2TotalGames + 1
                    
                    PlayMatchViewController.player1TotalPoints += PlayMatchViewController.player1CurrentPoints
                    PlayMatchViewController.player1TotalWinners += PlayMatchViewController.player1CurrentWinners
                    PlayMatchViewController.player2TotalErrors += PlayMatchViewController.player2CurrentErrors
                    PlayMatchViewController.totalStrokesToPlayer1 += PlayMatchViewController.currentStrokesToPlayer1
                    
                    PlayMatchViewController.player2TotalPoints += PlayMatchViewController.player2CurrentPoints
                    PlayMatchViewController.player2TotalWinners += PlayMatchViewController.player2CurrentWinners
                    PlayMatchViewController.player1TotalErrors += PlayMatchViewController.player1CurrentErrors
                    PlayMatchViewController.totalStrokesToPlayer2 += PlayMatchViewController.currentStrokesToPlayer2
                    
                    PlayMatchViewController.player1CurrentPoints = 0
                    PlayMatchViewController.player1CurrentWinners = 0
                    PlayMatchViewController.player2CurrentErrors = 0
                    PlayMatchViewController.currentStrokesToPlayer1 = 0
                    
                    PlayMatchViewController.player2CurrentPoints = 0
                    PlayMatchViewController.player2CurrentWinners = 0
                    PlayMatchViewController.player1CurrentErrors = 0
                    PlayMatchViewController.currentStrokesToPlayer2 = 0
                    
                    self.StepOneWinners.value = 0
                    self.StepTwoWinners.value = 0
                    self.StepOneErrors.value = 0
                    self.StepTwoErrors.value = 0
                    self.StepOneStrokes.value = 0
                    self.StepTwoStrokes.value = 0
                    
                    self.player2GamesLab.text = String(PlayMatchViewController.player2TotalGames)
                    
                    self.PlayOnePoints.text = String(PlayMatchViewController.player1CurrentPoints)
                    self.PlayOneWinners.text = String(PlayMatchViewController.player1CurrentWinners)
                    self.PlayOneErrors.text = String(PlayMatchViewController.player2CurrentErrors)
                    self.PlayOneStrokes.text = String(PlayMatchViewController.currentStrokesToPlayer1)
                    
                    self.PlayTwoPoints.text = String(PlayMatchViewController.player2CurrentPoints)
                    self.PlayTwoWinners.text = String(PlayMatchViewController.player2CurrentWinners)
                    self.PlayTwoErrors.text = String(PlayMatchViewController.player1CurrentErrors)
                    self.PlayTwoStrokes.text = String(PlayMatchViewController.currentStrokesToPlayer2)
                    
                    if (PlayMatchViewController.player2TotalGames == PlayMatchViewController.numGamesToWin)
                    {
                        self.endMatchPostTop.text = "Match Ended!"
                        self.endMatchPostBottom.text = "Now view your stats!"
                        PlayMatchViewController.matchEndedDecider = true
                        self.toStatisticsButton.isHidden = false
                        self.previousButton.isHidden = true
                        self.StepOneWinners.isHidden = true
                        self.StepOneErrors.isHidden = true
                        self.StepOneStrokes.isHidden = true
                        self.StepTwoWinners.isHidden = true
                        self.StepTwoErrors.isHidden = true
                        self.StepTwoStrokes.isHidden = true
                        
                        PlayMatchViewController.player1Won = false
                        PlayMatchViewController.player2Won = true
                    }
                }
                
                let cancel2 = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel){
                    
                    UIAlertAction in
                    
                    PlayMatchViewController.player2CurrentPoints -= 1
                    self.PlayTwoPoints.text = String(PlayMatchViewController.player2CurrentPoints)
                    
                    PlayMatchViewController.player2CurrentWinners -= 1
                    self.StepTwoWinners.value -= 1
                    self.PlayTwoWinners.text = String(PlayMatchViewController.player2CurrentWinners)
                }
                alertController2.addAction(okAction2)
                alertController2.addAction(cancel2)
                
                self.present(alertController2, animated: true, completion: nil)
            }
        }
    }
    
    @IBOutlet weak var StepOneErrors: UIStepper!
    @IBOutlet weak var PlayOneErrors: UILabel!
    
    @IBAction func StepOneErrorsChanged(_ sender: UIStepper) {
        PlayOneErrors.text = Int(sender.value).description
        //PlayMatchViewController.player1CurrentErrors = Int(sender.value)
        PlayMatchViewController.player1CurrentErrors = Int(PlayOneErrors.text!)!
        
        PlayMatchViewController.player2CurrentPoints = PlayMatchViewController.player2CurrentWinners + PlayMatchViewController.player1CurrentErrors + PlayMatchViewController.currentStrokesToPlayer2
        PlayTwoPoints.text = String(PlayMatchViewController.player2CurrentPoints)
        
        if(Int(PlayTwoPoints.text!) >= 11)
        {
            if((Int(PlayTwoPoints.text!)! - Int(PlayOnePoints.text!)!) >= 2)
            {
                let alertController2 = UIAlertController(title:"Confirmation", message:"Did " + PreMatch.player2Name + " win the game?", preferredStyle: .alert)
                let okAction2 = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                    
                    UIAlertAction in
                    
                    PlayMatchViewController.player2TotalGames = PlayMatchViewController.player2TotalGames + 1
                    
                    PlayMatchViewController.player1TotalPoints += PlayMatchViewController.player1CurrentPoints
                    PlayMatchViewController.player1TotalWinners += PlayMatchViewController.player1CurrentWinners
                    PlayMatchViewController.player2TotalErrors += PlayMatchViewController.player2CurrentErrors
                    PlayMatchViewController.totalStrokesToPlayer1 += PlayMatchViewController.currentStrokesToPlayer1
                    
                    PlayMatchViewController.player2TotalPoints += PlayMatchViewController.player2CurrentPoints
                    PlayMatchViewController.player2TotalWinners += PlayMatchViewController.player2CurrentWinners
                    PlayMatchViewController.player1TotalErrors += PlayMatchViewController.player1CurrentErrors
                    PlayMatchViewController.totalStrokesToPlayer2 += PlayMatchViewController.currentStrokesToPlayer2
                    
                    PlayMatchViewController.player1CurrentPoints = 0
                    PlayMatchViewController.player1CurrentWinners = 0
                    PlayMatchViewController.player2CurrentErrors = 0
                    PlayMatchViewController.currentStrokesToPlayer1 = 0
                    
                    PlayMatchViewController.player2CurrentPoints = 0
                    PlayMatchViewController.player2CurrentWinners = 0
                    PlayMatchViewController.player1CurrentErrors = 0
                    PlayMatchViewController.currentStrokesToPlayer2 = 0
                    
                    self.StepOneWinners.value = 0
                    self.StepTwoWinners.value = 0
                    self.StepOneErrors.value = 0
                    self.StepTwoErrors.value = 0
                    self.StepOneStrokes.value = 0
                    self.StepTwoStrokes.value = 0
                    
                    self.player2GamesLab.text = String(PlayMatchViewController.player2TotalGames)
                    
                    self.PlayOnePoints.text = String(PlayMatchViewController.player1CurrentPoints)
                    self.PlayOneWinners.text = String(PlayMatchViewController.player1CurrentWinners)
                    self.PlayOneErrors.text = String(PlayMatchViewController.player2CurrentErrors)
                    self.PlayOneStrokes.text = String(PlayMatchViewController.currentStrokesToPlayer1)
                    
                    self.PlayTwoPoints.text = String(PlayMatchViewController.player2CurrentPoints)
                    self.PlayTwoWinners.text = String(PlayMatchViewController.player2CurrentWinners)
                    self.PlayTwoErrors.text = String(PlayMatchViewController.player1CurrentErrors)
                    self.PlayTwoStrokes.text = String(PlayMatchViewController.currentStrokesToPlayer2)
                    
                    if (PlayMatchViewController.player2TotalGames == PlayMatchViewController.numGamesToWin)
                    {
                        self.endMatchPostTop.text = "Match Ended!"
                        self.endMatchPostBottom.text = "Now view your stats!"
                        PlayMatchViewController.matchEndedDecider = true
                        self.toStatisticsButton.isHidden = false
                        self.previousButton.isHidden = true
                        self.StepOneWinners.isHidden = true
                        self.StepOneErrors.isHidden = true
                        self.StepOneStrokes.isHidden = true
                        self.StepTwoWinners.isHidden = true
                        self.StepTwoErrors.isHidden = true
                        self.StepTwoStrokes.isHidden = true
                        
                        PlayMatchViewController.player1Won = false
                        PlayMatchViewController.player2Won = true
                    }
                }
                
                let cancel2 = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel){
                    
                    UIAlertAction in
                    
                    PlayMatchViewController.player2CurrentPoints -= 1
                    self.PlayTwoPoints.text = String(PlayMatchViewController.player2CurrentPoints)
                    
                    PlayMatchViewController.player1CurrentErrors -= 1
                    self.StepOneErrors.value -= 1
                    self.PlayOneErrors.text = String(PlayMatchViewController.player1CurrentErrors)
                }
                alertController2.addAction(okAction2)
                alertController2.addAction(cancel2)
                
                self.present(alertController2, animated: true, completion: nil)
            }
        }
    }
    
    @IBOutlet weak var StepTwoErrors: UIStepper!
    @IBOutlet weak var PlayTwoErrors: UILabel!
    
    @IBAction func StepTwoErrorsChanged(_ sender: UIStepper) {
        PlayTwoErrors.text = Int(sender.value).description
        //PlayMatchViewController.player2CurrentErrors = Int(sender.value)
        PlayMatchViewController.player2CurrentErrors = Int(PlayTwoErrors.text!)!
        
        PlayMatchViewController.player1CurrentPoints = PlayMatchViewController.player1CurrentWinners + PlayMatchViewController.player2CurrentErrors + PlayMatchViewController.currentStrokesToPlayer1
        PlayOnePoints.text = String(PlayMatchViewController.player1CurrentPoints)
        
        if(Int(PlayOnePoints.text!) >= 11)
        {
            if((Int(PlayOnePoints.text!)! - Int(PlayTwoPoints.text!)!) >= 2)
            {
                let alertController1 = UIAlertController(title:"Confirmation", message:"Did " + PreMatch.player1Name + " win the game?", preferredStyle: .alert)
                let okAction1 = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                    
                    UIAlertAction in
                    
                    PlayMatchViewController.player1TotalGames = PlayMatchViewController.player1TotalGames + 1
                    
                    PlayMatchViewController.player1TotalPoints += PlayMatchViewController.player1CurrentPoints
                    PlayMatchViewController.player1TotalWinners += PlayMatchViewController.player1CurrentWinners
                    PlayMatchViewController.player2TotalErrors += PlayMatchViewController.player2CurrentErrors
                    PlayMatchViewController.totalStrokesToPlayer1 += PlayMatchViewController.currentStrokesToPlayer1
                    
                    PlayMatchViewController.player2TotalPoints += PlayMatchViewController.player2CurrentPoints
                    PlayMatchViewController.player2TotalWinners += PlayMatchViewController.player2CurrentWinners
                    PlayMatchViewController.player1TotalErrors += PlayMatchViewController.player1CurrentErrors
                    PlayMatchViewController.totalStrokesToPlayer2 += PlayMatchViewController.currentStrokesToPlayer2
                    
                    PlayMatchViewController.player1CurrentPoints = 0
                    PlayMatchViewController.player1CurrentWinners = 0
                    PlayMatchViewController.player2CurrentErrors = 0
                    PlayMatchViewController.currentStrokesToPlayer1 = 0
                    
                    PlayMatchViewController.player2CurrentPoints = 0
                    PlayMatchViewController.player2CurrentWinners = 0
                    PlayMatchViewController.player1CurrentErrors = 0
                    PlayMatchViewController.currentStrokesToPlayer2 = 0
                    
                    self.StepOneWinners.value = 0
                    self.StepTwoWinners.value = 0
                    self.StepOneErrors.value = 0
                    self.StepTwoErrors.value = 0
                    self.StepOneStrokes.value = 0
                    self.StepTwoStrokes.value = 0
                    
                    self.player1GamesLab.text = String(PlayMatchViewController.player1TotalGames)
                    
                    self.PlayOnePoints.text = String(PlayMatchViewController.player1CurrentPoints)
                    self.PlayOneWinners.text = String(PlayMatchViewController.player1CurrentWinners)
                    self.PlayOneErrors.text = String(PlayMatchViewController.player2CurrentErrors)
                    self.PlayOneStrokes.text = String(PlayMatchViewController.currentStrokesToPlayer1)
                    
                    self.PlayTwoPoints.text = String(PlayMatchViewController.player2CurrentPoints)
                    self.PlayTwoWinners.text = String(PlayMatchViewController.player2CurrentWinners)
                    self.PlayTwoErrors.text = String(PlayMatchViewController.player1CurrentErrors)
                    self.PlayTwoStrokes.text = String(PlayMatchViewController.currentStrokesToPlayer2)
                    
                    if (PlayMatchViewController.player1TotalGames == PlayMatchViewController.numGamesToWin)
                    {
                        self.endMatchPostTop.text = "Match Ended!"
                        self.endMatchPostBottom.text = "Now view your stats!"
                        PlayMatchViewController.matchEndedDecider = true
                        self.toStatisticsButton.isHidden = false
                        self.previousButton.isHidden = true
                        self.StepOneWinners.isHidden = true
                        self.StepOneErrors.isHidden = true
                        self.StepOneStrokes.isHidden = true
                        self.StepTwoWinners.isHidden = true
                        self.StepTwoErrors.isHidden = true
                        self.StepTwoStrokes.isHidden = true

                        PlayMatchViewController.player1Won = true
                        PlayMatchViewController.player2Won = false
                    }
                }
                
                let cancel1 = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel){
                    
                    UIAlertAction in
                    
                    PlayMatchViewController.player1CurrentPoints -= 1
                    self.PlayOnePoints.text = String(PlayMatchViewController.player1CurrentPoints)
                    
                    PlayMatchViewController.player2CurrentErrors -= 1
                    self.StepTwoErrors.value -= 1
                    self.PlayTwoErrors.text = String(PlayMatchViewController.player2CurrentErrors)
                }
                alertController1.addAction(okAction1)
                alertController1.addAction(cancel1)
                
                self.present(alertController1, animated: true, completion: nil)
            }
        }
    }
    
    @IBOutlet weak var StepOneStrokes: UIStepper!
    @IBOutlet weak var PlayOneStrokes: UILabel!
    
    @IBAction func StepOneStrokesChanged(_ sender: UIStepper) {
        PlayOneStrokes.text = Int(sender.value).description
        //PlayMatchViewController.currentStrokesToPlayer1 = Int(sender.value)
        PlayMatchViewController.currentStrokesToPlayer1 = Int(PlayOneStrokes.text!)!
        
        PlayMatchViewController.player1CurrentPoints = PlayMatchViewController.player1CurrentWinners + PlayMatchViewController.player2CurrentErrors + PlayMatchViewController.currentStrokesToPlayer1
        PlayOnePoints.text = String(PlayMatchViewController.player1CurrentPoints)
        
        if(Int(PlayOnePoints.text!) >= 11)
        {
            if((Int(PlayOnePoints.text!)! - Int(PlayTwoPoints.text!)!) >= 2)
            {
                let alertController1 = UIAlertController(title:"Confirmation", message:"Did " + PreMatch.player1Name + " win the game?", preferredStyle: .alert)
                let okAction1 = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                    
                    UIAlertAction in
                    
                    PlayMatchViewController.player1TotalGames = PlayMatchViewController.player1TotalGames + 1
                    
                    PlayMatchViewController.player1TotalPoints += PlayMatchViewController.player1CurrentPoints
                    PlayMatchViewController.player1TotalWinners += PlayMatchViewController.player1CurrentWinners
                    PlayMatchViewController.player2TotalErrors += PlayMatchViewController.player2CurrentErrors
                    PlayMatchViewController.totalStrokesToPlayer1 += PlayMatchViewController.currentStrokesToPlayer1
                    
                    PlayMatchViewController.player2TotalPoints += PlayMatchViewController.player2CurrentPoints
                    PlayMatchViewController.player2TotalWinners += PlayMatchViewController.player2CurrentWinners
                    PlayMatchViewController.player1TotalErrors += PlayMatchViewController.player1CurrentErrors
                    PlayMatchViewController.totalStrokesToPlayer2 += PlayMatchViewController.currentStrokesToPlayer2
                    
                    PlayMatchViewController.player1CurrentPoints = 0
                    PlayMatchViewController.player1CurrentWinners = 0
                    PlayMatchViewController.player2CurrentErrors = 0
                    PlayMatchViewController.currentStrokesToPlayer1 = 0
                    
                    PlayMatchViewController.player2CurrentPoints = 0
                    PlayMatchViewController.player2CurrentWinners = 0
                    PlayMatchViewController.player1CurrentErrors = 0
                    PlayMatchViewController.currentStrokesToPlayer2 = 0
                    
                    self.StepOneWinners.value = 0
                    self.StepTwoWinners.value = 0
                    self.StepOneErrors.value = 0
                    self.StepTwoErrors.value = 0
                    self.StepOneStrokes.value = 0
                    self.StepTwoStrokes.value = 0
                    
                    self.player1GamesLab.text = String(PlayMatchViewController.player1TotalGames)
                    
                    self.PlayOnePoints.text = String(PlayMatchViewController.player1CurrentPoints)
                    self.PlayOneWinners.text = String(PlayMatchViewController.player1CurrentWinners)
                    self.PlayOneErrors.text = String(PlayMatchViewController.player2CurrentErrors)
                    self.PlayOneStrokes.text = String(PlayMatchViewController.currentStrokesToPlayer1)
                    
                    self.PlayTwoPoints.text = String(PlayMatchViewController.player2CurrentPoints)
                    self.PlayTwoWinners.text = String(PlayMatchViewController.player2CurrentWinners)
                    self.PlayTwoErrors.text = String(PlayMatchViewController.player1CurrentErrors)
                    self.PlayTwoStrokes.text = String(PlayMatchViewController.currentStrokesToPlayer2)
                    
                    if (PlayMatchViewController.player1TotalGames == PlayMatchViewController.numGamesToWin)
                    {
                        self.endMatchPostTop.text = "Match Ended!"
                        self.endMatchPostBottom.text = "Now view your stats!"
                        PlayMatchViewController.matchEndedDecider = true
                        self.toStatisticsButton.isHidden = false
                        self.previousButton.isHidden = true
                        self.StepOneWinners.isHidden = true
                        self.StepOneErrors.isHidden = true
                        self.StepOneStrokes.isHidden = true
                        self.StepTwoWinners.isHidden = true
                        self.StepTwoErrors.isHidden = true
                        self.StepTwoStrokes.isHidden = true

                        PlayMatchViewController.player1Won = true
                        PlayMatchViewController.player2Won = false
                    }
                }
                
                let cancel1 = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel){
                    
                    UIAlertAction in
                    
                    PlayMatchViewController.player1CurrentPoints -= 1
                    self.PlayOnePoints.text = String(PlayMatchViewController.player1CurrentPoints)
                    
                    PlayMatchViewController.currentStrokesToPlayer1 -= 1
                    self.StepOneStrokes.value -= 1
                    self.PlayOneStrokes.text = String(PlayMatchViewController.currentStrokesToPlayer1)
                }
                alertController1.addAction(okAction1)
                alertController1.addAction(cancel1)
                
                self.present(alertController1, animated: true, completion: nil)
            }
        }
    }
    
    @IBOutlet weak var StepTwoStrokes: UIStepper!
    @IBOutlet weak var PlayTwoStrokes: UILabel!
    
    @IBAction func StepTwoStrokesChanged(_ sender: UIStepper) {
        PlayTwoStrokes.text = Int(sender.value).description
        //PlayMatchViewController.currentStrokesToPlayer2 = Int(sender.value)
        PlayMatchViewController.currentStrokesToPlayer2 = Int(PlayTwoStrokes.text!)!
        
        PlayMatchViewController.player2CurrentPoints = PlayMatchViewController.player2CurrentWinners + PlayMatchViewController.player1CurrentErrors + PlayMatchViewController.currentStrokesToPlayer2
        PlayTwoPoints.text = String(PlayMatchViewController.player2CurrentPoints)
        
        if(Int(PlayTwoPoints.text!) >= 11)
        {
            if((Int(PlayTwoPoints.text!)! - Int(PlayOnePoints.text!)!) >= 2)
            {
                let alertController2 = UIAlertController(title:"Confirmation", message:"Did " + PreMatch.player2Name + " win the game?", preferredStyle: .alert)
                let okAction2 = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                    
                    UIAlertAction in
                    
                    PlayMatchViewController.player2TotalGames = PlayMatchViewController.player2TotalGames + 1
                    
                    PlayMatchViewController.player1TotalPoints += PlayMatchViewController.player1CurrentPoints
                    PlayMatchViewController.player1TotalWinners += PlayMatchViewController.player1CurrentWinners
                    PlayMatchViewController.player2TotalErrors += PlayMatchViewController.player2CurrentErrors
                    PlayMatchViewController.totalStrokesToPlayer1 += PlayMatchViewController.currentStrokesToPlayer1
                    
                    PlayMatchViewController.player2TotalPoints += PlayMatchViewController.player2CurrentPoints
                    PlayMatchViewController.player2TotalWinners += PlayMatchViewController.player2CurrentWinners
                    PlayMatchViewController.player1TotalErrors += PlayMatchViewController.player1CurrentErrors
                    PlayMatchViewController.totalStrokesToPlayer2 += PlayMatchViewController.currentStrokesToPlayer2
                    
                    PlayMatchViewController.player1CurrentPoints = 0
                    PlayMatchViewController.player1CurrentWinners = 0
                    PlayMatchViewController.player2CurrentErrors = 0
                    PlayMatchViewController.currentStrokesToPlayer1 = 0
                    
                    PlayMatchViewController.player2CurrentPoints = 0
                    PlayMatchViewController.player2CurrentWinners = 0
                    PlayMatchViewController.player1CurrentErrors = 0
                    PlayMatchViewController.currentStrokesToPlayer2 = 0
                    
                    self.StepOneWinners.value = 0
                    self.StepTwoWinners.value = 0
                    self.StepOneErrors.value = 0
                    self.StepTwoErrors.value = 0
                    self.StepOneStrokes.value = 0
                    self.StepTwoStrokes.value = 0
                    
                    self.player2GamesLab.text = String(PlayMatchViewController.player2TotalGames)
                    
                    self.PlayOnePoints.text = String(PlayMatchViewController.player1CurrentPoints)
                    self.PlayOneWinners.text = String(PlayMatchViewController.player1CurrentWinners)
                    self.PlayOneErrors.text = String(PlayMatchViewController.player2CurrentErrors)
                    self.PlayOneStrokes.text = String(PlayMatchViewController.currentStrokesToPlayer1)
                    
                    self.PlayTwoPoints.text = String(PlayMatchViewController.player2CurrentPoints)
                    self.PlayTwoWinners.text = String(PlayMatchViewController.player2CurrentWinners)
                    self.PlayTwoErrors.text = String(PlayMatchViewController.player1CurrentErrors)
                    self.PlayTwoStrokes.text = String(PlayMatchViewController.currentStrokesToPlayer2)
                    
                    if (PlayMatchViewController.player2TotalGames == PlayMatchViewController.numGamesToWin)
                    {
                        self.endMatchPostTop.text = "Match Ended!"
                        self.endMatchPostBottom.text = "Now view your stats!"
                        PlayMatchViewController.matchEndedDecider = true
                        self.toStatisticsButton.isHidden = false
                        self.previousButton.isHidden = true
                        self.StepOneWinners.isHidden = true
                        self.StepOneErrors.isHidden = true
                        self.StepOneStrokes.isHidden = true
                        self.StepTwoWinners.isHidden = true
                        self.StepTwoErrors.isHidden = true
                        self.StepTwoStrokes.isHidden = true

                        PlayMatchViewController.player1Won = false
                        PlayMatchViewController.player2Won = true
                    }
                }
                
                let cancel2 = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel){
                    
                    UIAlertAction in
                    
                    PlayMatchViewController.player2CurrentPoints -= 1
                    self.PlayTwoPoints.text = String(PlayMatchViewController.player2CurrentPoints)
                    
                    PlayMatchViewController.currentStrokesToPlayer2 -= 1
                    self.StepTwoStrokes.value -= 1
                    self.PlayTwoStrokes.text = String(PlayMatchViewController.currentStrokesToPlayer2)
                }
                alertController2.addAction(okAction2)
                alertController2.addAction(cancel2)
                
                self.present(alertController2, animated: true, completion: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if(PreMatch.player1TeamName == nil || PreMatch.player1TeamName == "")
        {
            PreMatch.player1TeamName = "Team1"
            player1TeamNameLab.text = PreMatch.player1TeamName
        }
        else if (PreMatch.player1TeamName != nil)
        {
            player1TeamNameLab.text = PreMatch.player1TeamName
        }
        
        if(PreMatch.player2TeamName == nil || PreMatch.player1TeamName == "")
        {
            PreMatch.player2TeamName = "Team 2"
            player2TeamNameLab.text = PreMatch.player2TeamName
        }
        else if (PreMatch.player2TeamName != nil)
        {
            player2TeamNameLab.text = PreMatch.player2TeamName
        }
        
        if(PreMatch.player1Name == nil || PreMatch.player1Name == "")
        {
            PreMatch.player1Name = "Player 1"
            player1NameLab.text = PreMatch.player1Name
        }
        else if (PreMatch.player1Name != nil)
        {
            player1NameLab.text = PreMatch.player1Name
        }
        
        if(PreMatch.player2Name == nil || PreMatch.player2Name == "")
        {
            PreMatch.player2Name = "Player 2"
            player2NameLab.text = PreMatch.player2Name
        }
        else if (PreMatch.player2Name != nil)
        {
            player2NameLab.text = PreMatch.player2Name
        }
        
        PlayMatchViewController.numGamesToWin = PreMatch.numGamesToWin
        
        if(PlayMatchViewController.numGamesToWin <= PlayMatchViewController.player1TotalGames || PlayMatchViewController.numGamesToWin <= PlayMatchViewController.player2TotalGames) {
            PlayMatchViewController.matchEndedDecider = true
        } else {
            PlayMatchViewController.matchEndedDecider = false
        }
        
        if(PlayMatchViewController.matchEndedDecider == true)
        {
            endMatchPostTop.text = "Match Ended!"
            endMatchPostBottom.text = "Now view your stats!"
            toStatisticsButton.isHidden = false
            previousButton.isHidden = true
            self.StepOneWinners.isHidden = true
            self.StepOneErrors.isHidden = true
            self.StepOneStrokes.isHidden = true
            self.StepTwoWinners.isHidden = true
            self.StepTwoErrors.isHidden = true
            self.StepTwoStrokes.isHidden = true
        } else {
            endMatchPostTop.text = ""
            endMatchPostBottom.text = ""
            toStatisticsButton.isHidden = true
            previousButton.isHidden = false
        }
        
        player1GamesLab.text = String(PlayMatchViewController.player1TotalGames)
        player2GamesLab.text = String(PlayMatchViewController.player2TotalGames)
        PlayOnePoints.text = String(PlayMatchViewController.player1CurrentPoints)
        PlayTwoPoints.text = String(PlayMatchViewController.player2CurrentPoints)
        PlayOneWinners.text = String(PlayMatchViewController.player1CurrentWinners)
        PlayOneErrors.text = String(PlayMatchViewController.player1CurrentErrors)
        PlayOneStrokes.text = String(PlayMatchViewController.currentStrokesToPlayer1)
        PlayTwoWinners.text = String(PlayMatchViewController.player2CurrentWinners)
        PlayTwoErrors.text = String(PlayMatchViewController.player2CurrentErrors)
        PlayTwoStrokes.text = String(PlayMatchViewController.currentStrokesToPlayer2)
        
        StepOneWinners.value = Double(PlayMatchViewController.player1CurrentWinners)
        StepTwoWinners.value = Double(PlayMatchViewController.player2CurrentWinners)
        StepOneErrors.value = Double(PlayMatchViewController.player1CurrentErrors)
        StepTwoErrors.value = Double(PlayMatchViewController.player2CurrentErrors)
        StepOneStrokes.value = Double(PlayMatchViewController.currentStrokesToPlayer1)
        StepTwoStrokes.value = Double(PlayMatchViewController.currentStrokesToPlayer2)
        
        StepOneWinners.autorepeat = false
        StepTwoWinners.autorepeat = false
        StepOneErrors.autorepeat = false
        StepTwoErrors.autorepeat = false
        StepOneStrokes.autorepeat = false
        StepTwoStrokes.autorepeat = false
        
        PreMatch.playMatchHasBeenVisited = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

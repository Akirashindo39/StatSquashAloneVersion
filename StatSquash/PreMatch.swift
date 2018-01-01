//
//  PreMatch.swift
//  StatSquash
//
//  Created by Tucker van Eck on 1/14/16.
//  Copyright © 2016 Tucker van Eck and Akira Shindo. All rights reserved.
//

import Foundation
import UIKit


class PreMatch: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    internal static var numGamesToWin = 1
    
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var picker: UIPickerView!
    var pickerData: [String] = [String]()
    @IBOutlet weak var player1NameField: UITextField!
    @IBOutlet weak var player1TeamNameField: UITextField!
    @IBOutlet weak var player2NameField: UITextField!
    @IBOutlet weak var player2TeamNameField: UITextField!
    internal static var player1Name: String!
    internal static var player1TeamName: String!
    internal static var player2Name: String!
    internal static var player2TeamName: String!
    internal static var gameSetting: String!
    internal static var pickerRow = 0
    internal static var previousPickerRow = 0
    internal static var playMatchHasBeenVisited = false
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //Do any additional setup after loading the view, typically from a nib.
        
        // Connect data:
        self.picker.delegate = self
        self.picker.dataSource = self
        
        // Input data into the Array:
        pickerData = ["One Game", "Best of 3 Games", "Best of 5 Games"]
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(PreMatch.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        player1NameField.text = PreMatch.player1Name
        player1TeamNameField.text = PreMatch.player1TeamName
        player2NameField.text = PreMatch.player2Name
        player2TeamNameField.text = PreMatch.player2TeamName
        picker.selectRow(PreMatch.pickerRow, inComponent: 0, animated: false)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // The number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    private func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) -> String? {
        return pickerData[row]
    }

    
    // The data to return for the row and component (column) that's being passed in and stores the game setting into the variable
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        PreMatch.gameSetting = pickerData[row]
        if (PreMatch.gameSetting == "One Game")
        {
                PreMatch.numGamesToWin = 1
                PreMatch.pickerRow = 0
        }
        else if (PreMatch.gameSetting == "Best of 3 Games")
        {
                PreMatch.numGamesToWin = 2
                PreMatch.pickerRow = 1
        }
        else
        {
            PreMatch.numGamesToWin = 3
            PreMatch.pickerRow = 2
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: pickerData[row], attributes: [NSForegroundColorAttributeName:UIColor.orange])
    }
    
    @IBAction func enterPlayer1Name(_ sender: UITextField)
    {
        PreMatch.player1Name = (player1NameField.text)?.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    @IBAction func enterPlayer1TeamName(_ sender: UITextField)
    {
        PreMatch.player1TeamName = (player1TeamNameField.text)?.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    @IBAction func enterPlayer2Name(_ sender: UITextField)
    {
        PreMatch.player2Name = (player2NameField.text)?.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    @IBAction func enterPlayer2TeamName(_ sender: UITextField)
    {
        PreMatch.player2TeamName = (player2TeamNameField.text)?.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    @IBAction func continuePressed(_ sender: UIButton) {
        PreMatch.pickerRow = picker.selectedRow(inComponent: 0)
        if(PreMatch.previousPickerRow > PreMatch.pickerRow && PreMatch.playMatchHasBeenVisited) {
            let alertController = UIAlertController(title: "Not Allowed", message: "You cannot make this change while the match is being played", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                UIAlertAction in
                
                self.picker.selectRow(PreMatch.previousPickerRow, inComponent: 0, animated: true)
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        } else {
            PreMatch.previousPickerRow = PreMatch.pickerRow
            PreMatch.numGamesToWin = PreMatch.pickerRow + 1
            self.performSegue(withIdentifier: "continueSegue", sender: self)
        }
    }

    
}

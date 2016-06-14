//
//  ViewController.swift
//  DonutCalculator
//
//  Created by IMAC on 12/6/16.
//  Copyright © 2016 Andrew's Personal. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }

    @IBOutlet weak var outputLbl: UILabel!
    
    var numberBtnSound: AVAudioPlayer!
    var clearBtnSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Btn Number Sound
        let path = NSBundle.mainBundle().pathForResource("blop", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: path!)
        
        do {
            try numberBtnSound = AVAudioPlayer(contentsOfURL: soundURL)
            numberBtnSound.prepareToPlay()

        } catch let error as NSError{
            print(error.debugDescription)
        }
        
        // Clear Sound
        let clearPath = NSBundle.mainBundle().pathForResource("swoosh", ofType: "wav")
        let clearPathURL = NSURL(fileURLWithPath: clearPath!)
        
        do {
            try clearBtnSound = AVAudioPlayer(contentsOfURL: clearPathURL)
            clearBtnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
            
        }
        
        
        
    }
    
    func playNumberBtnSound() {
        if numberBtnSound.playing {
            numberBtnSound.stop()
        }
        numberBtnSound.play()
    }
    
    func playClearBtnSound() {
        if clearBtnSound.playing {
            clearBtnSound.stop()
        }
        clearBtnSound.play()
    }
    
    
    
    @IBAction func numberBtnPressed(btn: UIButton!) {
        playNumberBtnSound()
        // functions go here...
        
        runningNumber += String(btn.tag)
        outputLbl.text = runningNumber
    }
    
    @IBAction func clearBtnPressed(btn: UIButton!) {
        playClearBtnSound()
        currentOperation = Operation.Empty
        runningNumber = ""
        leftValStr = ""
        rightValStr = ""
        result = ""
        
        
        outputLbl.text = "0"

        
    }
    
    func processOperation(op: Operation) {
        
        playNumberBtnSound()
        
        if currentOperation != Operation.Empty {
            
            if leftValStr == "" {
                leftValStr = "0"
            }
            
            if runningNumber != "" {
                
                
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = String(Double(leftValStr)! * Double(rightValStr)!)
                }
                if currentOperation == Operation.Divide {
                    result = String(Double(leftValStr)! / Double(rightValStr)!)
                }
                if currentOperation == Operation.Subtract {
                    result = String(Double(leftValStr)! - Double(rightValStr)!)
                }
                if currentOperation == Operation.Add {
                    result = String(Double(leftValStr)! + Double(rightValStr)!)
                }
                
                leftValStr = result
                outputLbl.text = result
                
                
                
            }
            
            currentOperation = op
            
        } else {
            
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = op
            
        }
    }
    
    @IBAction func onDividePressed(sender: AnyObject!) {
        playNumberBtnSound()
        processOperation(Operation.Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject!) {
        playNumberBtnSound()
        processOperation(Operation.Multiply)
    }
    
    @IBAction func onSubtractPressed(sender:AnyObject!) {
        playNumberBtnSound()
        processOperation(Operation.Subtract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject!) {
        playNumberBtnSound()
        processOperation(Operation.Add)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject!) {
        playNumberBtnSound()
        processOperation(currentOperation)
    }
    
    
    
    

}


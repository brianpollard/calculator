//
//  ViewController.swift
//  Calculator
//
//  Created by Brian Pollard on 6/8/16.
//  Copyright © 2016 Brian Pollard. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet private weak var display: UILabel!
    
    private var userIsInTheMiddleOfTypingNumber = false    // storing, not calculated
    

    @IBAction private func appendDigit(sender: UIButton)
        {
          let digit = sender.currentTitle!
          if userIsInTheMiddleOfTypingNumber
             {
                let textCurrentlyInDisplay = display.text!
                display.text = textCurrentlyInDisplay + digit
             }
            
             else
                        {
                            display.text = digit
                        }
            
             userIsInTheMiddleOfTypingNumber = true
         }
    
  
    private var displayValue: Double // Calculate, not storing. Tracts whats in the display
        {
            get             // when someone tries to get the display value. Calculate the value of this property
            {
                return Double(display.text!)!
            }
        
            set         // when someone tries to set the displays text.  Calculate the value of this property
            {
                display.text = String(newValue)
        
            }
        

        }
    
    
    
    private var brain = CalculatorBrain()
    

    
    @IBAction private func performeOperation(sender: UIButton)
    {
        if userIsInTheMiddleOfTypingNumber
        {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTypingNumber = false
            
        }
        
        if let mathematicalSymbol = sender.currentTitle
        {
            brain.performOperation(mathematicalSymbol)
        }
        displayValue = brain.result
        
    }
    
}













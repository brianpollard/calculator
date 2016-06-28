//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Brian Pollard on 6/21/16.
//  Copyright © 2016 Brian Pollard. All rights reserved.
//

import Foundation



class CalculatorBrain
{
    private var accumulator = 0.0 // this will accumulate the results
    
    func setOperand(operand: Double) // when someone sets an operand, it resets my accumulator to be what ever that operand is
      {
        accumulator = operand
    
      }
    
    
 
    
   private var operations: Dictionary<String,Operation> =
        [
            "π" : Operation.Constant(M_PI),
            "e" : Operation.Constant(M_E),
            "√" : Operation.UnaryOperation(sqrt),
            "cos" : Operation.UnaryOperation(cos),
            "×" : Operation.BinaryOperation({ $0 * $1 }),
            "÷" : Operation.BinaryOperation({ $0 / $1 }),
            "+" : Operation.BinaryOperation({ $0 + $1 }),
            "−" : Operation.BinaryOperation({ $0 - $1 }),
            "=" : Operation.Equals,
            "c" : Operation.Clear
            
           
        
        ]
    
    
   private enum Operation // these are the associated values
    {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
        case Clear
    

    
    }
    
    
    func performOperation(symbol: String)
      {
        if let operation = operations[symbol]
            {
                switch operation
                {
                  case .Constant(let Value):
                    accumulator = Value
                    
                  case .UnaryOperation(let function):
                    accumulator = function(accumulator) // updating accumulator
                    
                  case .BinaryOperation(let function):
                    executePendingOperation()
                    pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
                    
                  case .Equals:
                      executePendingOperation()
                  
                  case.Clear:
                    accumulator = 0.07
                    
                 }
            }
            
      }
    
    
    private func executePendingOperation()
    {
        if pending != nil
        {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            
            pending = nil // now i no longer have a pending operation anymore
        }
    
    }
    
    private var pending: PendingBinaryOperationInfo?
    
    private struct PendingBinaryOperationInfo // contains the binary function
        {
          var binaryFunction: (Double, Double) -> Double
          var firstOperand: Double // keeping tract of first operand
    
        }
    
    
    var result: Double
        {
            get {
                return accumulator // my result is the current state of my accumulator
                }
        
        }
    
        
}



























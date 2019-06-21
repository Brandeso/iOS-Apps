//
//  HomeViewController.swift
//  iOSCalc
//
//  Created by Bruno Amezcua on 6/19/19.
//  Copyright © 2019 Bruno Amezcua. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var resultLabel: UILabel!
    // Numbers
    @IBOutlet weak var number0: UIButton!
    @IBOutlet weak var number1: UIButton!
    @IBOutlet weak var number2: UIButton!
    @IBOutlet weak var number3: UIButton!
    @IBOutlet weak var number4: UIButton!
    @IBOutlet weak var number5: UIButton!
    @IBOutlet weak var number6: UIButton!
    @IBOutlet weak var number7: UIButton!
    @IBOutlet weak var number8: UIButton!
    @IBOutlet weak var number9: UIButton!
    @IBOutlet weak var numberDecimal: UIButton!
    
    // Operators
    @IBOutlet weak var operatorAC: UIButton!
    @IBOutlet weak var operatorSymbolChange: UIButton!
    @IBOutlet weak var operatorPercentage: UIButton!
    @IBOutlet weak var operatorDivision: UIButton!
    @IBOutlet weak var operatorTimes: UIButton!
    @IBOutlet weak var operatorMinus: UIButton!
    @IBOutlet weak var operatorAddition: UIButton!
    @IBOutlet weak var operatorEquals: UIButton!
    
    // MARK: - Variables
    private var total:Double = 0                                            // Total from our operations
    private var temp:Double = 0                                             // Temporary value shown on calc label
    private var operating:Bool = false                                      // Are doing an operation?
    private var decimal:Bool = false                                        // Indicates us that we are dealing with decimal numbers
    private var operation: OpType = .none                                   // Actual operation
    
    // MARK: - Constants
    private enum OpType {
        case none, addition, substraction, times, division, percentage
    }
    private let kDecimalSeparator = Locale.current.decimalSeparator!
    private let kMaxLength = 9
    private let kMaxValue:Double = 999999999
    private let kMinValue:Double = 0.0000001
    
    // Value Formatting aux
    private let auxFormatter:NumberFormatter = {
        let formatter = NumberFormatter()
        let locale = Locale.current
        formatter.groupingSeparator = ""
        formatter.decimalSeparator = locale.decimalSeparator
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    // Print Formatting aux
    private let printFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        let locale = Locale.current
        formatter.groupingSeparator = ","
        formatter.decimalSeparator = locale.decimalSeparator
        formatter.numberStyle = .decimal
        formatter.maximumIntegerDigits = 9
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 7
        return formatter
    }()
    
    // MARK: - Initialization
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Making Buttons corner-less
        number0.round()
        number1.round()
        number2.round()
        number3.round()
        number4.round()
        number5.round()
        number6.round()
        number7.round()
        number8.round()
        number9.round()
        numberDecimal.round()
        operatorAC.round()
        operatorSymbolChange.round()
        operatorPercentage.round()
        operatorDivision.round()
        operatorTimes.round()
        operatorAddition.round()
        operatorMinus.round()
        operatorEquals.round()
        
        
        // We define correct Decimal separator
        numberDecimal.setTitle(kDecimalSeparator, for: .normal)
        
        // We define first result
        result()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Actions
    @IBAction func operatorACAction(_ sender: UIButton) {
        clear()
        sender.shine()
    }
    @IBAction func operatorSymbolChangeAction(_ sender: UIButton) {
        temp = temp * (-1)
        resultLabel.text = printFormatter.string(from: NSNumber(value: temp))
        sender.shine()
    }
    @IBAction func operatorPercentageAction(_ sender: UIButton) {
        if operation != .percentage {
            result()
        }
        operating = true
        operation = .percentage
        result()
        sender.shine()
    }
    @IBAction func operatorDivisionAction(_ sender: UIButton) {
        if operation != .division {
            result()
        }
        operating = true
        operation = .division
        result()
        sender.shine()
    }
    @IBAction func operatorTimesAction(_ sender: UIButton) {
        if operation != .times {
            result()
        }
        operating = true
        operation = .times
        result()
        sender.shine()
    }
    @IBAction func operatorMinusAction(_ sender: UIButton) {
        if operation != .substraction {
            result()
        }
        operating = true
        operation = .substraction
        result()
        sender.shine()
    }
    @IBAction func operatorAdditionAction(_ sender: UIButton) {
        if operation != .addition {
            result()
        }
        operating = true
        operation = .addition
        result()
        sender.shine()
    }
    @IBAction func operatorEqualsAction(_ sender: UIButton) {
        result()
        sender.shine()
    }
    @IBAction func numberDecimalAction(_ sender: UIButton) {
        let currentTemp = auxFormatter.string(from: NSNumber(value: temp))!
        
        if !operating && currentTemp.count >= kMaxLength {
            return
        }
        if(!decimal){
            operatorAC.setTitle("C", for: .normal)
            resultLabel.text = resultLabel.text! + kDecimalSeparator
        }
        
        decimal = true
        sender.shine()
    }
    
    @IBAction func numberAction(_ sender: UIButton) {
        operatorAC.setTitle("C", for: .normal)
        var currentTemp = auxFormatter.string(from: NSNumber(value: temp))!
        
        if !operating && currentTemp.count >= kMaxLength {
            return
        }
        
        // MARK: - Operating?
        if(operating){
            total = total == 0 ? temp:total
            resultLabel.text = ""
            currentTemp = ""
            operating = false
        }
        if(decimal){
            currentTemp = "\(currentTemp)\(kDecimalSeparator)"
            decimal = false
        }
        
        let number = sender.tag
        temp = Double(currentTemp + String(number))!
        resultLabel.text = printFormatter.string(from: NSNumber(value: temp))
        print(sender.tag)
        sender.shine()
    }
    
    // MARK: - Functions
    private func clear(){
        operation = .none
        decimal = false
        operating = false
        operatorAC.setTitle("AC", for: .normal)
        if temp != 0 {
            temp = 0
            resultLabel.text = "0"
        } else {
            total = 0
            result()
        }
    }
    
    private func result(){
        
            switch operation {
              case .none:
                break
              case .addition:
                total = total + temp
                break
              case .substraction:
                total = total - temp
                break
              case .times:
                total = total * temp
                break
              case .division:
                total = total / temp
                break
              case .percentage:
                temp = temp / 100
                break
            }
        // Screen Formatting
        if total <= kMaxValue && total >= kMinValue {
            resultLabel.text = printFormatter.string(from: NSNumber(value: total))
        } else {
            resultLabel.text = printFormatter.string(from: NSNumber(value: temp))
        }
        
        print("TOTAL \(total)")
        print("TEMP \(temp)")
    }
}

//
//  ViewController.swift
//  Counter
//
//  Created by Diana Viter on 18.08.2024.
//

import UIKit

class ViewController: UIViewController {
    
    private var sarunw: String = ""
    
    @IBOutlet private weak var counterValue: UILabel!
    @IBOutlet private weak var addOneButton: UIButton!
    @IBOutlet private weak var subtractOneButton: UIButton!
    @IBOutlet private weak var resetButton: UIButton!
    @IBOutlet private weak var historyOfChanges: UITextView!
    
    private var counterValueAfterClick: Int = 0
    private var historyArray: [String] = []
    private let initialText = "История изменений: "
    
    override func viewDidLoad() {
        super.viewDidLoad()
        counterValue.text = "Значение счётчика:\n\n0"
        
        historyOfChanges.text = initialText
        historyOfChanges.isEditable = false
    }
    
    private func currentDateAndTime () -> String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy, HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        
        let formattedDate = dateFormatter.string(from: currentDate)
        return formattedDate
    }
    
    private func updateHistoryOfChanges () {
        let historyOfChangeText = historyArray.joined()
        let finalText = "\(initialText)\n\(historyOfChangeText)"
        historyOfChanges.text = finalText
        
        let newTextEndRange = NSRange(location: historyOfChangeText.count, length: 0)
        historyOfChanges.scrollRangeToVisible(newTextEndRange)
    }
    
    @IBAction private func addButtonDidTap(_ sender: Any) {
        counterValueAfterClick += 1
        counterValue.text = "Значение счётчика:\n\n\(counterValueAfterClick)"
        
        let actionDateAndTime = currentDateAndTime()
        historyArray.append("\(actionDateAndTime): значение изменено на +1\n")
        updateHistoryOfChanges ()
    }
    
    @IBAction private func subtractButtonDidTap(_ sender: Any) {
        let actionDateAndTime = currentDateAndTime()
        if counterValueAfterClick > 0 {
            counterValueAfterClick -= 1
            
            counterValue.text = "Значение счётчика:\n\n\(counterValueAfterClick)"
            
            historyArray.append("\(actionDateAndTime): значение изменено на -1\n")
        } else if counterValueAfterClick == 0 {
            historyArray.append("\(actionDateAndTime): попытка уменьшить значение счётчика ниже 0\n")
        }
        updateHistoryOfChanges ()
    }
    
    @IBAction private func resetCounter(_ sender: Any) {
        counterValue.text = "Значение счётчика:\n\n0"
        counterValueAfterClick = 0
        
        let actionDateAndTime = currentDateAndTime()
        historyArray.append("\(actionDateAndTime): значение сброшено\n")
        updateHistoryOfChanges ()
        
    }
}


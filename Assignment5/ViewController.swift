//
//  ViewController.swift
//  Assignment5
//
//  Created by 丸山翔太郎 on 2020/10/26.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var leftField: UITextField!
    @IBOutlet weak var rightField: UITextField!
    private var leftNum:Double?
    private var rightNum:Double?
    
    //計算ボタンを押す
    @IBAction func tapCalcButton(_ sender: Any) {
        if(isEnableCalc()){//計算可能かどうかメソッドで判定
            if let leftNum = leftNum,
               let rightNum = rightNum{
                resultLabel.text = String(leftNum / rightNum)
            }
        }
    }
    
    private func isEnableCalc() ->Bool{
        if(leftField.text!.isEmpty){
            self.present(errorMessage.noInputLeft.returnAlert(), animated: true, completion: nil)
            resultLabel.text = "😡"
            return false
        }else if(rightField.text!.isEmpty){
            self.present(errorMessage.noInputRight.returnAlert(), animated: true, completion: nil)
            resultLabel.text = "😡"
            return false
        }else if(rightNum == 0){
            self.present(errorMessage.divide0.returnAlert(), animated: true, completion: nil)
            resultLabel.text = "😡"
            return false
        }
        return true
    }
    
    //editingDidChanged
    @IBAction func leftFieldHasChanged(_ sender: UITextField) {
        leftNum = Double(sender.text ?? "0.0") ?? 0.0
    }
    
    //editingDidChanged
    @IBAction func rightFIeldHasChanged(_ sender: UITextField) {
        rightNum = Double(sender.text ?? "0.0") ?? 0.0
    }
}

enum errorMessage{
    case divide0
    case noInputLeft
    case noInputRight
    
    func returnAlert()->UIAlertController{
        switch self{
            
        case .divide0:
            let dialog = UIAlertController(title: "エラー", message: "０で除算しました", preferredStyle: .alert)
            dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            return dialog
            
        case .noInputLeft:
            let dialog = UIAlertController(title: "エラー", message: "割られる数の入力がありません", preferredStyle: .alert)
            dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            return dialog
            
        case .noInputRight:
            let dialog = UIAlertController(title: "エラー", message: "割る数の入力がありません", preferredStyle: .alert)
            dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            return dialog
        }
    }
    
}


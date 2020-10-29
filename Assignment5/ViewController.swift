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
    
    // 不用意にStored Propertyを持つと更新し忘れが発生するのでバグの温床となる
    //    private var leftNum:Double?
    //    private var rightNum:Double?
    
    //計算ボタンを押す
    @IBAction func tapCalcButton(_ sender: Any) {
        //        if(isEnableCalc()){//計算可能かどうかメソッドで判定
        //            if let leftNum = leftNum,
        //               let rightNum = rightNum{
        //                resultLabel.text = String(leftNum / rightNum)
        //            }
        //        }
        
        func presentAlert(message: String) {
            let dialog = UIAlertController(title: "エラー", message: message, preferredStyle: .alert)
            dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(dialog, animated: true, completion: nil)
            resultLabel.text = "😡"
        }
        
        // 計算結果を元にしたエラーメッセージの決定はここで行う
        switch divide(leftText: leftField.text, rightText: rightField.text) {
        case .divide0:
            presentAlert(message: "０で除算しました")
        case .noInputLeft:
            presentAlert(message: "割られる数の入力がありません")
        case .noInputRight:
            presentAlert(message: "割る数の入力がありません")
        case let .success(result):
            resultLabel.text = String(result)
        }
    }
    
    // - ラベルの更新
    // - アラートの表示
    // など、isEnableCalc 以上のことをやってしまっているので、メソッド名が嘘をついている
    //    private func isEnableCalc() ->Bool{
    //        if(leftField.text!.isEmpty){
    //            self.present(errorMessage.noInputLeft.returnAlert(), animated: true, completion: nil)
    //            resultLabel.text = "😡"
    //            return false
    //        }else if(rightField.text!.isEmpty){
    //            self.present(errorMessage.noInputRight.returnAlert(), animated: true, completion: nil)
    //            resultLabel.text = "😡"
    //            return false
    //        }else if(rightNum == 0){
    //            self.present(errorMessage.divide0.returnAlert(), animated: true, completion: nil)
    //            resultLabel.text = "😡"
    //            return false
    //        }
    //        return true
    //    }
    
    /// 処理を行い、その結果のみを返す。
    /// アラートの表示などは責務としない。
    private func divide(leftText: String?, rightText: String?) -> DivisionResult {
        guard let leftNum = Double(leftField.text ?? "") else {
            return .noInputLeft
        }
        
        guard let rightNum = Double(rightField.text ?? "") else {
            return .noInputRight
        }
        
        guard rightNum != 0 else {
            return .divide0
        }
        
        return .success(leftNum / rightNum)
    }
    
    // 不要
    //    //editingDidChanged
    //    @IBAction func leftFieldHasChanged(_ sender: UITextField) {
    //        leftNum = Double(sender.text ?? "0.0") ?? 0.0
    //    }
    //
    //    //editingDidChanged
    //    @IBAction func rightFIeldHasChanged(_ sender: UITextField) {
    //        rightNum = Double(sender.text ?? "0.0") ?? 0.0
    //    }
}

// 型の先頭は大文字
// もはやエラーメッセージではないのでリネーム
//enum errorMessage{
enum DivisionResult {
    case success(Double)
    case divide0
    case noInputLeft
    case noInputRight
    
    // DivisionResult は計算結果を表すのであって、
    // それを元にViewへどう反映するか（この場合はアラート）は DivisionResult の責務ではない
    //    func returnAlert()->UIAlertController{
    //        switch self{
    //
    //        case .divide0:
    //            let dialog = UIAlertController(title: "エラー", message: "０で除算しました", preferredStyle: .alert)
    //            dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    //            return dialog
    //
    //        case .noInputLeft:
    //            let dialog = UIAlertController(title: "エラー", message: "割られる数の入力がありません", preferredStyle: .alert)
    //            dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    //            return dialog
    //
    //        case .noInputRight:
    //            let dialog = UIAlertController(title: "エラー", message: "割る数の入力がありません", preferredStyle: .alert)
    //            dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    //            return dialog
    //        }
    //    }
}

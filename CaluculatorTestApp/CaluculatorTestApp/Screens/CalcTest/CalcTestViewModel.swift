//
//  CalcTestViewModel.swift
//  CaluculatorTestApp
//
//  Created by 前田 悟志 (Maeda Satoshi) on 2022/02/26.
//

import Foundation

/// 計算機用のviewmodel
class CalcTestViewModel {
    
    // =============================================================
    // MARK: - enum
    // =============================================================
    /// 計算状態
    enum CalcState {
        /// 何もない状態
        case none
        /// 足す
        case plus
        /// 引く
        case minus
        /// かける
        case multiply
        /// 割る
        case divide
        /// 乗算エラーの時
        case error
    }
    
    // =============================================================
    // MARK: - Private Stored Properties
    // =============================================================
    /// 計算直後か判定
    private var isAfterCalc: Bool = false
    /// 計算するボタンをタップした後で=を押す前か判断
    private var isBeforeCalc: Bool = false
    /// 左辺の値
    private var leftMember: Double = 0
    
    // =============================================================
    // MARK: - Outputs
    // =============================================================
    /// 表示数値
    var screenNumber: String = "0"
    /// 計算状態表示
    var calcState: CalcState = .none
    
    // =============================================================
    // MARK: - Inputs
    // =============================================================
    /// 数値ボタン押下
    func numberButton(number: Int) {
        print("数値ボタン押下: [numberButton] \(number)")
        if isAfterCalc {
            screenNumber = String(number)
            calcState = .none
            print("計算直後のため画面表示を削除し、四則演算をリセット、数値をそのまま画面表示: screenNumber -> \(screenNumber)")
        } else if isBeforeCalc {
            screenNumber = String(number)
            isBeforeCalc = false
            print("四則演算ボタン押下直後のため画面表示を削除し、数値をそのまま画面表示: screenNumber -> \(screenNumber)")
        } else {
            if screenNumber == "0"{
                screenNumber = String(number)
                print("画面表示が0のため、数値をそのまま画面表示: screenNumber -> \(screenNumber)")
            } else {
                let resultNum = numCount(num: "\(screenNumber)\(number)")
                screenNumber = resultNum
                print("表示値が0以外のため、末尾に数値を追加し、桁数調整: screenNumber -> \(screenNumber)")
            }
        }
        // 計算直後ではなくする
        isAfterCalc = false
        
    }
    
    /// 四則演算ボタン押下
    func calcButton(calcButtonType: CalcState) {
        print("四則演算ボタン押下: [calcButton] \(calcButtonType)")
        if calcState != .error {
            // 押下した四則演算ボタンタイプに変更、左辺の追加、計算前にし、計算後ではなくする
            calcState = calcButtonType
            leftMember = Double(screenNumber)!
            isBeforeCalc = true
            isAfterCalc = false
            print("四則演算状態: calcState -> \(calcState)")
            print("左辺: leftMember -> \(leftMember)")
        }
    }
    
    /// 全消去押下
    func allClearButton() {
        print("全消去押下: [allClearButton]")
        // 左辺消去、表示内容0に変更、四則演算中ではなく、計算前でも計算後でもなくする
        leftMember = 0
        screenNumber = "0"
        calcState = .none
        isBeforeCalc = false
        isAfterCalc = false
        print("全消去")
    }
    
    /// =ボタン押下
    func equalButton() {
        
        print("=ボタン押下: [equalButton]")
        
        isAfterCalc = true
        var result: Double = 0
        
        switch calcState {
        case .none:
            print("四則演算ボタンが押下されていないため、四則演算せずリターン")
            return
            
        case .plus:
            result = leftMember + Double(screenNumber)!
            print("加算")
        case .minus:
            result = leftMember - Double(screenNumber)!
            print("減算")
        case .multiply:
            result = leftMember * Double(screenNumber)!
            print("乗算")
        case .divide:
            if screenNumber == "0" {
                calcState = .error
                print("0除算エラー")
                return
            }
            // 除算
            result = leftMember / Double(screenNumber)!
            
        case .error:
            print("エラー時にイコールボタン押下のため、演算しない")
            return
        }
        
        // 最大桁数
        if (abs(result) >= 10000000000 || abs(result) < 0.0001) && result != 0 {
            print("最大桁数オーバーエラー")
            calcState = .error
            return
        }
        
        // 四則演算表示、左辺をなしにする
        calcState = .none
        leftMember = 0
        
        let strResult = numCount(num: String(result))
        /// 小数点以下と以上で分割
        let splitNum = strResult.split(separator: ".")
        
        if splitNum.count > 1 && Int(splitNum[1]) == 0 {
            print("小数点以下が0の場合は、0以下の表示をしない")
            screenNumber = String(splitNum[0])
        } else if strResult.suffix(1) == "."{
            print("桁数調整によって削られてしまい小数がなくなった場合カンマだけの異常を削除")
            screenNumber = strResult.replacingOccurrences(of: ".", with: "")
        } else {
            screenNumber = strResult
        }
        
        print("演算結果: result -> \(result)")
        print("桁数調整: screenNumber -> \(screenNumber)")
    }
    
    /// カンマ押下
    func commaButton() {
        
        print("カンマ押下: [commaButton]")
        
        if isBeforeCalc {
            // 四則演算ボタン押下直後だった場合、0の表示に変更しておく
            numberButton(number: 0)
            print("四則演算ボタン押下直後のため一度0ボタンを押下しておく")
        }
        
        let resultNum = numCount(num: "\(screenNumber).")
        screenNumber = resultNum
        // 計算直後に押した場合はカンマの表示をついかして、計算直後ではなくする
        isAfterCalc = false
        print("カンマ追加: screenNumber -> \(screenNumber)")
    }
    
    /// 戻るボタン押下
    func backButton() {
        print("戻るボタン押下: [backButton]")
        if calcState == .error {
            // エラーなので戻る
            print("エラー中文言削除失敗")
            return
        }
        
        // カウントした数から一つ減らす
        let numberCount = screenNumber.count
        // 計算直後でも四則演算ボタン押下直後でもなくする
        isAfterCalc = false
        isBeforeCalc = false
        
        if numberCount == 1 || (numberCount == 2 && screenNumber.contains("-")){
            // マイナスの場合は二桁、プラスの場合は一桁の時に0に戻す
            screenNumber = "0"
            print("対象桁数以上に削除しようとしているため0に戻す: screenNumber -> \(screenNumber)")
        } else {
            let numStr = screenNumber.prefix(numberCount - 1)
            screenNumber = String(numStr)
            print("一つ文字を戻す: screenNumber -> \(screenNumber)")
        }
    }
    
    /// +/-ボタン押下
    func plusMinusConvertButton() {
        print("+/-ボタン押下: [plusMinusConvertButton]")
        if screenNumber == "0" {
            print("表示が0のためリターン")
            return
        }
        
        // マイナスを含むときはマイナスを削除し、そうでない場合は戦闘にマイナスの追加
        if screenNumber.contains("-") {
            screenNumber = screenNumber.replacingOccurrences(of: "-", with: "")
        } else {
            screenNumber = "-\(screenNumber)"
        }
        print("+/-ボタン押下後: screenNumber -> \(screenNumber)")
    }
    
    /// 四則演算の変換
    func calcStateConvert(calcState: CalcState) -> String {
        switch calcState {
        case .none:
            return ""
        case .plus:
            return "+"
        case .minus:
            return "-"
        case .multiply:
            return "×"
        case .divide:
            return "÷"
        case .error:
            return "E"
        }
    }
    
    // =============================================================
    // MARK: - Private Functions
    // =============================================================
    /// 数値カウント
    private func numCount(num: String) -> String{
        /// 小数点以下と以上で分割
        let splitNum = num.split(separator: ".")
        /// 文字列を切った後の文字
        var numString = ""
        /// 表示桁数最大値が10を超えないように調整、
        /// カンマがはいっても10桁を超えない（小数は9桁になる）
        var maxCount = 10
        if String(num.prefix(1)) == "-" {
            maxCount += 1
        }
        
        if splitNum.count > 1 {
            // カンマが二重で登録されたとしても、このタイミングで削除される
            let uncutNum = "\(splitNum[0]).\(splitNum[1])"
            numString = String(uncutNum.prefix(maxCount))
        }else if num.contains(".") {
            let uncutNum = "\(splitNum[0])."
            numString = String(uncutNum.prefix(maxCount))
        }else {
            numString = String(splitNum[0].prefix(maxCount))
        }
        print("桁数調整前: \(num)")
        print("桁数調整後: \(numString)")
        return numString
    }
    
}

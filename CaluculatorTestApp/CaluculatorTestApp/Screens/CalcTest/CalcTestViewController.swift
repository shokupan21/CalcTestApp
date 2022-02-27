//
//  CalcViewController.swift
//  CaluculatorTestApp
//
//  Created by 前田 悟志 (Maeda Satoshi) on 2022/02/26.
//

import UIKit

class CalcViewController: UIViewController {

    // =============================================================
    // MARK: - Private Stored Properties
    // =============================================================
    private let viewModel = CalcTestViewModel()
    
    // =============================================================
    // MARK: IBOutlets
    // =============================================================
    /// 計算結果
    @IBOutlet weak var calcResultTextField: UITextField!
    /// 四則演算選択中ラベル
    @IBOutlet weak var calcStatusLabel: UILabel!
    
    // =============================================================
    // MARK: ButtonTap
    // =============================================================
    /// 各数値ボタン押下
    @IBAction func _0ButtonTap(_ sender: Any) {
        viewModel.numberButton(number: 0)
        setCalcResult()
    }
    @IBAction func _1ButtonTap(_ sender: Any) {
        viewModel.numberButton(number: 1)
        setCalcResult()
    }
    @IBAction func _2ButtonTap(_ sender: Any) {
        viewModel.numberButton(number: 2)
        setCalcResult()
    }
    @IBAction func _3ButtonTap(_ sender: Any) {
        viewModel.numberButton(number: 3)
        setCalcResult()
    }
    @IBAction func _4ButtonTap(_ sender: Any) {
        viewModel.numberButton(number: 4)
        setCalcResult()
    }
    @IBAction func _5ButtonTap(_ sender: Any) {
        viewModel.numberButton(number: 5)
        setCalcResult()
    }
    @IBAction func _6ButtonTap(_ sender: Any) {
        viewModel.numberButton(number: 6)
        setCalcResult()
    }
    @IBAction func _7ButtonTap(_ sender: Any) {
        viewModel.numberButton(number: 7)
        setCalcResult()
    }
    @IBAction func _8ButtonTap(_ sender: Any) {
        viewModel.numberButton(number: 8)
        setCalcResult()
    }
    @IBAction func _9ButtonTap(_ sender: Any) {
        viewModel.numberButton(number: 9)
        setCalcResult()
    }
    
    /// 各四則演算ボタン押下
    @IBAction func plusButtonTap(_ sender: Any) {
        viewModel.calcButton(calcButtonType: .plus)
        setCalcResult()
    }
    @IBAction func minusButtonTap(_ sender: Any) {
        viewModel.calcButton(calcButtonType: .minus)
        setCalcResult()
    }
    @IBAction func multiplyButtonTap(_ sender: Any) {
        viewModel.calcButton(calcButtonType: .multiply)
        setCalcResult()
    }
    @IBAction func divideButtonTap(_ sender: Any) {
        viewModel.calcButton(calcButtonType: .divide)
        setCalcResult()
    }
    /// 全消去押下
    @IBAction func allClearButtonTap(_ sender: Any) {
        viewModel.allClearButton()
        setCalcResult()
    }
    /// =ボタン押下
    @IBAction func equalButtnoTap(_ sender: Any) {
        viewModel.equalButton()
        setCalcResult()
    }
    /// カンマボタン押下
    @IBAction func commaButtonTap(_ sender: Any) {
        viewModel.commaButton()
        setCalcResult()
    }
    /// 戻るボタン押下
    @IBAction func backButtonTap(_ sender: Any) {
        viewModel.backButton()
        setCalcResult()
    }
    /// +/-ボタン押下
    @IBAction func plusMinusConvertButtonTap(_ sender: Any) {
        viewModel.plusMinusConvertButton()
        setCalcResult()
    }
    // =============================================================
    // MARK: View Life-Cycle Methods
    // =============================================================
    override func viewDidLoad() {
        super.viewDidLoad()
        // 初期設定として四則演算はなし、画面表示は0にする
        viewModel.calcState = .none
        viewModel.screenNumber = "0"
        setCalcResult()
    }

    // =============================================================
    // MARK: - Private Functions
    // =============================================================
    private func setCalcResult() {
        let calcStateText = viewModel.calcStateConvert(calcState: viewModel.calcState)
        self.calcStatusLabel.text = calcStateText
        if viewModel.calcState == .error {
            self.calcResultTextField.text = "エラーのため計算できません"
        } else {
            self.calcResultTextField.text = viewModel.screenNumber
        }
        
    }
    
}


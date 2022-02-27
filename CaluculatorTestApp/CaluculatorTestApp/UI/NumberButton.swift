//
//  NumberButton.swift
//
//  Copyright © 2021 RAVEN Inc. All rights reserved.
//

import UIKit

/// Primaryボタン
///
/// 高さ56
@IBDesignable
public final class NumberButton: UIButton {
    override public init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        configure()

        if let title = title(for: state) {
            let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key(kCTLanguageAttributeName as String): "ja"]

            titleLabel?.attributedText = NSAttributedString(string: title, attributes: attributes)
        }
    }

    private func configure() {
        titleLabel?.font = UIFont(name: "HiraginoSans-W6", size: 30.0)
        titleLabel?.textAlignment = .center
        titleLabel?.numberOfLines = 0

        // デザインを状態別に設定しわける。
        // タイトルカラー
        setTitleColor(UIColor(named: "fill-black"), for: .normal)
        setTitleColor(UIColor(named: "fill-black"), for: .disabled)
        setTitleColor(UIColor(named: "fill-black"), for: .highlighted)
        setTitleColor(UIColor(named: "fill-black"), for: .selected)
        
        let height = frame.height
        let width = frame.width
        
        // color → image
        let primary = createImageFromUIColor(color: UIColor(named: "number-button-primary")!, width: width, height: height)
        let disable = createImageFromUIColor(color: UIColor(named: "button-pressed")!, width: width, height: height)
        let pressed = createImageFromUIColor(color: UIColor(named: "button-pressed")!, width: width, height: height)
        
        // バックグラウンドイメージ
        setBackgroundImage(primary, for: .normal)
        setBackgroundImage(disable, for: .disabled)
        setBackgroundImage(pressed, for: .highlighted)
        setBackgroundImage(pressed, for: .selected)
        
        layer.cornerRadius = 4
        clipsToBounds = true

    }
}



//
//  RoundTextField.swift
//  SnapChatClone
//
//  Created by Khoa on 11/11/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class RoundTextField: UITextField {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
             layer.masksToBounds = cornerRadius > 0
        }
    }
    
    @IBInspectable var borderWidth:CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
    
    @IBInspectable var bgColor: UIColor? {
        didSet {
            layer.backgroundColor = backgroundColor?.cgColor
        }
    }
    
    @IBInspectable var placeholderTextColor: UIColor? {
        didSet {
            let rawString = attributedPlaceholder?.string != nil ? attributedPlaceholder!.string : ""
            let str = NSAttributedString(string: rawString, attributes: [NSForegroundColorAttributeName: placeholderTextColor!])
            attributedPlaceholder = str
        }
    }
    
}

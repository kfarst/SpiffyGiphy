//
//  KeyboardLayoutConstraint.swift
//  Cha Chat
//
//  Created by Kevin Farst on 8/3/17.
//  Copyright © 2017 Kevin Farst. All rights reserved.
//

import Foundation
import UIKit

public class KeyboardLayoutConstraint: NSLayoutConstraint {
    fileprivate var offset: CGFloat = 0
    fileprivate var keyboardVisibleHeight: CGFloat = 0

    override init() {
        super.init()
        
        offset = constant
        
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardLayoutConstraint.keyboardWillShow(_:)), name: Notification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardLayoutConstraint.keyboardWillHide(_:)), name: Notification.Name.UIKeyboardDidHide, object: nil)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        if let userInfo = notification.userInfo {
            if let frameValue = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue {
                let frame = frameValue.cgRectValue
                keyboardVisibleHeight = frame.size.height
            }
            self.updateConstant()
            
            switch(userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber, userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber) {
            case let (.some(duration), .some(curve)) :
                let options = UIViewAnimationOptions(rawValue: curve.uintValue)
                UIView.animate(withDuration: TimeInterval(duration.doubleValue), delay: 0, options: options, animations: {
                    UIApplication.shared.keyWindow?.layoutIfNeeded()
                    return
                }, completion: nil)
            default:
                break
            }
        }
    }
    
    func updateConstant() {
        self.constant = (offset + keyboardVisibleHeight) * -1
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        keyboardVisibleHeight = 0
        self.updateConstant()
        
        if let userInfo = notification.userInfo {
            switch(userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber, userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber) {
            case let (.some(duration), .some(curve)) :
                let options = UIViewAnimationOptions(rawValue: curve.uintValue)
                UIView.animate(withDuration: TimeInterval(duration.doubleValue), delay: 0, options: options, animations: {
                    UIApplication.shared.keyWindow?.layoutIfNeeded()
                    return
                }, completion: nil)
            default:
                break
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

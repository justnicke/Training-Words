//
//  CustomTextField.swift
//  Training Words
//
//  Created by Nikita Sukachev on 19.05.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit

final class CustomTextField: UITextField {
    
    // MARK: - Public Properties
    
    /**
     The color of the border when it has no content.
     
     This property applies a color to the lower edge of the control. The default value for this property is a clear color.
     */
     var borderInactiveBottomColor: UIColor? {
        didSet {
            updateBorder()
        }
    }
    
    /**
     The color of the border when it has content.
     
     This property applies a color to the lower edge of the control. The default value for this property is a clear color.
     */
    var borderActiveBottomColor: UIColor? {
        didSet {
            updateBorder()
        }
    }
    
    /**
     The color of the placeholder text.
     
     This property applies a color to the complete placeholder string. The default value for this property is a "black" color.
     */
    var placeholderColor: UIColor = .black {
        didSet {
            updatePlaceholder()
        }
    }
    
    /**
     The scale of the placeholder font.
     
     This property determines the size of the placeholder label relative to the font size of the text field.
     */
    var placeholderFontScale: CGFloat = 0.50 {
        didSet {
            updatePlaceholder()
        }
    }
    
    override var placeholder: String? {
        didSet {
            updatePlaceholder()
        }
    }
    
    override var bounds: CGRect {
        didSet {
            updateBorder()
            updatePlaceholder()
        }
    }
    
    override var text: String? {
        didSet {
            if let text = text, !text.isEmpty || isFirstResponder {
                animateViewsForTextFocused()
            } else {
                animateViewsForTextUnfocused()
            }
        }
    }
    
    // MARK: - Private Nested
    
    /**
     The type of animation a TextFieldEffect can perform:
     - TextFocussed: animation that takes effect when the textfield has focus.
     - TextUnfocused: animation that takes effect when the textfield loses focus.
     */
    private enum AnimationType: Int {
        case textFocussed
        case textUnfocused
    }
    
    private typealias AnimationCompletionHandler = (_ type: AnimationType) -> (Void)
    
    // MARK: - Private Properties
    
    private var activePlaceholderPoint  = CGPoint.zero
    private let placeholderLabel        = UILabel()
    private let inactiveBorderLayer     = CALayer()
    private let activeBorderLayer       = CALayer()
    private let placeholderInsets       = CGPoint(x: 0, y: 6)
    private let textFieldInsets         = CGPoint(x: 0, y: 12)
    
    private let borderThicknessInactive:    CGFloat = 0.5
    private let borderThicknessActive:      CGFloat = 2
    private var animationCompletionHandler: AnimationCompletionHandler?
    
    // MARK: - Public Methods
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.offsetBy(dx: textFieldInsets.x, dy: textFieldInsets.y)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.offsetBy(dx: textFieldInsets.x, dy: textFieldInsets.y)
    }
    
    override func willMove(toSuperview newSuperview: UIView!) {
        if newSuperview != nil {
            
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(textFieldDidBeginEditing),
                                                   name: UITextField.textDidBeginEditingNotification,
                                                   object: self)
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(textFieldDidEndEditing),
                                                   name: UITextField.textDidEndEditingNotification,
                                                   object: self)
   
        } else {
            NotificationCenter.default.removeObserver(self)
        }
    }
    
    override func draw(_ rect: CGRect) {
        guard isFirstResponder == false else { return }
        drawViewsForRect(rect)
    }
    
    override func drawPlaceholder(in rect: CGRect) { }
    
    // MARK: - Private Methods
    
    // Creates all the animations that are used to leave the textfield in the "entering text" state.=
    private func animateViewsForTextFocused() {
        if text!.isEmpty {
            UIView.animate(withDuration: 0.3,
                           delay: 0.0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 1.0,
                           options: .beginFromCurrentState,
                           animations: ({
                            self.placeholderLabel.frame.origin = CGPoint(x: 10, y: self.placeholderLabel.frame.origin.y)
                            self.placeholderLabel.alpha = 0.0 }),
                           
                           completion: { _ in self.animationCompletionHandler?(.textFocussed) })
        }
        
        layoutPlaceholderInTextRect()
        placeholderLabel.frame.origin = activePlaceholderPoint
        
        UIView.animate(withDuration: 0.4, animations: {
            self.placeholderLabel.alpha = 1.0
        })
        
        activeBorderLayer.frame = rectForBorder(borderThicknessActive, isFilled: true)
    }
    
    // Creates all the animations that are used to leave the textfield in the "display input text" state.
    private func animateViewsForTextUnfocused() {
        if text!.isEmpty {
            UIView.animate(withDuration: 0.35,
                           delay: 0.0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 2.0,
                           options: .beginFromCurrentState,
                           animations: ({
                            self.layoutPlaceholderInTextRect()
                            self.placeholderLabel.alpha = 1 }),
                           
                           completion: { _ in self.animationCompletionHandler?(.textUnfocused) })
            
            activeBorderLayer.frame = self.rectForBorder(borderThicknessActive, isFilled: false)
            inactiveBorderLayer.frame = self.rectForBorder(borderThicknessInactive, isFilled: true)
        }
    }
    
    private func updateBorder() {
        inactiveBorderLayer.frame = rectForBorder(borderThicknessInactive, isFilled: !isFirstResponder)
        inactiveBorderLayer.backgroundColor = borderInactiveBottomColor?.cgColor
        
        activeBorderLayer.frame = rectForBorder(borderThicknessActive, isFilled: isFirstResponder)
        activeBorderLayer.backgroundColor = borderActiveBottomColor?.cgColor
    }
    
    private func updatePlaceholder() {
        placeholderLabel.text = placeholder
        placeholderLabel.textColor = placeholderColor
        placeholderLabel.sizeToFit()
        
        layoutPlaceholderInTextRect()
        
//        if isFirstResponder || !text!.isEmpty {
//            animateViewsForTextFocused()
//        }
    }
    
    private func layoutPlaceholderInTextRect() {
        let textRect = self.textRect(forBounds: bounds)
        var originX = textRect.origin.x
        
        switch self.textAlignment {
        case .center:
            originX += textRect.size.width / 2 - placeholderLabel.bounds.width / 2
        case .right:
            originX += textRect.size.width - placeholderLabel.bounds.width
        default: break
        }
        
        placeholderLabel.frame = CGRect(x: originX,
                                        y: textRect.height / 2,
                                        width: placeholderLabel.bounds.width,
                                        height: placeholderLabel.bounds.height)
        
        activePlaceholderPoint = CGPoint(x: placeholderLabel.frame.origin.x,
                                         y: placeholderLabel.frame.origin.y - placeholderLabel.frame.size.height - placeholderInsets.y)
    }
    
    private func drawViewsForRect(_ rect: CGRect) {
        let frame = CGRect(origin: CGPoint.zero, size: CGSize(width: rect.size.width, height: rect.size.height))
        
        placeholderLabel.frame = frame.insetBy(dx: placeholderInsets.x, dy: placeholderInsets.y)
        placeholderLabel.font = placeholderFontFromFont(font!)
        
        updateBorder()
        updatePlaceholder()
        
        layer.addSublayer(inactiveBorderLayer)
        layer.addSublayer(activeBorderLayer)
        addSubview(placeholderLabel)
    }
    
    private func placeholderFontFromFont(_ font: UIFont) -> UIFont! {
        let smallerFont = UIFont(descriptor: font.fontDescriptor, size: font.pointSize * placeholderFontScale)
        return smallerFont
    }
    
    // The lower border is filled in or not filled in
    private func rectForBorder(_ thickness: CGFloat, isFilled: Bool) -> CGRect {
        if isFilled {
            return CGRect(origin: CGPoint(x: 0, y: frame.height - thickness),
                          size: CGSize(width: frame.width, height: thickness))
        } else {
            return CGRect(origin: CGPoint(x: 0, y: frame.height - thickness),
                          size: CGSize(width: 0, height: thickness))
        }
    }
    
    // The textfield has started an editing session.
    @objc private func textFieldDidBeginEditing() {
        animateViewsForTextFocused()
    }
    
    // The textfield has ended an editing session.
    @objc private func textFieldDidEndEditing() {
        animateViewsForTextUnfocused()
    }
}


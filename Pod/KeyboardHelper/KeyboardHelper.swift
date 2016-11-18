//
// Created by kimtaewan on 2016. 4. 29..
// Copyright (c) 2016 taewan. All rights reserved.
//

import UIKit

open class KeyboardHelper: NSObject {
    
    enum Status {
        case show, hide
    }
    
    struct DefaultInset {
        var bottom: CGFloat = 0
        var indicatorBottom: CGFloat = 0
    }
    
    var status: Status = .hide
    var defaultInset = DefaultInset()
    
    weak var scrollView: UIScrollView?
    
//    open var focusOffset: CGFloat = 0
    
    public init(scrollView: UIScrollView?) {
        super.init()
        self.scrollView = scrollView
        addEvents()
    }
    
    deinit {
        print("deinit KeyboardHelper")
        removeEvents()
    }
}


//MARK - actions
private extension KeyboardHelper {
    func addEvents() {
        guard let scrollView = scrollView else {
            return
        }
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        if scrollView.keyboardDismissMode == .none {
            let gesture = UITapGestureRecognizer(target: self, action: #selector(onLooseKeyboardFocus))
            scrollView.addGestureRecognizer(gesture)
        }
    }
    
    func removeEvents() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc
    func onLooseKeyboardFocus(sender: UITapGestureRecognizer) {
        guard let scrollView = scrollView else {
            return
        }
        scrollView.endEditing(true)
    }
    
    @objc
    func keyboardWillShow(notification: NSNotification) {
        guard let scrollView = self.scrollView else { return }
        if status == .show  { return }
        status = .show
        
        let bottomSpacing = UIScreen.main.bounds.maxY - scrollView.frame.maxY
        
        
        defaultInset.bottom = scrollView.contentInset.bottom
        defaultInset.indicatorBottom = scrollView.scrollIndicatorInsets.bottom
        
        let keyboardHeight = getKeyboardHeight(notification: notification) - bottomSpacing
        
        scrollView.contentInset.bottom = keyboardHeight + defaultInset.bottom
        scrollView.scrollIndicatorInsets.bottom = keyboardHeight + defaultInset.indicatorBottom
       
        /*
        guard let textField = findActiveResponderFrame(view: scrollView) as? UITextField,
            focusOffset != 0 else {
                return
        }
        //textView는 baseLineSpace 무시
        
        var rect = textField.frame
        print(rect)
        rect.origin.y -= focusOffset * 2
        rect.size.height += focusOffset
        print(rect)
        
        let deadline = DispatchTime.now() + 2
        print(deadline)
        
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            print("!!:\(self.scrollView?.contentSize)")
            self.scrollView?.scrollRectToVisible(rect, animated: true)
        }
         */
    }
    
    @objc
    func keyboardWillHide(notification: NSNotification) {
        guard let scrollView = self.scrollView else { return }
        if status == .hide { return }
        status = .hide
        
        scrollView.contentInset.bottom = defaultInset.bottom
        scrollView.scrollIndicatorInsets.bottom = defaultInset.indicatorBottom
    }
    
    func findActiveResponderFrame(view: UIView) -> UIView? {
        if view.isFirstResponder {
            return view
        } else {
            for subview in view.subviews {
                if let found = findActiveResponderFrame(view: subview) {
                    return found
                }
            }
        }
        return nil
    }
    
    func getKeyboardHeight(notification data: NSNotification) -> CGFloat {
        let userInfo: NSDictionary? = data.userInfo as NSDictionary?
        let keyboardFrame: NSValue? = userInfo?.value(forKey: UIKeyboardFrameEndUserInfoKey) as? NSValue
        let keyboardRectangle = keyboardFrame?.cgRectValue
        return keyboardRectangle?.height ?? 0
    }
}

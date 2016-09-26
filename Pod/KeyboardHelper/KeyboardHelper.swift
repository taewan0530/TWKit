//
// Created by kimtaewan on 2016. 4. 29..
// Copyright (c) 2016 taewan. All rights reserved.
//

import UIKit

public class KeyboardHelper: NSObject {
    
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
    
    public var baseLineSpace: CGFloat = 0
    
    public init(scrollView: UIScrollView?) {
        super.init()
        self.scrollView = scrollView
        addEvents()
    }
    
    deinit {
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
        if status == .show || scrollView == nil {
            return
        }
        status = .show
        
        let bottomSpacing = UIScreen.main.bounds.maxY - scrollView!.frame.maxY
        
        
        defaultInset.bottom = scrollView?.contentInset.bottom ?? 0
        defaultInset.indicatorBottom = scrollView?.scrollIndicatorInsets.bottom ?? 0
        
        let keyboardHeight = getKeyboardHeight(notification: notification) - bottomSpacing
        
        scrollView!.contentInset.bottom = keyboardHeight + defaultInset.bottom
        scrollView!.scrollIndicatorInsets.bottom = keyboardHeight + defaultInset.indicatorBottom
        
        guard let textField = findActiveResponderFrame(view: scrollView!) as? UITextField,
            baseLineSpace != 0 else {
                return
        }
        //textView는 baseLineSpace 무시
        
        var rect = textField.frame
        rect.origin.y += baseLineSpace
        
//        let delay = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), Int64(Double(NSEC_PER_SEC) * 0.05))
//        dispatch_after(delay, dispatch_get_main_queue()) {
//            _ in
//            self.scrollView!.scrollRectToVisible(rect, animated: true)
//        }
//        
        let deadline = DispatchTime.now() + (Double(NSEC_PER_SEC) * 0.05)
        DispatchQueue.main.asyncAfter(deadline: deadline) {
             self.scrollView!.scrollRectToVisible(rect, animated: true)
        }
    }
    
    @objc
    func keyboardWillHide(notification: NSNotification) {
        if status == .hide || scrollView == nil {
            return
        }
        status = .hide
        
        scrollView?.contentInset.bottom = defaultInset.bottom
        scrollView?.scrollIndicatorInsets.bottom = defaultInset.indicatorBottom
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

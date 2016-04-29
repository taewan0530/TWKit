//
// Created by kimtaewan on 2016. 4. 29..
// Copyright (c) 2016 taewan. All rights reserved.
//

import UIKit


class KeyboardHelper: NSObject {

    enum Status {
        case Show, Hide
    }

    struct DefaultInset {
        var bottom: CGFloat = 0
        var indicatorBottom: CGFloat = 0
    }

    private var status: Status = .Hide
    private var defaultInset = DefaultInset()
    private weak var scrollView: UIScrollView?

    var baseLineSpace: CGFloat = 0

    init(scrollView: UIScrollView) {
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
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillShow), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillHide), name: UIKeyboardWillHideNotification, object: nil)

        if scrollView.keyboardDismissMode == .None {
            let gesture = UITapGestureRecognizer(target: self, action: #selector(onLooseKeyboardFocus))
            scrollView.addGestureRecognizer(gesture)
        }
    }

    func removeEvents() {
        NSNotificationCenter.defaultCenter().removeObserver(self)
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
        if status == .Show || scrollView == nil {
            return
        }
        status = .Show

        defaultInset.bottom = scrollView!.contentInset.bottom
        defaultInset.indicatorBottom = scrollView!.scrollIndicatorInsets.bottom

        let keyboardHeight = getKeyboardHeight(notification: notification)

        scrollView!.contentInset.bottom = keyboardHeight + defaultInset.bottom
        scrollView!.scrollIndicatorInsets.bottom = keyboardHeight + defaultInset.indicatorBottom

        guard let textField = findActiveResponderFrame(scrollView!) as? UITextField
        where baseLineSpace != 0 else {
            return
        }
        //textView는 baseLineSpace 무시

        var rect = textField.frame
        rect.origin.y += baseLineSpace
        let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(Double(NSEC_PER_SEC) * 0.05))
        dispatch_after(delay, dispatch_get_main_queue()) {
            _ in
            self.scrollView!.scrollRectToVisible(rect, animated: true)
        }
    }

    @objc
    func keyboardWillHide(notification: NSNotification) {
        if status == .Hide || scrollView == nil {
            return
        }
        status = .Hide

        scrollView!.contentInset.bottom = defaultInset.bottom
        scrollView!.scrollIndicatorInsets.bottom = defaultInset.indicatorBottom
    }

    func findActiveResponderFrame(view: UIView) -> UIView? {
        if view.isFirstResponder() {
            return view
        } else {
            for subview in view.subviews {
                if let found = findActiveResponderFrame(subview) {
                    return found
                }
            }
        }
        return nil
    }

    func getKeyboardHeight(notification data: NSNotification) -> CGFloat {
        let userInfo: NSDictionary? = data.userInfo
        let keyboardFrame: NSValue? = userInfo?.valueForKey(UIKeyboardFrameEndUserInfoKey) as? NSValue
        let keyboardRectangle = keyboardFrame?.CGRectValue()
        return keyboardRectangle?.height ?? 0
    }
}

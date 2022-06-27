//
//  BaseVC.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 09/06/2022.
//

import UIKit
import Combine

class BaseVC: UIViewController, KeyboardDismissable {
    var cancellables: Set<AnyCancellable> = []
    
    // Keyboard Dismissable
    var tapDismissesKeyboard: Bool = true
    
    // TODO: is there a way to handle gestures with Combine?
    lazy var keyboardDismissRecognizer: UITapGestureRecognizer? = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.subscribe()
        self.setupKeyboardEventHandling()
    }
    
    func subscribe() {
        //  subscribe to any published objects in here
    }
    
    @objc func dismissKeyboard() {
        if self.tapDismissesKeyboard {
            self.view.endEditing(true)
        }
    }
    
    func setupKeyboardEventHandling() {
        if self.tapDismissesKeyboard,
           let tap = self.keyboardDismissRecognizer {
            self.view.addGestureRecognizer(tap)
        }
        
        NotificationCenter.default
                .publisher(for: UIApplication.keyboardWillChangeFrameNotification)
                .sink(receiveValue: { notification in
                  self.keyboardWillResize(notification)
                })
                .store(in: &cancellables)
    }
    
    var keyboardRect: CGRect?
    
    func keyboardWillResize(_ notification: Notification) {
        self.keyboardRect =
            (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
    }
}

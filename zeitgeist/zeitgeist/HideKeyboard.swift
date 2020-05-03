//
//  HideKeyboard.swift
//  zeitgeist
//
//  Created by Jari Pietikäinen on 31.3.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import SwiftUI

extension UIApplication {
    // Hide keyboard
    func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}
// Hide keyboard when dragged
struct ResignKeyboardOnDragGesture: ViewModifier {
    var gesture = DragGesture().onChanged{_ in
        UIApplication.shared.endEditing(true)
    }
    func body(content: Content) -> some View {
        content.gesture(gesture)
    }
}
// Hide keyboard when dragged extension
extension View {
    func resignKeyboardOnDragGesture() -> some View {
        modifier(ResignKeyboardOnDragGesture())
    }
}
// Called when hiding keyboard
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    // Hides keyboard
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

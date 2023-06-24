//
//  HideKeyboardExtension.swift
//  Devote
//
//  Created by Lori Rothermel on 6/22/23.
//

import SwiftUI

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif


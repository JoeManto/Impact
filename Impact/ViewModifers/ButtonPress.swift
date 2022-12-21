//
//  ButtonPress.swift
//  Impact
//
//  Created by Joe Manto on 11/25/22.
//

import Foundation
import SwiftUI

struct ButtonPress: ViewModifier {
    var onTouchDown: () -> Void
    var onRelease: () -> Void
    @State private var isPressing: Bool = false
    
    func body(content: Content) -> some View {
        let dragGesture = DragGesture(minimumDistance: 0)
            .onEnded { _ in
                if !self.isPressing {
                    self.isPressing = true
                    self.onTouchDown()
                }
            }
            .onChanged { _ in
                self.onRelease()
                self.isPressing = false
            }
        return content
            .simultaneousGesture(dragGesture)
    }
}

extension View {
    func onTouch(onTouchDown: @escaping () -> Void, onRelease: @escaping () -> Void) -> some View {
        modifier(ButtonPress(onTouchDown: onTouchDown, onRelease: onRelease))
    }
}

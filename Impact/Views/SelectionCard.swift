//
//  SelectionCard.swift
//  Impact
//
//  Created by Joe Manto on 11/26/22.
//

import Foundation
import SwiftUI

struct Selection: View {
    
    @Environment(\.colorScheme) var scheme
    @ObservedObject var model: SelectionModel
    
    @State var isPressing: Bool = false
    
    var onTap: ((SelectionModel) -> Void)?
    
    init(model: SelectionModel, onTap: ((SelectionModel) -> Void)? = nil) {
        self.model = model
        self.onTap = onTap
    }
    
    var body: some View {
        HStack {
            VStack {
                Image(systemName: model.symbol)
                    .bold()
                    .font(Font.title)
                    .foregroundColor(model.foregroundColor)
                
                Text("\(model.name)")
                    .font(Font.caption)
                    .bold()
                    .foregroundColor(model.foregroundColor)
            }
            .padding(4)
        }
        .fixedSize(horizontal: false, vertical: true)
        .padding(5)
        .background(scheme == .dark ? Color(red: 5.0/255, green: 5.0/255, blue: 30.0/255) : .white)
        .cornerRadius(9)
        .shadow(radius: 5, y: 5)
        .shake(intensity: isPressing ? .normal : .none)
        .onTouch {
            HapticFeedbackService.shared.execute(from: self.model)
            
            withAnimation(.easeIn(duration: 0.25)) {
                self.isPressing = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now().advanced(by: .milliseconds(400))) {
                self.isPressing = false
            }
        } onRelease: {
            self.onTap?(self.model)
        }
    }
}

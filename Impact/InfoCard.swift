//
//  InfoCard.swift
//  Impact
//
//  Created by Joe Manto on 11/26/22.
//

import Foundation
import SwiftUI

struct InfoCard: View {
    
    let model: SelectionModel
    
    var body: some View {
        VStack {
            VStack {
                Text(model.getLevelInfoBlock())
                    .frame(maxWidth: Double.infinity, alignment: .leading)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(10)
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.gray, style: StrokeStyle(lineWidth: 0.5))
                    .opacity(1)
            }
        }
        .padding(10)
    }
}


struct InfoCard_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            InfoCard(model: SelectionModel(type: .impact, level: .soft))
        }
    }
}

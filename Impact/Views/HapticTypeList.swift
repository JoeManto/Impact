//
//  HapticStrengthController.swift
//  Impact
//
//  Created by Joe Manto on 11/21/22.
//

import Foundation
import SwiftUI

struct HapticTypeList: View {
    
    @State var intensity: CGFloat = 0.5
    
    @ObservedObject var vm: HapticTypeListViewModel
    
    var body: some View {
        VStack {
            
            Text(self.vm.getSelected().type.rawValue)
                .font(Font.system(.title, weight: .heavy))
                .frame(maxWidth: Double.infinity, alignment: .leading)
                .padding([.leading, .top])
                .padding(.bottom, 5)
            
            Text(self.vm.getSelected().getTypeInfoBlock())
                .font(Font.system(.subheadline, weight: .regular))
                .frame(maxWidth: Double.infinity, alignment: .leading)
                .padding([.leading, .bottom, .trailing])
            
            if self.vm.getSelected().type == .impact {
                self.intensitySlider()
                    .padding([.leading, .trailing], 20)
                    .padding(.bottom, 10)
            }
               
            ScrollViewReader { reader in
                HStack {
                    ForEach(vm.selections) {
                        Selection(model: $0, onTap: { model in
                            withAnimation(.easeIn(duration: 0.2)) {
                                reader.scrollTo(model.asInfoBlock().id)
                            }
                        })
                    }
                }
                
                if vm.getSelected().type != .selection {
                    GeometryReader { geo in
                        VStack {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(vm.getInfoBlocks(), id: \.id) { selection in
                                        InfoCard(model: selection)
                                            .frame(width: geo.size.width)
                                    }
                                }
                            }
                            .disabled(true)
                        }
                    }
                }
             }
        }
    }
    
    @ViewBuilder func intensitySlider() -> some View {
        HStack {
            VStack {
                Text("Intensity")
                    .bold()
                Text(String(format: "%.2f", self.intensity))
                    .padding(.trailing, 10)
            }
            .frame(width: 100, alignment: .leading)
            
            Slider(value: self.$intensity, in: 0.0...1.0) { editing in
                self.vm.updateIntensity(self.intensity)
            }
        }
    }
}

struct HapticTypeList_Previews: PreviewProvider {
    static var previews: some View {
        HapticTypeList(vm: HapticTypeListViewModel(selections: [
            SelectionModel(type: .impact, level: .soft),
            SelectionModel(type: .impact, level: .light),
            SelectionModel(type: .impact, level: .medium),
            SelectionModel(type: .impact, level: .rigid),
            SelectionModel(type: .impact, level: .heavy)
        ]))
    }
}

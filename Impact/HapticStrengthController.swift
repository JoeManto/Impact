//
//  HapticStrengthController.swift
//  Impact
//
//  Created by Joe Manto on 11/21/22.
//

import Foundation
import SwiftUI

class HapticTypeListViewModel: ObservableObject {
    var selections: [SelectionModel]
    private(set) var selectedIndex = 0
    
    private var intensity: CGFloat = 0.5
   
    init(selections: [SelectionModel]) {
        // Todo init selected from user defaults
        self.selections = selections
    }
    
    func updateIntensity(_ intensity: CGFloat) {
        for i in 0..<selections.count {
            self.selections[i].intensity = intensity
        }
    }
    
    func setSelected(index: Int) {
        guard 0..<selections.count ~= index else {
            return
        }
        
        self.selectedIndex = index
    }
    
    func getSelected() -> SelectionModel {
        return selections[selectedIndex]
    }
    
    func getInfoBlocks() -> [SelectionModel] {
        return self.selections.map {
            $0.isInfoBlock = true
            return $0
        }
    }
}

struct HapticTypeList: View {
    
    let type: SelectionModel.SelectionType
    @State var intensity: CGFloat = 0.5
    
    @ObservedObject var vm: HapticTypeListViewModel
    
    var body: some View {
        VStack {
            
            Text(self.type.rawValue)
                .font(Font.system(.title, weight: .heavy))
                .frame(maxWidth: Double.infinity, alignment: .leading)
                .padding([.leading, .top])
                .padding(.bottom, 5)
            
            Text(self.vm.getSelected().getTypeInfoBlock())
                .font(Font.system(.subheadline, weight: .regular))
                .frame(maxWidth: Double.infinity, alignment: .leading)
                .padding([.leading, .bottom, .trailing])
            
            if type == .impact {
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

struct HapticStrengthController_Previews: PreviewProvider {
    static var previews: some View {
        HapticTypeList(type: .impact, vm: HapticTypeListViewModel(selections: [
            SelectionModel(type: .impact, level: .soft),
            SelectionModel(type: .impact, level: .light),
            SelectionModel(type: .impact, level: .medium),
            SelectionModel(type: .impact, level: .rigid),
            SelectionModel(type: .impact, level: .heavy)
        ]))
    }
}

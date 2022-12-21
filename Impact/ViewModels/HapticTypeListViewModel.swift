//
//  HapticTypeListViewModel.swift
//  Impact
//
//  Created by Joe Manto on 12/20/22.
//

import Foundation

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

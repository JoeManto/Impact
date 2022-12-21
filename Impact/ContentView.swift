//
//  ContentView.swift
//  Impact
//
//  Created by Joe Manto on 11/21/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        //BasicView()
        HapticTableView()
    }
}

struct HapticTableView: View {
    var body: some View {
        List {
            Group {
                HapticTypeList(type: .impact, vm: HapticTypeListViewModel(selections: [
                    SelectionModel(type: .impact, level: .light),
                    SelectionModel(type: .impact, level: .soft),
                    SelectionModel(type: .impact, level: .medium),
                    SelectionModel(type: .impact, level: .rigid),
                    SelectionModel(type: .impact, level: .heavy)
                ]))
                .padding(.bottom, 100)
            }

            Group {
                HapticTypeList(type: .notif, vm: HapticTypeListViewModel(selections: [
                    SelectionModel(type: .notif, level: .success),
                    SelectionModel(type: .impact, level: .warning),
                    SelectionModel(type: .impact, level: .error)
                ]))
                .padding(.bottom, 100)
            }

            Group {
                HapticTypeList(type: .selection, vm: HapticTypeListViewModel(selections: [
                    SelectionModel(type: .selection, level: .selection)
                ]))
                .padding(.bottom, 100)

            }
  
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

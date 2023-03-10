//
//  SelectionModel.swift
//  Impact
//
//  Created by Joe Manto on 12/20/22.
//

import Foundation
import SwiftUI

class SelectionModel: Identifiable, ObservableObject {
    
    enum SelectionType: String {
        case notif = "Notification"
        case impact = "Impact"
        case selection = "Selection"
    }
    
    enum SelectionLevel: String, CaseIterable {
        case medium = "Med"
        case light = "Light"
        case soft = "Soft"
        case rigid = "Rigid"
        case heavy = "Heavy"
        case success = "Success"
        case warning = "Warning"
        case error = "Error"
        case selection = "Selection"
    }
    
    var id: String { type.rawValue + level.rawValue + (isInfoBlock ? "-info" : "") }
    
    var isInfoBlock: Bool = false
    
    let type: SelectionType
    let level: SelectionLevel
    @Published var intensity: CGFloat = 0.5
    
    var name: String {
        level.rawValue
    }
    
    var symbol: String {
        switch level {
        case .error:
            return "aqi.high"
        case .medium, .warning, .heavy, .rigid:
            return "aqi.medium"
        case .light, .soft, .success, .selection:
            return "aqi.low"
        }
    }
    
    var foregroundColor: Color {
        switch level {
        case .heavy, .rigid, .error:
            return .red
        case .medium, .warning:
            return .orange
        case .light, .soft, .success, .selection:
            return .green
        }
    }
    
    var highlightColor: Color {
        self.foregroundColor
    }
    
    init(type: SelectionType, level: SelectionLevel, isInfoBlock: Bool = false) {
        self.type = type
        self.level = level
        self.isInfoBlock = isInfoBlock
    }
    
    func getTypeInfoBlock() -> String {
        switch type {
        case .selection:
            return "Use selection feedback to communicate movement through a series of discrete values"
        case .impact:
            return "Use impact feedback to indicate that an impact has occurred. For example, you might trigger impact feedback when a user interface object collides with another object or snaps into place"
        case .notif:
            return "Use notification feedback to communicate that a task or action has succeeded, failed, or produced a warning of some kind"
        }
    }
    
    func getLevelInfoBlock() -> String {
        switch level {
        case .heavy:
            return "A collision between large, heavy user interface elements"
        case .rigid:
            return "A collision between user interface elements that are rigid, exhibiting a small amount of compression or elasticity"
        case .error:
            return "Feedback type that indicates a task has failed"
        case .medium:
            return "A collision between moderately sized user interface elements"
        case .warning:
            return "Feedback type that indicates a task has produced a warning"
        case .light:
            return "A collision between small, light user interface elements"
        case .soft:
            return "A collision between user interface elements that are soft, exhibiting a large amount of compression or elasticity"
        case .success:
            return "Feedback type that indicates a task has completed successfully"
        case .selection:
            return ""
        }
    }
    
    func asInfoBlock() -> Self {
        let new = self
        new.isInfoBlock = true
        return new
    }
}

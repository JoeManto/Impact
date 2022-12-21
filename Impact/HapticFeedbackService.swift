//
//  HapticFeedbackService.swift
//  Impact
//
//  Created by Joe Manto on 11/26/22.
//

import Foundation
import UIKit

class HapticFeedbackService {
    
    static let shared = HapticFeedbackService()
    
    private init() {}
    
    func execute(from selection: SelectionModel) {
        let level = selection.level
        switch selection.type {
        case .impact:
            self.executeImpact(for: level, intensity: selection.intensity)
        case .notif:
            self.executeNotification(for: level)
        case .selection:
            self.executeSelection()
        }
    }
    
    private func executeImpact(for level: SelectionModel.SelectionLevel, intensity: CGFloat) {
        let style: UIImpactFeedbackGenerator.FeedbackStyle = {
            if level == .heavy {
                return .heavy
            }
            else if level == .rigid {
                return.rigid
            }
            else if level == .medium {
                return .medium
            }
            else if level == .soft {
                return .soft
            }
            else {
                return.light
            }
        }()

        let impactGenerator = UIImpactFeedbackGenerator(style: style)
        impactGenerator.impactOccurred(intensity: intensity)
    }

    private func executeNotification(for level: SelectionModel.SelectionLevel) {
        let notificationGenerator = UINotificationFeedbackGenerator()
        
        let style: UINotificationFeedbackGenerator.FeedbackType = {
            if level == .success {
                return .success
            }
            else if level == .warning {
                return .warning
            }
            else {
                return .error
            }
        }()
        
        notificationGenerator.notificationOccurred(style)
    }
    
    private func executeSelection() {
        let selectionGenerator = UISelectionFeedbackGenerator()
        selectionGenerator.selectionChanged()
    }
    
}

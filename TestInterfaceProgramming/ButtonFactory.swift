//
//  ButtonFactory.swift
//  TestInterfaceProgramming
//
//  Created by Alexey Turulin on 7/31/23.
//

import UIKit

protocol ButtonFactory {
    func createButton() -> UIButton
}

final class FilledButtonFactory: ButtonFactory {
    
    let title: String
    let color: UIColor
    let action: UIAction
    
    init(title: String, color: UIColor, action: UIAction) {
        self.title = title
        self.color = color
        self.action = action
    }
    
    func createButton() -> UIButton {
        var attributes = AttributeContainer()
        attributes.font = .boldSystemFont(ofSize: 18)
        
        var buttonConfig = UIButton.Configuration.filled()
        buttonConfig.attributedTitle = AttributedString(title, attributes: attributes)
        buttonConfig.baseBackgroundColor = color
        
        let button = UIButton(configuration: buttonConfig, primaryAction: action)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }
}

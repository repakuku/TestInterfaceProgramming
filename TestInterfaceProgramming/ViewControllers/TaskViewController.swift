//
//  TaskViewController.swift
//  TestInterfaceProgramming
//
//  Created by Алексей Турулин on 7/31/23.
//

import UIKit

final class TaskViewController: UIViewController {
    
    unowned var delegate: TaskViewControllerDelegate!
    
    private let storageManager = StorageManager.shared
    
    var task: Task?
    
    private lazy var taskTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "New Task"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var saveButton: UIButton = {
        var attributes = AttributeContainer()
        attributes.font = .boldSystemFont(ofSize: 18)
        var buttonConfig = UIButton.Configuration.filled()
        buttonConfig.buttonSize = .medium
        buttonConfig.attributedTitle = AttributedString("Save Task", attributes: attributes)
        buttonConfig.baseBackgroundColor = UIColor(named: "MainBlue")
        let button = UIButton(
            configuration: buttonConfig,
            primaryAction: UIAction { [unowned self] _ in
            save()
        })
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var cancelButton: UIButton = {
        let filledButtonFactory = FilledButtonFactory(
            title: "Cancel",
            color: UIColor(named: "MainRed") ?? .systemRed,
            action: UIAction { [unowned self] _ in
                dismiss(animated: true)
            })
        let button = filledButtonFactory.createButton()
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSubviews(taskTextField, saveButton, cancelButton)
        setupConstraints()
        
        if let task {
            taskTextField.text = task.title
        }
    }
    
    private func setupSubviews(_ subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate(
            [
                taskTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
                taskTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
                taskTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                saveButton.topAnchor.constraint(equalTo: taskTextField.bottomAnchor, constant: 20),
                saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
                saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                cancelButton.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 20),
                cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
                cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
            ]
        )
    }
    
    private func save() {
        if let task {
            let newTitle = taskTextField.text ?? ""
            storageManager.update(task, with: newTitle)
        } else {
            storageManager.save(taskTextField.text ?? "") { task in
                print(task.title ?? "")
            }
        }
        delegate.reloadData()
        dismiss(animated: true)
    }
}

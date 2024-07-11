//
//  FAlertView.swift
//  Filmatica
//
//  Created by Siros Taib on 7/10/24.
//

import UIKit

class KFAlertVC: UIViewController {

    // MARK: - Properties
    let containerView = UIView()
    let titleLabel = FTitleLabel(textAlignment: .center, fontSize: 20)
    let bodyTextLabel = FBodyLabel(textAlignment: .center)
    let actionButton = KFButton(bgColor: .systemTeal, title: "Okay")

    var alertTitleValue: String?
    var bodyTextValue: String?
    var buttonTitleValue: String?

    let padding: CGFloat = 20

    // MARK: - Initializers
    init(alertTitle: String, bodyText: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitleValue = alertTitle
        self.bodyTextValue = bodyText
        self.buttonTitleValue = buttonTitle
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Main Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        setupContainerUI()
        setupTitleLabelUI()
        setupActionButton()
        setupBodyLabelUI()
    }

    // MARK: - Setup UI Layout
    private func setupContainerUI() {
        view.addSubview(containerView)
        containerView.layer.cornerRadius = 20
        containerView.layer.borderWidth = 3
        containerView.layer.borderColor = UIColor.white.cgColor
        containerView.backgroundColor = .systemBackground
        containerView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 250)

        ])
    }

    private func setupTitleLabelUI() {
        containerView.addSubview(titleLabel)
        titleLabel.text = alertTitleValue ?? "Something went wrong man!"

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 30)
        ])

    }

    private func setupBodyLabelUI() {
        containerView.addSubview(bodyTextLabel)
        bodyTextLabel.text = bodyTextValue ?? "We were unable to complete this function"
        bodyTextLabel.numberOfLines = 4

        NSLayoutConstraint.activate([
            bodyTextLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            bodyTextLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            bodyTextLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            bodyTextLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -10)
        ])
    }

    private func setupActionButton() {
        containerView.addSubview(actionButton)
        actionButton.setTitle(buttonTitleValue ?? "OK", for: .normal)
        addDissmissTarget()

        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }

    // MARK: - other methods
    @objc private func dissmissAlertVC() {
        dismiss(animated: true)
    }

    func addDissmissTarget() {
        actionButton.addTarget(self, action: #selector(dissmissAlertVC), for: .touchUpInside)
    }
}

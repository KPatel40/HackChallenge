//
//  OrganizeTable.swift
//  VinylCollection
//
//  Created by Krishna Patel
//

import UIKit
import SQLite

protocol UpdateCellDelegate: AnyObject {
    func updateVinyl(id: Int64, name: String, artist: String, year: String)
}

class OrganizeTable: UIViewController {

    private let image = UIImageView()
    private let nameTextField = UITextField()
    private let artistTextField = UITextField()
    private let yearTextField = UITextField()
    private let changeButton = UIButton()

    weak var delegate: UpdateCellDelegate?
    private let vinyl: VinylData

    init(vinyl: VinylData) {
        self.vinyl = vinyl
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 173/255.0, green: 216/255.0, blue: 230/255.0, alpha: 1.0)
        setupUI()
        configureUI(with: vinyl)
    }

    private func setupUI() {
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        view.addSubview(image)

        nameTextField.font = .systemFont(ofSize: 20)
        nameTextField.backgroundColor = .systemGray3
        nameTextField.layer.cornerRadius = 5
        nameTextField.clipsToBounds = true
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.textAlignment = .center
        view.addSubview(nameTextField)

        artistTextField.font = .systemFont(ofSize: 20)
        artistTextField.backgroundColor = .systemGray3
        artistTextField.layer.cornerRadius = 5
        artistTextField.clipsToBounds = true
        artistTextField.translatesAutoresizingMaskIntoConstraints = false
        artistTextField.textAlignment = .center
        view.addSubview(artistTextField)

        yearTextField.font = .systemFont(ofSize: 20)
        yearTextField.backgroundColor = .systemGray3
        yearTextField.layer.cornerRadius = 5
        yearTextField.clipsToBounds = true
        yearTextField.translatesAutoresizingMaskIntoConstraints = false
        yearTextField.textAlignment = .center
        view.addSubview(yearTextField)

        changeButton.setTitle("Change", for: .normal)
        changeButton.setTitleColor(.white, for: .normal)
        changeButton.backgroundColor = .systemBlue
        changeButton.layer.cornerRadius = 10
        changeButton.clipsToBounds = true
        changeButton.translatesAutoresizingMaskIntoConstraints = false
        changeButton.addTarget(self, action: #selector(changeButtonTapped), for: .touchUpInside)
        view.addSubview(changeButton)

        NSLayoutConstraint.activate([
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            image.widthAnchor.constraint(equalToConstant: 200),
            image.heightAnchor.constraint(equalToConstant: 200),

            nameTextField.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 20),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameTextField.heightAnchor.constraint(equalToConstant: 40),

            artistTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            artistTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            artistTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            artistTextField.heightAnchor.constraint(equalToConstant: 40),

            yearTextField.topAnchor.constraint(equalTo: artistTextField.bottomAnchor, constant: 20),
            yearTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            yearTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            yearTextField.heightAnchor.constraint(equalToConstant: 40),

            changeButton.topAnchor.constraint(equalTo: yearTextField.bottomAnchor, constant: 20),
            changeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            changeButton.widthAnchor.constraint(equalToConstant: 100),
            changeButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func configureUI(with vinyl: VinylData) {
        // image.image = UIImage(named: vinyl.img) // Add actual image handling
        nameTextField.text = vinyl.name
        artistTextField.text = vinyl.artist
        yearTextField.text = vinyl.year
    }

    @objc private func changeButtonTapped() {
        guard let name = nameTextField.text,
              let artist = artistTextField.text,
              let year = yearTextField.text else { return }
        delegate?.updateVinyl(id: vinyl.id, name: name, artist: artist, year: year)
        navigationController?.popViewController(animated: true)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  OrganizeTable.swift
//  Hack Challenge
//
//  Created by Krishna Patel on 5/4/23.
//

import UIKit

class OrganizeTable: UIViewController {

    let image = UIImageView()
    let text = UITextField()
    let text2 = UITextField()
    let text3 = UITextField()
    let changeButton = UIButton()

    weak var del: updateCell?
    let vinyl: VinylData

    init(vinyl: VinylData) {
        self.vinyl = vinyl
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 173/255.0, green: 216/255.0, blue: 230/255.0, alpha: 1.0)

        image.image = UIImage(named:vinyl.img)
        image.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(image)

        text.text = vinyl.name
        text.font = .systemFont(ofSize: 30)
        text.backgroundColor = .systemGray3
        text.layer.cornerRadius = 3
        text.clipsToBounds = true
        text.textAlignment = .center
        text.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(text)
        
        text2.text = vinyl.artist
        text2.font = .systemFont(ofSize: 30)
        text2.backgroundColor = .systemGray3
        text2.layer.cornerRadius = 3
        text2.clipsToBounds = true
        text2.textAlignment = .center
        text2.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(text2)
        
        text3.text = vinyl.year
        text3.font = .systemFont(ofSize: 30)
        text3.backgroundColor = .systemGray3
        text3.layer.cornerRadius = 3
        text3.clipsToBounds = true
        text3.textAlignment = .center
        text3.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(text3)

        changeButton.setTitle("Change", for: .normal)
        changeButton.setTitleColor(.systemBlue, for: .normal)
        changeButton.addTarget(self, action: #selector(changeContactCell), for: .touchUpInside)
        changeButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(changeButton)

        setupConstraints()
    }

    @objc func changeContactCell() {
        if let text = text.text {
            del?.updateTitle(name: text)
        }
        if let text2 = text2.text {
            del?.updateArtist(name: text2)
        }
        if let text3 = text3.text {
            del?.updateGenre(name: text3)
        }
        navigationController?.popViewController(animated: false)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            image.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            image.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5)
        ])

        NSLayoutConstraint.activate([
            text.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 10),
            text.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            text.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
        
        NSLayoutConstraint.activate([
            text2.topAnchor.constraint(equalTo: text.bottomAnchor, constant: 10),
            text2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            text2.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
        
        NSLayoutConstraint.activate([
            text3.topAnchor.constraint(equalTo: text2.bottomAnchor, constant: 10),
            text3.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            text3.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])

        NSLayoutConstraint.activate([
            changeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            changeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

protocol updateCell: UIViewController {
    func updateTitle(name: String)
    func updateArtist(name: String)
    func updateGenre(name: String)
}


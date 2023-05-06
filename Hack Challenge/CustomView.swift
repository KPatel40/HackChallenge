//
//  CustomView.swift
//  Hack Challenge
//
//  Created by Krishna Patel on 5/4/23.
//


import UIKit

class CustomView: UITableViewCell {

    let vinylPic = UIImageView()
    let title = UILabel()
    let artist = UILabel()
    let genre = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        vinylPic.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(vinylPic)
        
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont.systemFont(ofSize: 10)
        self.contentView.addSubview(title)
        
        artist.translatesAutoresizingMaskIntoConstraints = false
        artist.font = UIFont.systemFont(ofSize: 10)
        self.contentView.addSubview(artist)
        
        genre.translatesAutoresizingMaskIntoConstraints = false
        genre.font = UIFont.systemFont(ofSize: 10)
        self.contentView.addSubview(genre)
        
        setUpConstraints()
    }
    
    func setUpConstraints() {
        
        NSLayoutConstraint.activate([
            vinylPic.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            vinylPic.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            vinylPic.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.10),
            vinylPic.heightAnchor.constraint(equalTo: vinylPic.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: vinylPic.trailingAnchor, constant: 30),
            title.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            artist.leadingAnchor.constraint(equalTo: title.trailingAnchor, constant: 30),
            artist.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            genre.leadingAnchor.constraint(equalTo: artist.trailingAnchor, constant: 30),
            genre.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        ])
            
    }
    
    func updateFrom(vinyl: VinylData) {
        title.text = vinyl.name
        artist.text = vinyl.artist
        vinylPic.image = UIImage(named: vinyl.img)
        genre.text = vinyl.year
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


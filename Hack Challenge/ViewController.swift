//
//  ViewController.swift
//  Hack Challenge
//
//  Created by Krishna Patel on 5/2/23.
//

import UIKit

class ViewController: UIViewController {

    var vinyls: [VinylData] = []
    let tableView1 = UITableView()
    var currentIndex = IndexPath()
    let reuseID = "My List"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "My Vinyl Collection"
        view.backgroundColor = UIColor(red: 173/255.0, green: 216/255.0, blue: 230/255.0, alpha: 1.0)
        
        NetworkManager.shared.getAllMessages { vinyls in
            DispatchQueue.main.async {
                self.vinyls = vinyls
                self.tableView1.reloadData()
            }
        }
      
        
        tableView1.translatesAutoresizingMaskIntoConstraints = false
        tableView1.delegate = self
        tableView1.dataSource = self
        tableView1.register(CustomView.self, forCellReuseIdentifier: reuseID)
        view.addSubview(tableView1)
        
        setUpConstraints()
    }

    func setUpConstraints() {
        NSLayoutConstraint.activate([
            tableView1.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView1.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView1.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView1.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        ])
    }

}

extension ViewController: updateCell {
    func updateGenre(name: String) {
    }
    
    func updateTitle(name: String) {
        vinyls[currentIndex.row].name = name
        tableView1.reloadData()
    }
    func updateArtist(name: String) {
        vinyls[currentIndex.row].artist = name
        tableView1.reloadData()
    }
}
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.currentIndex = indexPath
        let currentVinyl = vinyls[indexPath.row]
        
        let vc = OrganizeTable(vinyl: currentVinyl)
        vc.del = self
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vinyls.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath) as? CustomView {
            let currentVinyl = vinyls[indexPath.row]
            
            cell.updateFrom(vinyl: currentVinyl)
            
            return cell
        } else {
            return UITableViewCell()
        }
       
    }
    
    
}




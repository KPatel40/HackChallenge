//
//  ViewController.swift
//  VinylCollection
//
//  Created by Krishna Patel
//

import UIKit
import SQLite

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UpdateCellDelegate {

    var db: Connection?
    let vinylsTable = Table("vinyls")
    var vinyls: [VinylData] = []
    
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDatabase()
        createTable()
        setupUI()
        fetchVinyls()
    }
    
    private func setupDatabase() {
        do {
            let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("vinyls.sqlite3").path
            db = try Connection(path)
            print("Database connected successfully.")
        } catch {
            showAlert(title: "Database Error", message: "Failed to connect to database: \(error.localizedDescription)")
        }
    }

    private func createTable() {
        let id = Expression<Int64>("id")
        let name = Expression<String>("name")
        let artist = Expression<String>("artist")
        let year = Expression<String>("year")

        do {
            try db?.run(vinylsTable.create(ifNotExists: true) { t in
                t.column(id, primaryKey: true)
                t.column(name)
                t.column(artist)
                t.column(year)
            })
            print("Table created successfully.")
        } catch {
            showAlert(title: "Table Error", message: "Failed to create table: \(error.localizedDescription)")
        }
    }

    private func setupUI() {
        title = "Vinyl Collection"
        view.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0)

        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomView.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .white
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .lightGray
        view.addSubview(tableView)

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addVinylAction))
    }

    @objc private func addVinylAction() {
        let alertController = UIAlertController(title: "Add Vinyl", message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Name"
        }
        alertController.addTextField { textField in
            textField.placeholder = "Artist"
        }
        alertController.addTextField { textField in
            textField.placeholder = "Year"
        }
        let addAction = UIAlertAction(title: "Add", style: .default) { _ in
            guard let name = alertController.textFields?[0].text,
                  let artist = alertController.textFields?[1].text,
                  let year = alertController.textFields?[2].text else { return }
            self.addVinyl(name: name, artist: artist, year: year)
        }
        alertController.addAction(addAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }

    private func addVinyl(name: String, artist: String, year: String) {
        let nameExpr = Expression<String>("name")
        let artistExpr = Expression<String>("artist")
        let yearExpr = Expression<String>("year")

        do {
            try db?.run(vinylsTable.insert(nameExpr <- name, artistExpr <- artist, yearExpr <- year))
            print("Vinyl added successfully.")
            fetchVinyls()
        } catch {
            showAlert(title: "Insert Error", message: "Failed to add vinyl: \(error.localizedDescription)")
        }
    }

    private func deleteVinyl(id: Int64) {
        let row = vinylsTable.filter(Expression<Int64>("id") == id)

        do {
            try db?.run(row.delete())
            print("Vinyl deleted successfully.")
            fetchVinyls()
        } catch {
            showAlert(title: "Delete Error", message: "Failed to delete vinyl: \(error.localizedDescription)")
        }
    }

    private func fetchVinyls() {
        vinyls.removeAll()
        do {
            for vinyl in try db!.prepare(vinylsTable) {
                let vinylData = VinylData(
                    id: vinyl[Expression<Int64>("id")],
                    img: "", // Add logic to fetch image path
                    name: vinyl[Expression<String>("name")],
                    artist: vinyl[Expression<String>("artist")],
                    year: vinyl[Expression<String>("year")]
                )
                vinyls.append(vinylData)
            }
            tableView.reloadData()
        } catch {
            showAlert(title: "Fetch Error", message: "Failed to fetch vinyls: \(error.localizedDescription)")
        }
    }

    func updateVinyl(id: Int64, name: String, artist: String, year: String) {
        let vinyl = vinylsTable.filter(Expression<Int64>("id") == id)
        let nameExpr = Expression<String>("name")
        let artistExpr = Expression<String>("artist")
        let yearExpr = Expression<String>("year")
        
        do {
            try db?.run(vinyl.update(nameExpr <- name, artistExpr <- artist, yearExpr <- year))
            print("Vinyl updated successfully.")
            fetchVinyls()
        } catch {
            showAlert(title: "Update Error", message: "Failed to update vinyl: \(error.localizedDescription)")
        }
    }

    func updateTitle(name: String) {
        // Implement update title logic if needed
    }

    func updateArtist(name: String) {
        // Implement update artist logic if needed
    }

    func updateGenre(name: String) {
        // Implement update genre logic if needed
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vinyls.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomView
        cell.configure(with: vinyls[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let vinyl = vinyls[indexPath.row]
            deleteVinyl(id: vinyl.id)
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vinyl = vinyls[indexPath.row]
        let organizeVC = OrganizeTable(vinyl: vinyl)
        organizeVC.delegate = self
        navigationController?.pushViewController(organizeVC, animated: true)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

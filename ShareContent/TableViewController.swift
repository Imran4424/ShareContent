//
//  ViewController.swift
//  StormViewer_HS
//
//  Created by Shah Md Imran Hossain on 16/7/22.
//

import UIKit

class TableViewController: UITableViewController {
    // declaring empty string array
    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setting title of screen
        title = "Strom Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fileManager = FileManager.default
        let path = Bundle.main.resourcePath!
        var items = try! fileManager.contentsOfDirectory(atPath: path)
        
        // sorting the array elements
        items.sort()
        
        // for in loop
        for item in items {
            if item.hasPrefix("nssl") {
                // this is a picture from directory to load
                pictures.append(item)
            }
        }
    }
}

extension TableViewController {
    // this method returns how many cells to show in a table view
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    // this method configure a cell how it will look in the table view
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pictureCell", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "detail") as? DetailViewController else {
            print("[TableViewController] detail view is not initiated")
            return
        }
        
        detailVC.selectImage = pictures[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

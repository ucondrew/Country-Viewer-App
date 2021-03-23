//
//  ViewController.swift
//  Project 4
//
//  Created by Andrew Garcia on 3/12/21.
//

import UIKit

class ViewController: UITableViewController { //using a tableView instead of a standar view
    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Country Flag Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true //title in navigation bar will appear large when possible
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        for item in items {
            if item.hasSuffix("@2x.png") {
                pictures.append(item)
            }
            
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pictures.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath) //cells will be recycled
        let cellName = pictures[indexPath.row]
        let name = cellName.split(separator: "@").map(String.init).first
        cell.textLabel?.text = name?.uppercased() //gives text label to cell . Optional because it may not exist.
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            vc.currentPicture = indexPath.row + 1
            vc.totalPictures = pictures.count
            navigationController?.pushViewController(vc, animated: true)
        }
    }


}


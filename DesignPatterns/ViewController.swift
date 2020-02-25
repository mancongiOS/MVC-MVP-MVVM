//
//  ViewController.swift
//  DesignPatterns
//
//  Created by 满聪 on 2020/1/7.
//  Copyright © 2020 MC. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
            
        tableView.rowHeight = 60
        self.navigationItem.title = "设计模式"
    }
    
    lazy var dataArray: [String] = ["MVC", "MCP", "MVVM"]
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        }
        
        cell?.textLabel?.text = dataArray[indexPath.row]
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {

        case 0:
            performSegue(withIdentifier: "MVCViewController", sender: nil)
        case 1:
            performSegue(withIdentifier: "MVPViewController", sender: nil)
        case 2:
            performSegue(withIdentifier: "MVVMViewController", sender: nil)
        default:
            break
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let vc = segue.destination
        
        switch vc.self {
        case is MVCViewController:
            vc.title = "MVC"
        case is MVPViewController:
            vc.title = "MVP"
        case is MVVMViewController:
            vc.title = "MVVM"
        default:
            break
        }
    }
}

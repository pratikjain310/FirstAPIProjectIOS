//
//  ViewController.swift
//  APIExample
//
//  Created by ashutosh deshpande on 08/11/2022.
//

import UIKit

struct Todos: Decodable {
    var userId: Int
    var id: Int
    var title: String
    var completed: Bool
}

class ViewController: UIViewController {

    @IBOutlet weak var todoTableView: UITableView!
    var arr: [Todos] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchTodos()
    }
    
    func fetchTodos() {
        let str = "https://jsonplaceholder.typicode.com/todos"
        let url = URL(string: str)
        
        URLSession.shared.dataTask(with: url!) { [unowned self] data, response, error in
            if error == nil {
                do {
                    self.arr = try JSONDecoder().decode([Todos].self, from: data!)
                    DispatchQueue.main.async {
                        self.todoTableView.reloadData()
                    }
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }


}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        let obj = arr[indexPath.row]
        cell?.textLabel?.text = obj.title
        if obj.completed {
            cell?.accessoryType = .checkmark
        } else {
            cell?.accessoryType = .none
        }
        
        return cell!
    }
    
    
}

/**
 HTTP: Hyper Text Transfer Protocol
 
 HTTP Methods:
 GET
 POST
 PUT
 DELETE
 OPTIONS
 PATCH
 
 
 
 HTTP Headers
 HTTP Request
 HTTP Body
 HTTP Response
 
 Memory Management
 Strong
 Weak
 Unowned
 
 Datatypes:
 
 Any
 AnyObject
 
 **/

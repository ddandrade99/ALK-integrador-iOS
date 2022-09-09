//
//  CategoriesViewController.swift
//  Projeto-integrador-2
//
//  Created by Karina Piloupas Da Costa on 07/09/22.
//

import UIKit


class CategoriesViewController: UIViewController {
    
    @IBOutlet weak var categoriesList: UITableView!
    
    var newCategories = [String]()
    var activity = BoredModel("", "", 0, 0.0)
    
    var apiManager = BoredManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiManager.delegate = self
        self.title = "Categories"
        newCategories = parseJson()
        print(newCategories)
        categoriesList.dataSource = self
        categoriesList.delegate = self
        categoriesList.register(UINib(nibName: "CategoriesTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
    }
    
    init(_ participants: Int){
        self.activity.participants = participants
        super.init(nibName: "CategoriesViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func randomButton(_ sender: UIButton) {
        apiManager.fetchBored(self.activity.participants)
        self.navigationController?.pushViewController(ActivitiesViewController(self.activity), animated: true)
    }
    
    
    func parseJson() -> [String] {
        if let url = Bundle.main.url(forResource: "categories", withExtension: "json"){
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(Categories.self, from: data)
                return jsonData.categories
            }
            catch {
                print(error)
            }
        }
        return []
    }
}

extension CategoriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        newCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CategoriesTableViewCell else {
            return UITableViewCell()
            
        }
        cell.selectCell(activities: newCategories[indexPath.row])
        return cell
    }
}

extension CategoriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        apiManager.fetchBored(self.activity.participants, newCategories[indexPath.row])
        self.navigationController?.pushViewController(ActivitiesViewController(self.activity, newCategories[indexPath.row]), animated: true)
    }
}


extension CategoriesViewController: BoredManagerDelegate {
    
    func updateModel(_ boredManager: BoredManager, bored: BoredModel) {
        DispatchQueue.main.async {
            self.activity = bored
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
}

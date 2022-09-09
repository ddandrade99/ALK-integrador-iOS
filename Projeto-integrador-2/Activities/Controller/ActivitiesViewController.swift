//
//  ActivitiesViewController.swift
//  Projeto-integrador-2
//
//  Created by Karina Piloupas Da Costa on 07/09/22.
//

import UIKit

class ActivitiesViewController: UIViewController {

    var activity: BoredModel
    
    @IBOutlet weak var activityName: UILabel!
    
    @IBOutlet weak var participants: UILabel!
    
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    
    var apiManager = BoredManager()
    
    init(_ activity: BoredModel, _ category: String = "Random"){
        self.activity = activity
        super.init(nibName: "ActivitiesViewController", bundle: nil)
        self.title = category
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiManager.delegate = self
        self.activityName.text = activity.activity
        self.participants.text = String(activity.participants)
        self.price.text = printPrice(activity.price)
        self.typeLabel.text = activity.type
    }

    func printPrice(_ price: Double) -> String {
        print(price)
        switch price {
            case 0.0:
                return "Free"
            case 0.01...0.3:
                return "Low"
            case 0.4...0.6:
                return "Medium"
            default:
            return "High"
        }
    }
    
    
    @IBAction func tryAnotherButton(_ sender: UIButton) {
        apiManager.fetchBored(self.activity.participants, self.activity.type)
    }
}

extension ActivitiesViewController: BoredManagerDelegate {
    
    func updateModel(_ boredManager: BoredManager, bored: BoredModel) {
        DispatchQueue.main.async {
            self.activity = bored
            self.activityName.text = bored.activity
            self.participants.text = String(bored.participants)
            self.price.text = self.printPrice(bored.price)
            self.typeLabel.text = bored.type
            self.title = bored.type
        }
    }
    func didFailWithError(error: Error) {
        print(error)
    }
    
}

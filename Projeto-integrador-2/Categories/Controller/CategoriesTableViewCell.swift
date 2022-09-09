//
//  CategoriesTableViewCell.swift
//  Projeto-integrador-2
//
//  Created by Karina Piloupas Da Costa on 07/09/22.
//

import UIKit

class CategoriesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var categoriesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func selectCell(activities:String){
        categoriesLabel.text = activities
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}

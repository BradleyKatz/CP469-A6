//
//  CardTableViewCell.swift
//  katz0210_a6
//
//  Created by Bradley Katz on 2018-03-15.
//  Copyright © 2018 Bradley Katz. All rights reserved.
//

import UIKit

class CardTableViewCell: UITableViewCell
{
    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
}

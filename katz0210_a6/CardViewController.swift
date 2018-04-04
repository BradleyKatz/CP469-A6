//
//  CardViewController.swift
//  katz0210_a6
//
//  Created by Bradley Katz on 2018-03-15.
//  Copyright © 2018 Bradley Katz. All rights reserved.
//

import UIKit

class CardViewController: UIViewController
{
    @IBOutlet weak var uiImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    private static let displayWebViewSegueID = "showWebView"
    private static var currentCard: NewsItemCard?
    
    public static func setCard(card: NewsItemCard)
    {
        currentCard = card
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        navigationItem.title = CardViewController.currentCard?.getTitle()
        uiImageView.image = CardViewController.currentCard?.getPreviewImage()
        descriptionLabel.text = CardViewController.currentCard?.getDescription()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        navigationItem.title = CardViewController.currentCard?.getTitle()
        uiImageView.image = CardViewController.currentCard?.getPreviewImage()
        descriptionLabel.text = CardViewController.currentCard?.getDescription()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onBackButtonPressed(_ sender: UIBarButtonItem)
    {
        CardViewController.currentCard = nil
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == CardViewController.displayWebViewSegueID
        {
            WebViewController.setURL(url: (CardViewController.currentCard?.getLink())!)
        }
    }
}

//
//  ViewController.swift
//  katz0210_a6
//
//  Created by Bradley Katz on 2018-03-15.
//  Copyright © 2018 Bradley Katz. All rights reserved.
//

import UIKit

class RSSTableViewController: UITableViewController, URLSessionTaskDelegate, XMLParserDelegate
{
    private static let displayCardSegueID = "displayCard"
    
    private let urlPath = "http://rss.cbc.ca/lineup/topstories.xml"
    private let DESCRIPTION_ELEMENT_NAME = "description"
    private let TITLE_ELEMENT_NAME = "title"
    private let LINK_ELEMENT_NAME = "link"
    
    private var dataStore = NSData()
    private var currentElement = ""
    private var processingElement = false
    
    private var currentTitle = ""
    private var currentLink = ""
    
    private var numElemsToSkip = 2
    
    private func parseXML()
    {
        let parser = XMLParser(data: dataStore as Data)
        parser.delegate = self
        parser.parse()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationItem.title = "CBC News Feed"
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        let url: NSURL = NSURL(string: urlPath)!
        let request = URLRequest(url: url as URL)
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request, completionHandler:{ (data, response, error) in
            self.dataStore = data! as NSData

            DispatchQueue.main.async
            {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            self.parseXML()
        })
        task.resume()
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - XML Parsing
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String])
    {
        if elementName == TITLE_ELEMENT_NAME || elementName == LINK_ELEMENT_NAME || elementName == DESCRIPTION_ELEMENT_NAME
        {
            processingElement = true
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String)
    {
        if processingElement
        {
            currentElement += string
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        if elementName == TITLE_ELEMENT_NAME
        {
            processingElement = false
            currentTitle = currentElement
            currentElement = ""
        }
        else if elementName == LINK_ELEMENT_NAME
        {
            processingElement = false
            currentLink = currentElement
            currentElement = ""
        }
        else if elementName == DESCRIPTION_ELEMENT_NAME
        {
            if numElemsToSkip > 0
            {
                numElemsToSkip -= 1
                processingElement = false
                currentElement = ""
            }
            else
            {
                print("")
                
                let quoteSet = NSCharacterSet(charactersIn: "'")
                let bracketSet = NSCharacterSet(charactersIn: "<")
                let descriptionScanner = Scanner(string: currentElement)
                
                // Parse out image src
                let SRC = "src='"
                var imageLink: NSString?
                
                descriptionScanner.scanUpTo(SRC, into: nil)
                descriptionScanner.scanString(SRC, into: nil)
                descriptionScanner.scanUpToCharacters(from: quoteSet as CharacterSet, into: &imageLink)
                
                // Parse out description
                let P = "<p>"
                var currentDescription: NSString?
                
                descriptionScanner.scanUpTo(P, into: nil)
                descriptionScanner.scanString(P, into: nil)
                descriptionScanner.scanUpToCharacters(from: bracketSet as CharacterSet, into: &currentDescription)
                
                if (imageLink != nil && currentDescription != nil)
                {
//                    print(imageLink! as String)
//                    print("")
//                    print(currentDescription! as String)
//                    print("")
                    
                    // Build UIImage
                    let imageURL = NSURL(string: imageLink! as String)
                    let imageData = NSData(contentsOf: imageURL! as URL)
                    let image = UIImage(data: imageData! as Data)
                    
                    // Build NewsItemCard and add to SharedDeck
                    let card = NewsItemCard(title: currentTitle, description: currentDescription! as String, link: currentLink, previewImage: image!)
                    SharedDeck.appendCard(card: card)
                    
                    DispatchQueue.main.async
                    {
                        self.tableView.reloadData()
                    }
                }
                processingElement = false
                currentElement = ""
            }
        }
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error)
    {
        print("Parser Error: " + String(describing: parseError))
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return SharedDeck.getSize()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CardTableViewCell", for: indexPath) as? CardTableViewCell else
        {
            fatalError("This cell is not a CardTableViewCell")
        }

        // Get the appropriate card from the deck
        let currentCard = SharedDeck.getCardAt(index: indexPath.row)

        // Set the cell properties
        cell.previewImageView.image = currentCard.getPreviewImage()
        cell.titleLabel.text = currentCard.getTitle()

        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        // Return false if you do not want the specified item to be editable.
        return false
    }


    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == RSSTableViewController.displayCardSegueID
        {
            CardViewController.setCard(card: SharedDeck.getCardAt(index: (tableView.indexPathForSelectedRow?.row)!))
        }
    }
}


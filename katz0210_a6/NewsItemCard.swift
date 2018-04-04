//
//  Card.swift
//  katz0210_a6
//
//  Created by Bradley Katz on 2018-03-15.
//  Copyright © 2018 Bradley Katz. All rights reserved.
//

import Foundation
import UIKit
import os

public class NewsItemCard
{
    private var title: String
    private var description: String
    private var link: String
    private var previewImage: UIImage
    
    public init(title: String, description: String, link: String, previewImage: UIImage)
    {
        self.title = title
        self.description = description
        self.link = link
        self.previewImage = previewImage
    }
    
    public func getTitle() -> String
    {
        return self.title
    }
    
    public func getDescription() -> String
    {
        return self.description
    }
    
    public func getLink() -> String
    {
        return self.link
    }
    
    public func getPreviewImage() -> UIImage
    {
        return self.previewImage
    }
}

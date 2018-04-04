//
//  WebViewController.swift
//  katz0210_a6
//
//  Created by Bradley Katz on 2018-03-15.
//  Copyright © 2018 Bradley Katz. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate
{
    private static var currentURL: String?
    
    private let kHEADERHEIGHT: CGFloat = 44.0
    private let kFOOTERHEIGHT: CGFloat = 44.0
    
    private var webView: WKWebView = WKWebView()
    private var headerView: UIView = UIView()
    private var footerView: UIView = UIView()
    
    private var leftArrowButton = UIButton(type: UIButtonType.custom)
    private var rightArrowButton = UIButton(type: UIButtonType.custom)
    
    public static func setURL(url: String)
    {
        WebViewController.currentURL = url
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        webView.allowsBackForwardNavigationGestures = true
        self.view.backgroundColor = UIColor.white
        self.headerView.backgroundColor = UIColor.gray
        self.footerView.backgroundColor = UIColor.gray
        
        // Image set
        self.leftArrowButton.setImage(UIImage(named: "left-arrow"), for: [])
        // when user presses on the left arrow button, the method back is executed
        self.leftArrowButton.addTarget(self, action:#selector(back(_ : )), for: .touchUpInside)
        
        self.rightArrowButton.setImage(UIImage(named: "right-arrow"), for: [])
        self.rightArrowButton.addTarget(self, action:#selector(forward(_ : )), for: .touchUpInside)
        
        self.view.addSubview(self.headerView)
        self.view.addSubview(self.webView)
        self.view.addSubview(self.footerView)
        self.view.addSubview(self.leftArrowButton)
        self.view.addSubview(self.rightArrowButton)
        
        self.webView.navigationDelegate = self
        self.webView.load(URLRequest(url: NSURL(string: (WebViewController.currentURL)!)! as URL))
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews()
    {
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        self.headerView.frame = CGRect(origin: CGPoint(x:0, y:statusBarHeight), size: CGSize(width: self.view.frame.size.width, height: kHEADERHEIGHT))
        
        self.webView.frame = CGRect(origin: CGPoint(x:0, y:statusBarHeight+kHEADERHEIGHT), size: CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height - (statusBarHeight+kHEADERHEIGHT) - kFOOTERHEIGHT))
        
        self.footerView.frame = CGRect(origin: CGPoint(x:0, y:self.view.frame.size.height - kFOOTERHEIGHT), size: CGSize(width: self.view.frame.size.width, height: kFOOTERHEIGHT))
        
        self.leftArrowButton.frame = CGRect(origin: CGPoint(x:5, y:self.view.frame.size.height - kFOOTERHEIGHT), size: CGSize(width: kFOOTERHEIGHT, height: kFOOTERHEIGHT))
        
        
        self.rightArrowButton.frame = CGRect(origin: CGPoint(x:10 + kFOOTERHEIGHT, y:self.view.frame.size.height - kFOOTERHEIGHT), size: CGSize(width: kFOOTERHEIGHT, height: kFOOTERHEIGHT))
    }
    
    @objc func back(_ sender: Any)
    {
        if (self.webView.canGoBack)
        {
            self.webView.goBack()
        }
    }
    
    @objc func forward(_ sender: Any)
    {
        if (self.webView.canGoForward)
        {
            self.webView.goForward()
        }
    }
    
    @IBAction func onNewsFeedButtonPressed(_ sender: UIBarButtonItem)
    {
        WebViewController.currentURL = nil
        dismiss(animated: true, completion: nil)
    }
}

//
//  ViewController.swift
//  RottenTomatoes
//
//  Created by Dan Fessler on 2/4/15.
//  Copyright (c) 2015 CodePath. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var moviesArray: NSArray?
    var networkError: Bool = false

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
        loadMovieData()
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let array = moviesArray {
            return array.count
        } else {
            return 0
        }
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let movie = self.moviesArray![indexPath.row] as NSDictionary
        let cell = tableView.dequeueReusableCellWithIdentifier("com.codepath.mycell") as MovieTableViewCell
        cell.movieTitleLabel.text = movie["title"] as NSString
        
        if let posters: AnyObject = movie["posters"] {
            if let thumbnail: AnyObject? = posters["thumbnail"] {
                //println(thumbnail)
                let url = NSURL(string: thumbnail as String);
                cell.movieThumbnail.setImageWithURL(url);
            }
        }
        
        
        //cell.movieThumbnail.SetImageWithURL(ThumbnailURL!)
        

        
        return cell
        
    }
    
    override func viewDidLoad()
    {
        self.refreshControl?.addTarget(self, action: "onRefresh:", forControlEvents: UIControlEvents.ValueChanged)
    }
    
    
    func onRefresh(sender:AnyObject)
    {
        
        
        loadMovieData()
        
        
    }
    
    
    func loadMovieData()
    {
        SVProgressHUD.show()
        let RottenTomatoesURLString = "http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=67jux3kv24atd6nu52ugk4dq"
        let request = NSMutableURLRequest(URL: NSURL(string: RottenTomatoesURLString)!)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:{ (response, data, error) in
            var errorValue: NSError? = nil
            
            if errorValue == nil {
                self.networkError = false
                let dictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &errorValue) as NSDictionary
                self.moviesArray = dictionary["movies"] as? NSArray
                self.tableView.reloadData()
                SVProgressHUD.dismiss()
                println("REFRESH")
                self.refreshControl?.endRefreshing()
            } else {
                
                self.networkError = true
            }
        })
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let movie = self.moviesArray![indexPath.row] as NSDictionary
        let detailsView : MovieDetailsViewController! = self.storyboard?.instantiateViewControllerWithIdentifier("shapoopy") as MovieDetailsViewController
        detailsView.movieDictionary = movie
        
        self.showViewController(detailsView, sender: detailsView)
        
    }

}


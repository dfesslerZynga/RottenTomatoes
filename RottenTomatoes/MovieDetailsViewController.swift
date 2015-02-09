//
//  MovieDetailsViewController.swift
//  RottenTomatoes
//
//  Created by Dan Fessler on 2/4/15.
//  Copyright (c) 2015 CodePath. All rights reserved.
//

import UIKit




class MovieDetailsViewController: UIViewController {
    

    var movieDictionary: NSDictionary?
    
    @IBOutlet weak var detailsTextView: UITextView!
    
    @IBOutlet weak var posterImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if ((movieDictionary?) != nil) {
            detailsTextView.text = movieDictionary!["synopsis"] as NSString
            detailsTextView.font = UIFont(name: "helvetica", size: 18)
            detailsTextView.textColor = UIColor.blackColor()
            detailsTextView.textAlignment = NSTextAlignment.Justified
            
            
            if let posters: AnyObject = movieDictionary!["posters"] {
                if var thumbnail: String? = posters["thumbnail"] as? String {
                    //println(thumbnail)
                    thumbnail!.removeRange(Range<String.Index>(start: advance(thumbnail!.endIndex,-7), end: thumbnail!.endIndex))
                    thumbnail! += "ori.jpg"
                    //println(thumbnail!)
                    
                    let url = NSURL(string: thumbnail! as String);
                    posterImage.setImageWithURL(url)

                }
            }
            
            
            
            
            
        } else {
            detailsTextView.text = "poop"
        }
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

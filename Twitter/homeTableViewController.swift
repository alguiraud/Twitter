//
//  homeTableViewController.swift
//  Twitter
//
//  Created by Andre Guiraud on 9/21/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class homeTableViewController: UITableViewController {

    var tweets = [NSDictionary]()
    var numTweets: Int!
    
    let myrefreshControl = UIRefreshControl()
    
    @objc func pullTweets(){
        numTweets = 20
        let URL = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let myParams = ["count": numTweets]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: URL, parameters: myParams, success: { (tweetsArray: [NSDictionary]) in
            self.tweets.removeAll()
            for tweet in tweetsArray {
                self.tweets.append(tweet)
            }
            self.tableView.reloadData()
            self.myrefreshControl.endRefreshing()
        }, failure: { (Error) in
            print("Failed requesting tweets.")
        })
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pullTweets()
        
        myrefreshControl.addTarget(self, action: #selector(pullTweets), for: .valueChanged)
        tableView.refreshControl = myrefreshControl
    }

    @IBAction func onLogout(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        self.dismiss(animated: true, completion: nil)
        UserDefaults.standard.set(false, forKey: "loggedIn")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! tweetTableViewCell
        let user = tweets[indexPath.row]["user"] as! NSDictionary
        
        let imageUrl = URL(string: (user["profile_image_url_https"] as? String)!)
        let data = try? Data(contentsOf: imageUrl!)
        
        cell.userTweet.text = tweets[indexPath.row]["text"] as? String
        cell.userName.text =  user["name"] as? String
      
        if let imageData = data {
            cell.profileImage.image = UIImage(data: imageData)
        }
        
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func loadMoreTweets()
    {
        let URL = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        numTweets = numTweets + 20
        
        let myParams = ["count": numTweets]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: URL, parameters: myParams, success: { (tweetsArray: [NSDictionary]) in
            self.tweets.removeAll()
            for tweet in tweetsArray {
                self.tweets.append(tweet)
            }
            self.tableView.reloadData()
            self.myrefreshControl.endRefreshing()
        }, failure: { (Error) in
            print("Failed requesting tweets.")
        })
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == tweets.count {
            loadMoreTweets()
        }
    }
    
}

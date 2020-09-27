//
//  profileViewController.swift
//  Twitter
//
//  Created by Andre Guiraud on 9/27/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class profileViewController: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var numTweets: UILabel!
    @IBOutlet weak var numFollowers: UILabel!
    @IBOutlet weak var numFollowing: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userTagline: UILabel!
    var userInfo = NSDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        TwitterAPICaller.client?.getUserInfo(success: { (replyInfo: NSDictionary) in
            self.userInfo = replyInfo.copy() as! NSDictionary
        }, failure: { (error) in
            print("Failed to get user info. \(error)")
        })
        print(self.userInfo["name"])
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

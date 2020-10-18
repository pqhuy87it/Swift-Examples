//
//  ViewController.swift
//  RoutableApp
//
//  Created by Fabian Buentello on 11/29/16.
//  Copyright © 2016 ChaiOne. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        _ = Router.Post("54").getComment(params: "43")                                  // posts/54/comments/43
        _ = Router.User("initFabian").getStatus(params: "2")                            // users/initFabian/statuses/2
        _ = Router.User("initFabian").picture(params: "2").getComment(params: "3")      // users/initFabian/pictures/2/comments/3


        let crazyNested = Router.User("initFabian")
            .status(params: "3")
            .comment(params: "32352")
            .getUser(params: "fakeUser")

        print(crazyNested)
        // users/initFabian/statuses/3/comments/32352/users/fakeUser

        let extremelyNested = Router.User("initFabian")
            .picture(params: "3")
            .comment(params: "507f191e810c19729de860ea")
            .user(params: "43")
            .status(params: "firstStatus")
            .comment(params: "27")
            .user(params: "63")
            .post(params: "4d6e5acebcd1b3fac9000002")
            .comment(params: "82")
            .user(params: "21")
            .getStatus(params: "1")
        
        print(extremelyNested)
        
        Alamofire.request(Router.User("2").getStatus(params: "2")).validate().responseJSON { response in
            switch response.result {
            case .success:
                debugPrint(response) // https://private-85a46-routable.apiary-mock.com/users/2/statuses/2
            case .failure(let error):
                print(error)
            }
        }
    }
}

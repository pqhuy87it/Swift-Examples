//
//  Router.swift
//  RoutableApp
//
//  Created by Fabian Buentello on 1/28/17.
//  Copyright © 2017 ChaiOne. All rights reserved.
//

import Foundation
import Alamofire

struct Router: URLRouter {
    static var basePath: String {
        return "https://private-85a46-routable.apiary-mock.com/"
    }

    struct User: Readable, Creatable, Updatable,
    hasStatuses, hasPictures, hasPosts {
        var route: String = "users"
        var urlParams: String!
    }

    struct Status: Readable, Creatable, Deletable,
    hasComments {
        var route: String = "statuses"
        var urlParams: String!
    }

    struct Picture: Readable, Creatable, Deletable, Updatable,
    hasComments {
        var route: String = "pictures"
        var urlParams: String!
    }

    struct Comment: Readable, Creatable, Deletable, Updatable,
    hasUsers  {
        var route: String = "comments"
        var urlParams: String!
    }

    struct Post: Readable, Creatable, Deletable, Updatable,
    hasComments {
        var route: String = "posts"
        var urlParams: String!
    }
}

// Would probably move this(below code) to a different file called `ChildRoute.swift`
protocol hasStatuses {}
extension hasStatuses where Self: Routable {
    func status(params: String) -> Router.Status {
        var child = Router.Status(params)
        child.route = nestedRouteURL(parent: self, child: child)
        return child
    }

    func getStatus(params: String) -> RequestConverterProtocol {
        return nestedRoute(args: urlParams, child: Router.Status.get(params: params))
    }

    func createStatus(parameters: Parameters) -> RequestConverterProtocol {
        return nestedRoute(args: urlParams, child: Router.Status.create(parameters: parameters))
    }

    func deleteStatus(params: String) -> RequestConverterProtocol {
        return nestedRoute(args: urlParams, child: Router.Status.delete(params: params))
    }
}

protocol hasComments {}
extension hasComments where Self: Routable {
    func comment(params: String) -> Router.Comment {
        var child = Router.Comment(params)
        child.route = nestedRouteURL(parent: self, child: child)
        return child
    }

    func getComment(params: String) -> RequestConverterProtocol {
        let returnComment = nestedRoute(args: urlParams, child: Router.Comment.get(params: params))
        return returnComment
    }

    func createComment(parameters: Parameters) -> RequestConverterProtocol {
        return nestedRoute(args: urlParams, child: Router.Comment.create(parameters: parameters))
    }

    func deleteComment(params: String) -> RequestConverterProtocol {
        return nestedRoute(args: urlParams, child: Router.Comment.delete(params: params))
    }

    func updateComment(params: String, parameters: Parameters) -> RequestConverterProtocol {
        return nestedRoute(args: urlParams, child: Router.Comment.update(params: params, parameters: parameters))
    }
}

protocol hasPictures {}
extension hasPictures where Self: Routable {
    func picture(params: String) -> Router.Picture {
        var child = Router.Picture(params)
        child.route = nestedRouteURL(parent: self, child: child)
        return child
    }

    func getPicture(params: String) -> RequestConverterProtocol {
        return nestedRoute(args: urlParams, child: Router.Picture.get(params: params))
    }

    func createPicture(parameters: Parameters) -> RequestConverterProtocol {
        return nestedRoute(args: urlParams, child: Router.Picture.create(parameters: parameters))
    }

    func deletePicture(params: String) -> RequestConverterProtocol {
        return nestedRoute(args: urlParams, child: Router.Picture.delete(params: params))
    }

    func updatePicture(params: String, parameters: Parameters) -> RequestConverterProtocol {
        return nestedRoute(args: urlParams, child: Router.Picture.update(params: params, parameters: parameters))
    }
}

protocol hasUsers {}
extension hasUsers where Self: Routable {

    func user(params: String) -> Router.User {
        var child = Router.User(params)
        child.route = nestedRouteURL(parent: self, child: child)
        return child
    }

    func getUser(params: String) -> RequestConverterProtocol {
        return nestedRoute(args: urlParams, child: Router.User.get(params: params))
    }

    func createUser(parameters: Parameters) -> RequestConverterProtocol {
        return nestedRoute(args: urlParams, child: Router.User.create(parameters: parameters))
    }

    func updateUser(params: String, parameters: Parameters) -> RequestConverterProtocol {
        return nestedRoute(args: urlParams, child: Router.User.update(params: params, parameters: parameters))
    }
}

protocol hasPosts {}
extension hasPosts where Self: Routable {

    func post(params: String) -> Router.Post {
        var child = Router.Post(params)
        child.route = nestedRouteURL(parent: self, child: child)
        return child
    }

    func getPost(params: String) -> RequestConverterProtocol {
        return nestedRoute(args: urlParams, child: Router.Post.get(params: params))
    }

    func createPost(parameters: Parameters) -> RequestConverterProtocol {
        return nestedRoute(args: urlParams, child: Router.Post.create(parameters: parameters))
    }

    func updatePost(params: String, parameters: Parameters) -> RequestConverterProtocol {
        return nestedRoute(args: urlParams, child: Router.Post.update(params: params, parameters: parameters))
    }
}

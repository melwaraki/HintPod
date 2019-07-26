//
//  Comment.swift
//  HintPod
//
//  Created by Marawan Alwaraki on 06/04/2019.
//

import Foundation

class Comment {
    
    var id: String!
    var content: String!
    var uid: String!
    
    init(json: AnyObject) {
        
        var dict:Dictionary<String, AnyObject>!
        
        dict = json as? Dictionary<String, AnyObject>
        
        self.id = dict["key"] as? String
        self.content = dict["content"] as? String ?? "Error comment"
        self.uid = dict["uid"] as? String
    }
    
}

//
//  Profile.swift
//  OtherTransitionTest
//
//  Created by Sam Greenhill on 10/16/23.
//

import SwiftUI

// MARK: Profile Model and Sample Data

struct Profile: Identifiable {
    var id = UUID().uuidString
    var username: String
    var profilePicture: String
    var lastMsg: String
    var lastActive: String
}

var profiles = [
    Profile(username: "Pic1", profilePicture: "Pic1", lastMsg: "Hi 1", lastActive: "10:25 PM"),
    Profile(username: "Pic2", profilePicture: "Pic2", lastMsg: "Hi 2", lastActive: "11:25 PM"),
    Profile(username: "Pic3", profilePicture: "Pic3", lastMsg: "Hi 3", lastActive: "12:25 PM"),
    Profile(username: "Pic4", profilePicture: "Pic4", lastMsg: "Hi 4", lastActive: "1:25 AM"),
    Profile(username: "Pic5", profilePicture: "Pic5", lastMsg: "Hi 5", lastActive: "2:25 AM"),
    Profile(username: "Pic6", profilePicture: "Pic6", lastMsg: "Hi 6", lastActive: "3:25 AM"),
]

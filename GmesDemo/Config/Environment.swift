//
//  Environment.swift
// GamesDemo
//
//  Created by ispha on 20/09/2021.
//  Copyright © 2021 ispha. All rights reserved.
//

// Environment.swift

import Foundation

public enum Environment {
  // MARK: - Keys
  enum Keys {
    enum Plist {
      static let rootURL = "ROOT_URL"
      static let imgURL = "IMG_URL"
    }
  }

  // MARK: - Plist
  private static let infoDictionary: [String: Any] = {
    guard let dict = Bundle.main.infoDictionary else {
      fatalError("Plist file not found")
    }
    return dict
  }()

  // MARK: - Plist values
  static let rootURLString: String = {
    guard let rootURLString = Environment.infoDictionary[Keys.Plist.rootURL] as? String else {
      fatalError("Root URL not set in plist for this environment")
    }
    return rootURLString
  }()

    static let imgURLString: String = {
      guard let imgURLString = Environment.infoDictionary[Keys.Plist.imgURL] as? String else {
        fatalError("Img URL not set in plist for this environment")
      }
      return imgURLString
    }()
}

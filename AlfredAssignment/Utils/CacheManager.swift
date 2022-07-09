//
//  CacheManager.swift
//  AlfredAssignment
//
//  Created by Crystal on 2022/7/10.
//

import UIKit

class CacheManager {
    
    static let shared = CacheManager()
    let imageCache = NSCache<NSString, UIImage>()
}

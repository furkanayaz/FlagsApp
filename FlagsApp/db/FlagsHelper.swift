//
//  FlagsHelper.swift
//  FlagsApp
//
//  Created by FURKAN AYAZ on 10.02.2024.
//

import Foundation

protocol FlagsHelper {
    func fetchFlags() -> [Flag]
    func fetchFlagsByRandomly(without id: Int) -> [Flag]
}

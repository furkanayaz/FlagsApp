//
//  FlagsDao.swift
//  FlagsApp
//
//  Created by FURKAN AYAZ on 10.02.2024.
//

import Foundation

class FlagsDao: FlagsHelper {
    var db: FMDatabase?
    
    init() {
        let file = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("flags.sqlite")
        db = FMDatabase(path: file?.path)
    }
    
    func fetchFlags() -> [Flag] {
        var flags: [Flag] = [Flag]()
        
        db?.open()
        
        do {
            let cursor = try db?.executeQuery("SELECT * FROM Flags ORDER BY RANDOM()", values: nil)
            
            guard let row = cursor else {
                throw FlagError.CURSOR_ERROR
            }
            
            while row.next() {
                let flag = Flag(id: Int(row.int(forColumn: "id")), countryName: row.string(forColumn: "country_name"), countryCode: row.string(forColumn: "country_code"))
                
                flags.append(flag)
            }
        }catch {
            print(error.localizedDescription)
        }
        
        return flags
    }
    
    func fetchFlagsByRandomly(without id: Int) -> [Flag] {
        var flags: [Flag] = [Flag]()
        
        db?.open()
        
        do {
            let cursor = try db?.executeQuery("SELECT * FROM Flags WHERE id != ? ORDER BY RANDOM() LIMIT 3", values: [id])
            
            guard let row = cursor else {
                throw FlagError.CURSOR_ERROR
            }
            
            while row.next() {
                let flag = Flag(id: Int(row.int(forColumn: "id")), countryName: row.string(forColumn: "country_name"), countryCode: row.string(forColumn: "country_code"))
                
                flags.append(flag)
            }
        }catch {
            print(error.localizedDescription)
        }
        
        return flags
    }
}

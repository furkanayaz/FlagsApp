//
//  FlagsDao.swift
//  FlagsApp
//
//  Created by FURKAN AYAZ on 10.02.2024.
//

import Foundation

class FlagsDao {
    var db: FMDatabase?
    
    init() {
        let file = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("flags.sqlite")
        db = FMDatabase(path: file?.path)
    }
    
    func fetchAll() -> [Flag] {
        var flags: [Flag] = [Flag]()
        
        db?.open()
        
        do {
            let cursor = try db?.executeQuery("SELECT * FROM Flags", values: nil)
            
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
    
    func fetchRandomly(id: Int) -> [Flag] {
        var flags: [Flag] = [Flag]()
        
        db?.open()
        
        do {
            let cursor = try db?.executeQuery("SELECT * FROM Flags ORDER BY RANDOM() LIMIT 4 WHERE id != ?", values: [id])
            
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

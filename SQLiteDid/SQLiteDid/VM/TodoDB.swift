import SQLite3
import Foundation
import SwiftUI
import Combine

class TodoDB: ObservableObject {
    
    var db: OpaquePointer?
    var todoList: [Todo] = []
    
    init() {
        let fileURL = try! FileManager.default
            .url(for: .documentDirectory,
                 in: .userDomainMask,
                 appropriateFor: nil,
                 create: false)
            .appendingPathComponent("TodoListData.sqlite")
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        }
        
        let createTable = """
        CREATE TABLE IF NOT EXISTS todo (
            sid INTEGER PRIMARY KEY AUTOINCREMENT,
            stitle TEXT,
            scompleted INTEGER,
            spriority INTEGER
        )
        """
        
        if sqlite3_exec(db, createTable, nil, nil, nil) != SQLITE_OK {
            let errMsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errMsg)")
        }
    }
    
    func insertDB(title: String, isCompleted: Bool = false, priority: Int = 0) -> Bool {
        var stmt: OpaquePointer?
        let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
        
        let queryString = "INSERT INTO todo (stitle, scompleted, spriority) VALUES (?, ?, ?)"
        
        if sqlite3_prepare_v2(db, queryString, -1, &stmt, nil) != SQLITE_OK {
            print("insert prepare error")
            return false
        }
        
        sqlite3_bind_text(stmt, 1, (title as NSString).utf8String, -1, SQLITE_TRANSIENT)
        sqlite3_bind_int(stmt, 2, isCompleted ? 1 : 0)
        sqlite3_bind_int(stmt, 3, Int32(priority))
        
        let result = sqlite3_step(stmt) == SQLITE_DONE
        sqlite3_finalize(stmt)
        return result
    }
    
    func queryDB() -> [Todo] {
        var stmt: OpaquePointer?
        let queryString = "SELECT * FROM todo ORDER BY spriority ASC, sid ASC"
        
        todoList.removeAll()
        
        if sqlite3_prepare_v2(db, queryString, -1, &stmt, nil) != SQLITE_OK {
            let errMsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing select: \(errMsg)")
            return []
        }
        
        while sqlite3_step(stmt) == SQLITE_ROW {
            let id = Int(sqlite3_column_int(stmt, 0))
            let title = String(cString: sqlite3_column_text(stmt, 1))
            let isCompleted = sqlite3_column_int(stmt, 2) == 1
            let priority = Int(sqlite3_column_int(stmt, 3))
            
            todoList.append(
                Todo(id: id, title: title, isCompleted: isCompleted, priority: priority)
            )
        }
        
        sqlite3_finalize(stmt)
        return todoList
    }
    
    func updateDB(id: Int, title: String, isCompleted: Bool, priority: Int) -> Bool {
        var stmt: OpaquePointer?
        let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
        
        let queryString = """
        UPDATE todo
        SET stitle = ?, scompleted = ?, spriority = ?
        WHERE sid = ?
        """
        
        if sqlite3_prepare_v2(db, queryString, -1, &stmt, nil) != SQLITE_OK {
            print("update prepare error")
            return false
        }
        
        sqlite3_bind_text(stmt, 1, (title as NSString).utf8String, -1, SQLITE_TRANSIENT)
        sqlite3_bind_int(stmt, 2, isCompleted ? 1 : 0)
        sqlite3_bind_int(stmt, 3, Int32(priority))
        sqlite3_bind_int(stmt, 4, Int32(id))
        
        let result = sqlite3_step(stmt) == SQLITE_DONE
        sqlite3_finalize(stmt)
        return result
    }
    
    func updateCompleted(id: Int, isCompleted: Bool) -> Bool {
        var stmt: OpaquePointer?
        let queryString = "UPDATE todo SET scompleted = ? WHERE sid = ?"
        
        if sqlite3_prepare_v2(db, queryString, -1, &stmt, nil) != SQLITE_OK {
            print("completed update prepare error")
            return false
        }
        
        sqlite3_bind_int(stmt, 1, isCompleted ? 1 : 0)
        sqlite3_bind_int(stmt, 2, Int32(id))
        
        let result = sqlite3_step(stmt) == SQLITE_DONE
        sqlite3_finalize(stmt)
        return result
    }
    
    func updatePriority(id: Int, priority: Int) -> Bool {
        var stmt: OpaquePointer?
        let queryString = "UPDATE todo SET spriority = ? WHERE sid = ?"
        
        if sqlite3_prepare_v2(db, queryString, -1, &stmt, nil) != SQLITE_OK {
            print("priority update prepare error")
            return false
        }
        
        sqlite3_bind_int(stmt, 1, Int32(priority))
        sqlite3_bind_int(stmt, 2, Int32(id))
        
        let result = sqlite3_step(stmt) == SQLITE_DONE
        sqlite3_finalize(stmt)
        return result
    }
    
    func deleteDB(id: Int) -> Bool {
        var stmt: OpaquePointer?
        let queryString = "DELETE FROM todo WHERE sid = ?"
        
        if sqlite3_prepare_v2(db, queryString, -1, &stmt, nil) != SQLITE_OK {
            print("delete prepare error")
            return false
        }
        
        sqlite3_bind_int(stmt, 1, Int32(id))
        
        let result = sqlite3_step(stmt) == SQLITE_DONE
        sqlite3_finalize(stmt)
        return result
    }
}

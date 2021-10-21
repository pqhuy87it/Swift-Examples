//
//  LogMonitor.swift
//  MyRoute
//
//  Created by Phoc on 13/08/2021.
//  Copyright © 2021 Fsoft. All rights reserved.
//

import Foundation

final class FileWatcher {
    private let url: URL
    
    private let fileHandle: FileHandle?
    private var source: DispatchSourceFileSystemObject?
    
    init(url: URL) {
        self.url = url
        self.fileHandle = try? FileHandle(forReadingFrom: url)
    }
    
    public class func watch(url: URL, isReadFile: Bool) -> FileWatcher? {
        let fileWatcher = FileWatcher(url: url)
        
        guard fileWatcher.startWatching(isReadFile) else {
            return nil
        }
        
        return fileWatcher
    }
    
    public func startWatching(_ isReadFile: Bool) -> Bool {
        guard self.source == nil else {
            return false
        }
                
        guard let fileHandle = self.fileHandle, fileHandle.fileDescriptor != -1 else {
            return false
        }
        
        let source = DispatchSource.makeFileSystemObjectSource(fileDescriptor: fileHandle.fileDescriptor,
                                                           eventMask: .write,
                                                           queue: DispatchQueue.global())
        
        source.setEventHandler {[weak self] in
            guard let weakSelf = self else {
                return
            }

            weakSelf.process()
        }
        
        source.setCancelHandler {
            try? self.fileHandle?.close()
        }
        
        if isReadFile {
            // If new file, read file and move cursor to the end
            self.processFirstTime()
        } else {
            // If file is exist, move cursor to the end
            fileHandle.seekToEndOfFile()
        }
        
        source.resume()
        
        self.source = source
        
        return true
    }
    
    @discardableResult
    public func stopWatching() -> Bool {
        guard let source = source else {
            return false
        }
        
        source.cancel()
        self.source = nil
        
        return true
    }
    
    deinit {
        self.source?.cancel()
    }
}

// MARK: Private methods
extension FileWatcher {
    private func processFirstTime() {
        guard let newData = fileHandle?.readDataToEndOfFile() else {
            return
        }
        
        var additionString: String = ""
        
        if let string = String(data: newData, encoding: .shiftJIS), string.isEmpty == false {
            additionString = string
        } else if let string = String(data: newData, encoding: .utf8), string.isEmpty == false {
            additionString = string
        } else {
            print("can't read file!")
        }
        
        if additionString.isEmpty {
            return
        }
        
        let stringSplit = additionString.components(separatedBy: "\r\n")
        
        for element in stringSplit {
            if element.isEmpty {
                continue
            }
            
            print("First data \(element)")
        }
    }
    
    private func process() {
        guard let newData = fileHandle?.readDataToEndOfFile() else {
            return
        }
        
        var additionString: String = ""
        
        if let string = String(data: newData, encoding: .shiftJIS), string.isEmpty == false {
            additionString = string
        } else if let string = String(data: newData, encoding: .utf8), string.isEmpty == false {
            additionString = string
        } else {
            print("can't read file!")
        }
        
        if additionString.isEmpty {
            return
        }
        
        let stringSplit = additionString.components(separatedBy: "\n")
        
        for element in stringSplit {
            print("Data \(element)")
        }
    }
}

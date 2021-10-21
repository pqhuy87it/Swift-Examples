//
//  DirectoryDeepWatcher.swift
//  DirectoryWatcher
//
//  Created by Gianni Carlo on 3/18/20.
//  Copyright © 2020 Tortuga Power. All rights reserved.
//

import Foundation

public class DirectoryDeepWatcher: NSObject {
    var watchedUrl: URL
    var isWatchSubFolder: Bool
    
	typealias SourceObject = (source: DispatchSourceFileSystemObject, descriptor: Int32, url: URL)
    
	private var sources = [SourceObject]()
    private var queue: DispatchQueue?

    public var onFolderNotification: ((URL) -> Void)?
    public var onFileChangeNotification: ((URL) -> Void)?
    
    //init
    init(watchedUrl: URL, isWatchSubFolder: Bool) {
        self.watchedUrl = watchedUrl
		self.queue = DispatchQueue.global()
        self.isWatchSubFolder = isWatchSubFolder
    }
    
    public class func watch(_ url: URL, isWatchSubFolder: Bool = false) -> DirectoryDeepWatcher? {
        let directoryWatcher = DirectoryDeepWatcher(watchedUrl: url,
                                                    isWatchSubFolder: isWatchSubFolder)
		
		guard let sourceObject = directoryWatcher.createSource(from: url) else {
            return nil
        }
		
		directoryWatcher.sources.append(sourceObject)
        
        let errorHanler: ((URL, Error) -> Bool) = {(url, error) -> Bool in
            print("directoryEnumerator error at \(url): ", error)
            return true
        }
		
		guard let enumerator = FileManager.default.enumerator(at: url,
                                                        includingPropertiesForKeys: [.creationDateKey, .isDirectoryKey],
                                                        options: [.skipsHiddenFiles],
                                                        errorHandler: errorHanler) else {
            return nil
        }

		guard directoryWatcher.startWatching(with: enumerator) else {
            // Something went wrong, return nil
            return nil
        }

        return directoryWatcher
    }
	
	public func watch(_ url: URL) -> Bool {
		if !self.sources.isEmpty {
			self.stopWatching()
		}
		
		guard let sourceObject = self.createSource(from: url) else { return false }
		
		self.sources.append(sourceObject)
        
        let errorHanler: ((URL, Error) -> Bool) = {(url, error) -> Bool in
            print("directoryEnumerator error at \(url): ", error)
            return true
        }
		
		guard let enumerator = FileManager.default.enumerator(at: url,
                                                        includingPropertiesForKeys: [.creationDateKey, .isDirectoryKey],
                                                        options: [.skipsHiddenFiles],
                                                        errorHandler: errorHanler) else {
            return false
        }

		return self.startWatching(with: enumerator)
	}
	
	public func resetWatching() -> Bool {
		return self.watch(self.watchedUrl)
	}
	
	private func createSource(from url: URL) -> SourceObject? {
		let descriptor = open(url.path, O_EVTONLY)
        
        guard descriptor != -1 else {
            return nil
        }
		
		let source = DispatchSource.makeFileSystemObjectSource(fileDescriptor: descriptor,
                                                               eventMask: .write,
                                                               queue: self.queue)
		
		source.setEventHandler {[weak self] in
            self?.onFolderNotification?(url)
            
            let errorHandler: ((URL, Error) -> Bool) = { (url, error) -> Bool in
                print("directoryEnumerator error at \(url): ", error)
                return true
            }
			
			guard let enumerator = FileManager.default.enumerator(at: url,
                                                                  includingPropertiesForKeys: [.creationDateKey, .isDirectoryKey],
                                                                  options: [.skipsHiddenFiles],
                                                                  errorHandler: errorHandler) else {
                return
            }

			let _ = self?.startWatching(with: enumerator)
		}
		
        source.setCancelHandler(handler: {
            close(descriptor)
        })
		
		source.resume()
		
		return (source, descriptor, url)
	}
    
	private func startWatching(with enumerator: FileManager.DirectoryEnumerator) -> Bool {
		guard let url = enumerator.nextObject() as? URL else {
            return true
        }
		
        // if it is file
		if url.hasDirectoryPath == false {
            self.onFileChangeNotification?(url)
			return self.startWatching(with: enumerator)
        } else if self.isWatchSubFolder == false {
            return self.startWatching(with: enumerator)
        }
        
        let isExistUrl = (self.sources.contains { (source) -> Bool in
            return source.url == url
        })
		
        // checkf exist url in list
		if isExistUrl {
			return self.startWatching(with: enumerator)
		}
		
        // if not exist create new source
		guard let sourceObject = self.createSource(from: url) else { return false }
		
		self.sources.append(sourceObject)
        
		return self.startWatching(with: enumerator)
    }
    
    public func stopWatching() {
		for sourceObject in self.sources {
			sourceObject.source.cancel()
		}
		
		self.sources.removeAll()
    }
    
    deinit {
        let _ = self.stopWatching()
    }
}

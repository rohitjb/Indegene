import Foundation

protocol LocalFileManager {
    func savedPath(for url: URL) -> URL?
    func updateFileAndSaveIfDoesNotExist(at localPath: URL, url: URL) -> URL?
}

class IndengeLocalFileManager: LocalFileManager {
    let fileManager: FileManager
    
    init(fileManager: FileManager = FileManager.default) {
        self.fileManager = fileManager
    }
    
    func updateFileAndSaveIfDoesNotExist(at localPath: URL, url: URL) -> URL? {
        do {
            guard let savedURL = path(from: url) else { return nil }
            deleteFile(at: savedURL)
            try fileManager.moveItem(at: localPath, to: savedURL)
            self.deleteFile(at: localPath)
            return savedURL
        } catch {
            print ("file error: \(error)")
        }
        return nil
    }
    
    private func deleteFile(at location: URL) {
        if fileManager.fileExists(atPath: location.absoluteString) {
            try? fileManager.removeItem(at: location)
        }
    }

    private func path(from url: URL) -> URL? {
        do {
            let documentsURL = try
                fileManager.url(for: .documentDirectory,
                                in: .userDomainMask,
                                appropriateFor: nil,
                                create: false)
            guard let uniqueComponent = url.uniqueComponent() else { return nil }
            let savedURL = documentsURL.appendingPathComponent(uniqueComponent)
            return savedURL
        } catch {
            print("URL is not valid")
        }
        return nil
    }
    
    func savedPath(for url: URL) -> URL? {
        guard let filePath = path(from: url) else {
            return nil
        }
        let isExist = fileManager.fileExists(atPath: filePath.path)
        if isExist {
            return filePath
        }
        return nil
    }
}

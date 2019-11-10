//
//  FileProvider.swift
//  CleanMVVM
//
//  Created by Artem Eremeev on 13/10/2019.
//  Copyright © 2019 Artem Eremeev. All rights reserved.
//

import Foundation
import RxSwift

public class FileProvider {
    
    public static func isExists(fileName: String) -> Bool {
        return FileManager.default.fileExists(atPath: url(forFile: fileName).path)
    }
    
    public static func save(data: Data, fileName: String) {
        try! data.write(to: url(forFile: fileName))
    }
    
    public static func saveJPEGImage(image: UIImage, compressionQuality: CGFloat = 1.0, fileName: String) {
        save(data: image.jpegData(compressionQuality: compressionQuality)!, fileName: fileName)
    }
    
    public static func savePNGImage(image: UIImage, fileName: String) {
        save(data: image.pngData()!, fileName: fileName)
    }
    
    public static func save(fromURL url: URL, fileName: String) {
        let data = try! Data(contentsOf: url)
        self.save(data: data, fileName: fileName)
    }
    
    public static func image(named fileName: String) -> UIImage {
        let data = self.data(fromFile: fileName)
        return UIImage(data: data)!
    }
    
    public static func data(fromFile fileName: String) -> Data {
        return try! Data(contentsOf: url(forFile: fileName))
    }
    
    private static func url(forFile fileName: String) -> URL {
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = directoryURL.appendingPathComponent(fileName)
        return fileURL
    }
    
}

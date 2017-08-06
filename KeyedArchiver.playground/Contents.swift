//: Playground - noun: a place where people can play

import Cocoa

func readData(with name: String, extensionName: String, readingBlock: (Data) -> ()) {
    let homeDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    let url = URL(fileURLWithPath: homeDirectory, isDirectory: true)
    let dataURL = url.appendingPathComponent(name).appendingPathExtension(extensionName)
    
    do {
        let data = try Data(contentsOf: dataURL)
        readingBlock(data)
    } catch {
        print(error)
    }
}

func readFiles(withBlock readingBlock: (Data) -> ()) {
    readData(with: "data", extensionName: "data", readingBlock: readingBlock)
    readData(with: "window_1", extensionName: "data", readingBlock: readingBlock)
    readData(with: "window_2", extensionName: "data", readingBlock: readingBlock)
}

let archiverReadingBlock = { (data : Data) in
    do {
        let unarchivedData = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data as NSData) 
        print(unarchivedData)
    } catch {
        print (error)
    }
}

readFiles(withBlock: archiverReadingBlock)

let jsonReadingBlock = { (data : Data) in
    do {
        let deserializedData = try JSONSerialization.jsonObject(with: data, options: [])
        print(deserializedData)
    } catch {
        print(error)
    }
}

readFiles(withBlock: jsonReadingBlock)

let plistReadingBlock = { (data : Data) in
    do {
        let deserializedData = try PropertyListSerialization.propertyList(from: data, options: [], format: nil)
        print(deserializedData)
    } catch {
        print(error)
    }
}

readFiles(withBlock: plistReadingBlock)

let stringReadingBlock = { (data : Data) in
    do {
        let string = String(data: data, encoding: .utf8)
        print(string)
    } catch {
        print(error)
    }
}

readFiles(withBlock: stringReadingBlock)
// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import ArgumentParser
import RNCryptor

@available(macOS 13.0, *)
struct swiftyfiles : ParsableCommand {
    
    static let configuration = CommandConfiguration(abstract:"Segregate and Save files or Encrypt and Decrypt files",version:"1.0.0")
    
    @Option(name:.shortAndLong,help: "Password for encrypting and decrypting") var password : String?
    @Argument(help:"Select mode, E for encryption and Decryption and S for Saving.") var mode : String
    @Option(name:.shortAndLong,help: "Input File name") var inputFile : String?
    @Option(name: .shortAndLong,help: "Output File name") var outputFile : String?
    @Flag(name: .shortAndLong,help: "To Decrypt file") var decrypt = false
    @Option(name:.shortAndLong,help:"URL of the specified directory") var url : String?
    
    mutating func run() throws {
        if mode == "E" || mode == "e"{
            var converted = ""
            guard let input = try? String(contentsOfFile: inputFile ?? "") else {
                throw  RuntimeError(description: "Couldn't read from file '\(inputFile ?? "")'")
            }
            
            if decrypt {
                do{
                    converted = try decryptContents(encrpytedContents: input)
                }
                catch{
                    throw  RuntimeError(description: "Couldn't decrpyt file '\(inputFile!)'")
                }
            }
            else {
                converted = encryptContents(contents: input)
            }
            
            guard let _ = try? converted.write(toFile: outputFile!, atomically: true, encoding: .utf8)else{
                throw  RuntimeError(description: "Couldn't save file '\(outputFile!)'")
            }
        }
        else if mode == "S" || mode == "s" {
            //print("Save files!!")
            let fileManager = FileManager.default
            var extensions = [String]()
            
            let checkURL = URL(fileURLWithPath: url ?? "/")
            let dirURL = checkURL
            ///var fileURLs = [URL]
            guard let fileURLs = try? fileManager.contentsOfDirectory(at: dirURL,includingPropertiesForKeys: nil) else {
                print("Error getting list of files.")
                return
            }
            // fileURLs contains urls of all the files in the given directory
            
            // Getting the unique file types
            for file in fileURLs {
                if !extensions.contains(file.pathExtension) {
                    if file.pathExtension != "" || file.pathExtension != " "{
                        extensions.append(file.pathExtension)
                    }
                }
            }
            
            print("\n")
            if extensions.count-1 > 1 {
                print("Found \(extensions.count-1) types of files : ")
            }
            else {
                print("Found \(extensions.count-1) type of file : ")
            }
            print("\n")
            print(extensions.joined(separator: " "))
            print("\n")
            
            if extensions.count-1 != 0 && extensions.count != 0 {
                let prompt1 = "Choose the file type to be grouped into a folder…"
                print(prompt1)
                
                let input1 = readLine(strippingNewline: true)
                
                guard let answer1 = input1 else {
                    print("Invalid input.")
                    return
                }
                print("\n")
                let prompt2 = "Are you sure you want to group files of type: \(answer1)\nAnswer yes to continue/no to exit."
                print(prompt2)
                let input2 = readLine(strippingNewline: true)
                guard let answer2=input2?.lowercased() else {
                    print("Invalid Input")
                    return
                }
                
                if answer2 == "yes" {
                    print("\n")
                    let prompt3 = "Choose the folder name to store files of type: \(answer1)"
                    print(prompt3)
                    let input3 = readLine(strippingNewline: true)
                    
                    guard let answer3 = input3 else {
                        print("Invalid input.")
                        return
                    }
                    print("Grouping files by chosen filetype : \(answer1)")
                    print("\n")
                    var noOfFilesMoved = 0
                    // let subdirectoryURL = url ?? "/" + answer3 + "/"
                    var baseURL = url ?? "/"
                    if baseURL.last=="/"{
                        baseURL.removeLast()
                    }
                    let subdirectoryURL = baseURL+"/"
                    let subdirectoryUrlFinal = subdirectoryURL.appending(answer3)
                    print(subdirectoryUrlFinal)
                    do {
                        try fileManager.createDirectory(atPath: subdirectoryUrlFinal, withIntermediateDirectories: true, attributes: nil)
                    } catch {
                        print("Error creating subdirectory: \(error)")
                        return
                    }
                    for file in fileURLs {
                        if (file.pathExtension == answer1) {
                            do {
                                try fileManager.moveItem(atPath: file.path(), toPath: subdirectoryUrlFinal+"/"+file.lastPathComponent)
                                noOfFilesMoved = noOfFilesMoved + 1
                            }
                            catch let error as NSError {
                                print("Ooops! Couldn't move the file: \(file.lastPathComponent) because of error: \(error)")
                            }
                        }
                    }
                    print("\n")
                    if noOfFilesMoved <= 1 {
                        print("Successfully moved \(noOfFilesMoved) file!")
                    }else{
                        print("Successfully moved \(noOfFilesMoved) files!")
                    }
                }
            }
        }
        else{
            throw RuntimeError(description: "Select the mode correctly. Select either S to save files or E to encrypt, decrypt files. ")
        }
    }
    func encryptContents(contents:String) -> String {
        let contentsData = contents.data(using: .utf8)!
        let cipherData = RNCryptor.encrypt(data: contentsData,withPassword: password ?? "cipher101")
        return cipherData.base64EncodedString()
    }
    func decryptContents(encrpytedContents:String) throws -> String {
        let encyrptedData = Data.init(base64Encoded: encrpytedContents)!
        let decryptedData = try RNCryptor.decrypt(data: encyrptedData, withPassword: password ?? "cipher101")
        let decryptedString = String(data: decryptedData, encoding: .utf8)!
        return decryptedString
    }
}

if #available(macOS 13.0, *) {
    swiftyfiles.main()
} else {
    // Fallback on earlier versions
    print("Update your mac to the latest version")
}

struct RuntimeError:Error,CustomStringConvertible{
    var description: String
    init(description: String) {
        self.description = description
    }
}

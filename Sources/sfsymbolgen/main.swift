import Foundation
import ArgumentParser
import SFSymbolParserGen

class FileIO {
    
    /// Read file from disk or from STDIN if no filename is given
    static func read(filename: String?) throws -> Data? {
        if let filename = filename {
            return FileManager.default.contents(atPath: filename)
        }
        
        return nil
    }
    
    /// Write to standard out if no filename is given
    @available(macOS 10.15.4, *)
    static func write(text: String, filename: String?) throws {
        if let fileName = filename {
            try text.write(toFile: fileName, atomically: true, encoding: .utf8)
        }
        
        guard let data = text.data(using: .utf8) else { return }
        try FileHandle.standardOutput.write(contentsOf: data)
    }
}

struct SymbolGen: ParsableCommand {
    @Option(help: "File holding symbol data")
    var inputFileName: String
    
    @Option(help: "Location to output file")
    var outputFileLocation: String?
    
    @Option(help: "Name of enum to output")
    var enumName: String
    
    func run() throws {
        guard
            let data = try FileIO.read(filename: inputFileName),
            let inputText = String(data: data, encoding: .utf8)
        else {
            if #available(macOS 10.15.4, *) {
                try FileIO.write(text: "File does not exist", filename: nil)
            } else {
                // Fallback on earlier versions
            }
            return
        }
        
        let symbolsEnum = Parser.parse(name: enumName, rawInput: inputText)
        if #available(macOS 10.15.4, *) {
            try FileIO.write(text: symbolsEnum, filename: outputFileLocation)
        } else {
            // Fallback on earlier versions
        }
    }
}

SymbolGen.main()


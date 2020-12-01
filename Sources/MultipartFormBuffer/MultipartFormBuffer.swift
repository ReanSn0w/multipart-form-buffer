import Foundation

public class MultipartFormBuffer {
    private let boundary: String
    private var storage: Data
    
    private var newline: Data { "\n".data(using: .utf8)! }
    private var separator: Data { "--\(self.boundary)".data(using: .utf8)! }
    private var end: Data { "--\(self.boundary)--".data(using: .utf8)! }
    
    private var writer: Data {
        get {
            var result = storage
            result.append(end)
            return result
        }
        set(newData) {
            self.storage.append(newData)
        }
    }
    
    public init() {
        self.boundary = "Asrf456BGe4h"
        self.storage = Data()
    }
    
    public init(_ boundary: String) {
        self.boundary = boundary
        self.storage = Data()
    }
    
    public func addValue<T>(name: String, value: T) {
        guard let content = "\(value)".data(using: .utf8, allowLossyConversion: false) else {
            print("Не удалось записать контент")
            return
        }
        
        writeSimpleValue(name: name, val: content)
    }
    
    public func addFile(name: String, file: Data?, filename: String, mime: String) {
        guard let file = file else {
            print("Ошибка получения файла")
            return
        }
        guard let disp = "Content-Disposition: form-data; name=\"\(name)\"; filename=\"\(filename)\"".data(using: .utf8, allowLossyConversion: false) else {
            print("Ошибка генерации заголовка")
            return
        }
        guard let type = "Content-Type: \(mime)".data(using: .utf8, allowLossyConversion: false) else {
            print("Ошибка генерации типа")
            return
        }
        
        self.multiWrite([
            separator,
            newline,
            disp,
            newline,
            type,
            newline,
            newline,
            file,
            newline,
        ])
    }
    
    /// get - метод для получения данных из буфера
    public func get() -> Data {
        return writer
    }
    
    /// clear - метод для очистки буфера от данных
    public func clear() {
        storage = Data()
    }
    
    private func multiWrite(_ data: [Data]) {
        for item in data {
            writer = item
        }
    }
    
    private func writeSimpleValue(name: String, val: Data) {
        guard let disp = "Content-Disposition: form-data; name=\"\(name)\"".data(using: .utf8, allowLossyConversion: false) else {
            print("Ошибка генерации заголовка")
            return
        }
        
        self.multiWrite([
            separator,
            newline,
            disp,
            newline,
            newline,
            val,
            newline
        ])
    }
}

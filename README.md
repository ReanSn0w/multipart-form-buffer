# MultipartFormBuffer

 Класс для создания multipart/form-data форм.

### Пример использования
 
 ```
let buffer = MultipartFormBuffer()
 
// Добавление полей
buffer.addValue(
    name: "user",
    value: "someuser")

// Добавление файлов
buffer.addFile(
    name: "file",
    file: someFileData,
    filename: "image.jpg",
    type: "image/jpeg")


let multipartFormData = buffer.get()
 ```

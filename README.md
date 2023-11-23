# Ebooks Reader - (Desafio Tecnico 2 - Escribo)

## Description
This Dart program serves as an ebook reader application. The application retrieves a list of books, including their cover, title, and author, from this [API](https://escribo.com/books.json). Users can select and save ebooks to their mobile devices. By clicking on the desired ebook, the download is initiated, and the green icon on the card changes to indicate the download status. Users can then navigate to the 'Baixados' tab and select the ebook they wish to read. The ebook is opened using the [Vocsy Epub Viewer](https://pub.dev/packages/vocsy_epub_viewer) plugin.

## Usage
1 - Download the APK: An APK for testing purposes is available on Google Drive [here](https://drive.google.com/drive/folders/1BpYaCcFp0QY1ZZFjsLpqYh0m78Dyg86X?usp=sharing).

2 - Install the App: Download the APK from the provided Google Drive link and install the application on your mobile device.
![Captura de tela 2023-11-23 125649](https://github.com/Fernandoez/eBookReader/assets/69535503/d231ce4c-7119-4ed4-8bcc-5ad73e1e66d5){:width="200px"}

3 - Browse and Download Books: Open the app, browse the list of available books, and select the ones you want to download. The app will display the cover, title, and author information.

4 - Track Downloads: Once a book is selected for download, the card's icon will turn red, indicating the download is done.
![Captura de tela 2023-11-23 125821](https://github.com/Fernandoez/eBookReader/assets/69535503/e0a0b6c6-b0d3-46f2-be51-6811d24cc6cd){:width="200px"}

5 - Access Downloaded Ebooks: Navigate to the 'Baixados' tab to access the downloaded ebooks.
![Captura de tela 2023-11-23 130059](https://github.com/Fernandoez/eBookReader/assets/69535503/e1e8e71a-d216-48ba-b550-09cf01bf4436){:width="200px"}

6 - Read Ebooks: Select the ebook you want to read, and it will be opened using the Vocsy Epub Viewer plugin.
![Captura de tela 2023-11-23 130134](https://github.com/Fernandoez/eBookReader/assets/69535503/9f8df1fe-c646-493f-acbe-30699c609591){:width="200px"}

## Dependencies
Vocsy Epub Viewer: A plugin used to open and view ebooks in EPUB format.

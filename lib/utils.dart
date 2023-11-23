import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'books.dart';

class Utils{
  void bookDownload(Book book) {
    if (book.downloadUrl.isNotEmpty) {
      FileDownloader.downloadFile(
          url: book.downloadUrl,
          name: book.title,
          onProgress: (name, progress) {},
          onDownloadCompleted: (path) {
            print('Arquivo baixado em: $path');
          });
    } else {
      print('URL de download não disponível para o livro ${book.title}');
    }
  }
}

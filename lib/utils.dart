import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'books.dart';

class Utils {
  Future<bool> bookDownload(Book book) async {
    if (book.downloadUrl.isNotEmpty) {
      try {
        await FileDownloader.downloadFile(
          url: book.downloadUrl,
          name: '${book.title}.epub',
          onProgress: (name, progress) {},
          onDownloadCompleted: (path) {
            print('Arquivo baixado em: $path');
          },
          onDownloadError: (String error) {
            print('DOWNLOAD ERROR: $error');
          },
        );

        // O download foi concluído com sucesso
        return true;
      } catch (e) {
        // Ocorreu um erro durante o download
        print('Erro durante o download: $e');
        return false;
      }
    } else {
      print('URL de download não disponível para o livro ${book.title}');
      return false;
    }
  }
}
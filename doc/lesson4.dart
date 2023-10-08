/// Об'єкти
class Song {

  final String _title;
  final String _artist;
  final Duration _time;
  final int _year;

  Song (this._title, this._artist, this._time, this._year);

  String get title => _title;
  String get artist => _artist;
  Duration get time => _time;
  int get year => _year;

  String get getTime => "${_time.inHours}:${(_time.inMinutes % 60).toString().padLeft(2, '0')}:${(_time.inSeconds % 60).toString().padLeft(2, '0')}";

}

class Playlist with SearchMixin {

  final String _title;
  final List<Song> _songs;

  Playlist (this._title, this._songs);

  String get title => _title;
  List<Song> get songs => _songs;
}

/// Міксини
mixin SearchMixin {

  List<Song> search(List<Song> songs, String request) {
    return songs.where((song) => (
        song.title.toLowerCase().contains(request.toLowerCase()) ||
        song.artist.toLowerCase().contains(request.toLowerCase())
    )).toList();
  }

}

/// Методи розширення
extension SongsExtension on List<Song> {

  Duration getTotalTime() {
    return Duration(
      seconds: fold(0, (total, song) => (total + song.time.inSeconds))
    );
  }

}

void main() {

  //  Утворіть плейлист із колекцією пісень.
  List<Song> songs = [];
  for (int i = 0; i < 30; i++) {
    songs.add(Song("Title_$i", "Artist_${i % 4}", Duration(minutes: (10 + (i % 9))), (1990 + (i % 9))));
  }

  final Playlist playlist = Playlist("Title playlist", songs);
  // ==============================================

  // Виведення плейлиста у форматованому вигляді
  print("Playlist: ${playlist.title}");
  for(int i = 0; i < playlist.songs.length; i++) {
    print("${(i + 1).toString().padLeft(2, ' ')}. ${playlist.songs[i].title}(${playlist.songs[i].year}) - ${playlist.songs[i].artist} - ${playlist.songs[i].getTime}");
  };
  // ==============================================

  // фільтрація
  const String find = "Artist_3";
  final List<Song> filtered = playlist.search(playlist.songs, find);
  print("\n");
  print("Search: $find ");

  for(int i = 0; i < filtered.length; i++) {
    print("${(i + 1).toString().padLeft(2, ' ')}. ${filtered[i].title}(${filtered[i].year}) - ${filtered[i].artist} - ${filtered[i].getTime}");
  };
  // ==============================================

  // Загальна тривалість пісень
  final totalTime = playlist.songs.getTotalTime();
  print("\n");
  print("Total time: ${totalTime.inHours}:${(totalTime.inMinutes % 60).toString().padLeft(2, '0')}:${(totalTime.inSeconds % 60).toString().padLeft(2, '0')}");
  // ==============================================

}
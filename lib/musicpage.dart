import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class MusicApp extends StatefulWidget {
  final int score;

  const MusicApp({Key? key, required this.score}) : super(key: key);

  @override
  State<MusicApp> createState() => _MusicAppState();
}

class _MusicAppState extends State<MusicApp> {
  List<Map<String, String>> musicList = [
    // Your music list data
    {
      "title": "Dreams",
      "singer": "Zayn Malik",
      "cover":
          "https://st5.depositphotos.com/56966306/65563/i/450/depositphotos_655636908-stock-illustration-captivating-hobbies-pastimes-celebrating-joy.jpg",
      "url":
          "https://assets.mixkit.co/music/preview/mixkit-life-is-a-dream-837.mp3",
    },
    {
      "title": "Feeling Happy",
      "singer": "Harry",
      "cover":
          "https://i.scdn.co/image/ab67616d0000b27315f5db21019fecde6856dffc",
      "url":
          "https://assets.mixkit.co/music/preview/mixkit-feeling-happy-5.mp3",
    },
    {
      "title": "Changing My Mind",
      "singer": "Betty Allen",
      "cover":
          "https://media.istockphoto.com/id/476498669/photo/zen-stones-balance.jpg?s=612x612&w=0&k=20&c=Xrdy-WOnFl1e1Qx7IQWHr1iz0aytfL1UOJQl0y501hQ=",
      "url":
          "https://assets.mixkit.co/music/preview/mixkit-dance-with-me-3.mp3",
    },
    {
      "title": "Happy",
      "singer": "Charles Anthony",
      "cover":
          "https://boomboomnaturals.com/cdn/shop/articles/rejuvenate_your_mind.jpg?v=1540922750",
      "url": "https://assets.mixkit.co/music/preview/mixkit-sleepy-cat-135.mp3",
    },
    {
      "title": "Life as a Teenager",
      "singer": "Ahjay Stelino",
      "cover":
          "https://i.vimeocdn.com/video/1469531732-08d627a9ea55266001f45c31892da3eaf3a92cd37849378a6fb5cabeae8f0e54-d_640x360.jpg",
      "url": "https://assets.mixkit.co/music/preview/mixkit-delightful-4.mp3",
    },
    {
      "title": "Little Wonders",
      "singer": "Michael Ramir",
      "cover":
          "https://st2.depositphotos.com/1735158/7733/i/450/depositphotos_77335584-stock-photo-seagul-on-stone-onsea-coast.jpg",
      "url":
          "https://assets.mixkit.co/music/preview/mixkit-life-is-a-dream-837.mp3",
    },
    {
      "title": "Sense of Self",
      "singer": "Luther Allison",
      "cover":
          "https://3.bp.blogspot.com/-tp_VoTwPq20/UGc6AwsrK5I/AAAAAAAAPOs/mmfLsC_xKXo/s640/Harvest_Moon_by_goldleaf09.jpg",
      "url":
          "https://assets.mixkit.co/music/preview/mixkit-feeling-happy-5.mp3",
    },
    {
      "title": "Brighter Days",
      "singer": "Eddy Arnold",
      "cover":
          "https://media.istockphoto.com/id/1394645908/photo/white-cherry-plum-flowers-with-dew-drops-in-early-spring-flowering-fruit-trees-prunus.webp?b=1&s=170667a&w=0&k=20&c=Wbz_Wwi3FCqFtUGTXSw8Bhk1oeqFhRD7XO5GNFC6QZA=",
      "url":
          "https://assets.mixkit.co/music/preview/mixkit-dance-with-me-3.mp3",
    },
    {
      "title": "My Things",
      "singer": "Nick Ashford",
      "cover":
          "https://images.pexels.com/photos/1122868/pexels-photo-1122868.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
      "url": "https://assets.mixkit.co/music/preview/mixkit-sleepy-cat-135.mp3",
    },
    {
      "title": "Keeping It Reel",
      "singer": "Tex Beneke",
      "cover":
          "https://images.pexels.com/photos/259707/pexels-photo-259707.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
      "url": "https://assets.mixkit.co/music/preview/mixkit-delightful-4.mp3",
    },
  ];

  late AudioPlayer _audioPlayer;
  bool isPlaying = false;
  late Duration musicDuration;
  late Duration musicPosition;
  late String currentTitle;
  late String currentSinger;
  late String currentCover;
  late String currentSong;
  late IconData btnIcon;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    musicDuration = const Duration();
    musicPosition = const Duration();
    currentTitle = "";
    currentSinger = "";
    currentCover = "";
    currentSong = "";
    btnIcon = Icons.play_arrow;

    _audioPlayer.onDurationChanged.listen((event) {
      setState(() {
        musicDuration = event;
      });
    });

    _audioPlayer.onPositionChanged.listen((event) {
      setState(() {
        musicPosition = event;
      });
    });
  }

  Future<void> playMusic(String url) async {
    if (isPlaying && currentSong == url) {
      await _audioPlayer.pause();
      setState(() {
        isPlaying = false;
        btnIcon = Icons.play_arrow;
      });
    } else {
      await _audioPlayer.play(UrlSource(url));
      setState(() {
        isPlaying = true;
        btnIcon = Icons.pause;
        currentSong = url;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredMusicList = [];

    // Filter the music list based on the score
    if (widget.score < 15) {
      filteredMusicList = musicList.sublist(0, 3);
    } else if (widget.score >= 15 && widget.score <= 30) {
      filteredMusicList = musicList.sublist(0, 3);
    } else {
      filteredMusicList = musicList.sublist(3);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/bg.jpg"), fit: BoxFit.cover)),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(
                  left: 22.0,
                  right: 22.0,
                  top: 15.0,
                  bottom: 15.0,
                ),
                alignment: Alignment.topLeft,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /*Text(
                      "Music play",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 22.0,
                      ),
                    ),*/
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: filteredMusicList.length,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        playMusic(filteredMusicList[index]["url"]!);
                        setState(() {
                          currentTitle = filteredMusicList[index]["title"]!;
                          currentSinger = filteredMusicList[index]["singer"]!;
                          currentCover = filteredMusicList[index]["cover"]!;
                        });
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                            filteredMusicList[index]["cover"]!,
                          ),
                        ),
                        title: Text(
                          filteredMusicList[index]["title"]!,
                          style: TextStyle(
                            color: Colors.blue.shade500,
                          ),
                        ),
                        subtitle: Text(
                          filteredMusicList[index]["singer"]!,
                          style: TextStyle(
                            color: Colors.blue.shade500,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                        trailing: Container(
                          margin: const EdgeInsets.all(17.0),
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {}, // Empty onPressed
                            icon: Icon(
                              Icons.music_note,
                              color: Colors.blue.shade500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Container(
                      color: Colors.blue.shade500,
                      height: 1.0,
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(currentCover),
                      ),
                      title: Text(
                        currentTitle,
                        style: TextStyle(
                          color: Colors.blue.shade500,
                        ),
                      ),
                      subtitle: Text(
                        currentSinger,
                        style: TextStyle(
                          color: Colors.blue.shade500,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                      trailing: Container(
                        height: 40.0,
                        width: 40.0,
                        margin: const EdgeInsets.all(7.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.blue.shade500,
                          ),
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            playMusic(currentSong);
                          },
                          icon: Icon(
                            btnIcon,
                            size: 26,
                            color: Colors.blue.shade500,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 22.0,
                        right: 30.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "${musicPosition.inMinutes}:${musicPosition.inSeconds.remainder(60)}",
                            style: TextStyle(
                              color: Colors.blue.shade500,
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                          Expanded(
                            child: Slider.adaptive(
                              activeColor: Colors.blue.shade500,
                              inactiveColor: Colors.grey,
                              value: musicPosition.inSeconds.toDouble(),
                              max: musicDuration.inSeconds.toDouble(),
                              onChanged: (val) {},
                            ),
                          ),
                          Text(
                            "${musicDuration.inMinutes}:${musicDuration.inSeconds.remainder(60)}",
                            style: TextStyle(
                              color: Colors.blue.shade500,
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

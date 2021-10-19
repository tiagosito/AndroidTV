import 'package:androidtv/movies.dart';
import 'package:androidtv/video_player.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> _actionMovieCards = [];
  List<Widget> _bollywoodMovieCards = [];
  final GlobalKey _listKey = GlobalKey();

  void addMovies() {
    List<Movie> _actionMovies = [
      Movie(title: 'Dracula', image: 'https://wallpaperaccess.com/full/1923020.jpg', url: 'https://www.youtube.com/watch?v=_2aWqecTTuE'),
      Movie(
          title: 'The Maze Runner',
          image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQczM9W4ScNshPLjZLLRFbNvxzBL7vXOLjTxXZvp2OZE3ri3w2JsNjdpNV5erKRNfTyDzc&usqp=CAU',
          url: 'https://www.youtube.com/watch?v=AwwbhhjQ9Xk'),
      Movie(title: '300', image: 'https://wallpapercave.com/wp/wp2162772.jpg', url: 'https://www.youtube.com/watch?v=UrIbxk7idYA'),
      Movie(title: 'Venom', image: 'https://mountaincrestexpress.com/wp-content/uploads/2018/10/Venom-1-1024x756.png', url: 'https://www.youtube.com/watch?v=u9Mv98Gr5pY'),
      Movie(title: 'Pirates Of the Caribbean', image: 'https://cdn.wallpapersafari.com/45/66/q2rdlZ.jpg', url: 'https://www.youtube.com/watch?v=Hgeu5rhoxxY')
    ];
    List<Movie> _bollywoodMovies = [
      Movie(title: 'Shaandar', image: 'https://www.whoa.in/download/shaandaar-bollywood-movies-hd-poster', url: 'https://www.youtube.com/watch?v=k99-vMPh3-A'),
      Movie(title: '2 States', image: 'https://wallpaperaccess.com/full/1494461.jpg', url: 'https://www.youtube.com/watch?v=CGyAaR2aWcA'),
      Movie(
          title: 'Ishaqzaade',
          image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTSwxz8bwLoiW2C81B6IlqvgnK_ViI9-XPvoQ&usqp=CAU',
          url: 'https://www.youtube.com/watch?v=46kTKQ0C2Ek'),
      Movie(
          title: 'Kick',
          image: 'https://images.wallpapersden.com/image/ws-tiger-shroff-and-hrithik-roshan-war-movie_66472.jpg',
          url: 'https://www.youtube.com/watch?v=u-j1nx_HY5o'),
      Movie(
          title: 'Happy New Year',
          image: 'https://c4.wallpaperflare.com/wallpaper/194/620/840/movies-bollywood-movies-wallpaper-preview.jpg',
          url: 'https://www.youtube.com/watch?v=JGHwANkQFrg')
    ];
    _actionMovies.forEach((movie) {
      _actionMovieCards.add(buildCard(movie));
    });
    _bollywoodMovies.forEach((movie) {
      _bollywoodMovieCards.add(buildCard(movie));
    });
  }

  Widget buildCard(Movie movie) {
    return InkWell(
      focusColor: Colors.white,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VideoPlayer(
              url: movie.url,
            ),
          ),
        );
      },
      child: SizedBox(
        height: 200,
        width: 200,
        child: Card(
          color: Colors.black12,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Image.network(
                  movie.image,
                  fit: BoxFit.cover,
                ),
              ),
              const Divider(
                color: Colors.white,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(movie.title, style: const TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    addMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Action Movies',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 18),
                ),
              ),
              SizedBox(
                height: 200,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    key: _listKey,
                    itemCount: _actionMovieCards.length,
                    itemBuilder: (context, index) {
                      return _actionMovieCards[index];
                    }),
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Bollywood Movies',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 18),
                ),
              ),
              SizedBox(
                height: 200,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    //key: _listKey,
                    itemCount: _bollywoodMovieCards.length,
                    itemBuilder: (context, index) {
                      return _bollywoodMovieCards[index];
                    }),
              ),
            ],
          ),
        ));
  }
}

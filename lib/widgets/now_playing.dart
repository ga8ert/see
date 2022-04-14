
import 'package:flutter/material.dart';
import 'package:page_indicator/page_indicator.dart';


import 'package:untitled/bloc/get_now_playing_bloc.dart';
import 'package:untitled/model/movie.dart';
import 'package:untitled/model/movie_response.dart';
import 'package:untitled/style/theme.dart' as Style;

class NowPlaying extends StatefulWidget {
  const NowPlaying({Key? key}) : super(key: key);

  @override
  State<NowPlaying> createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {

  @override
  void initState() {
    super.initState();
    nowPlayingMoviesBloc.getMovies();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MovieResponse>(
      stream: nowPlayingMoviesBloc.subject.stream,
      builder: (context, AsyncSnapshot<MovieResponse> snapshot){
        if (snapshot.hasData){
          if(snapshot.data!.error != null && snapshot.data!.error.length > 0){
            return _buildErrorWidget(snapshot.data!.error);
          }
          return _buildNowPlayingWidget(snapshot.data!);
        }else if (snapshot.hasError){
          return _buildErrorWidget(snapshot.error);
        }else {
          return _buildLoadingWidget();
        }
      });
  }

   _buildLoadingWidget(){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 25,
            width: 25,
            child: CircularProgressIndicator(
              valueColor:  AlwaysStoppedAnimation<Color>(Colors.white),
              strokeWidth: 4,
            ),
          ),
        ],
      ),
    );
  }

   _buildErrorWidget (error){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Error occured: $error"),
        ],
      ),
    );
  }

  _buildNowPlayingWidget(MovieResponse data){
    List<Movie> movies = data.movies;
    if(movies.length == 0){
      return Container(
        width:  MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("No Movies"),
          ],
        ),
      );
    } else{
      return Container(
        height: 220,
        child: PageIndicatorContainer(
          align:  IndicatorAlign.bottom,
          indicatorSpace: 8,
          padding: EdgeInsets.all(5),
          indicatorColor: Style.Colors.titleColor,
          indicatorSelectorColor: Style.Colors.secondColor,
          shape: IndicatorShape.circle(size: 8),
          child: PageView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.take(5).length,
            itemBuilder: (context, index){
              return Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 720,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      image: DecorationImage(image: NetworkImage("https://image.tmdb.org/t/p/original/"+ movies[index].backPoster),
                      fit: BoxFit.cover
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Style.Colors.mainColor.withOpacity(1),
                        Style.Colors.mainColor.withOpacity(0),
                      ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        stops: [0.0, 0.9,]
                      ),
                    ),
                  ),
                ],
              );
            }
          ),
          length: movies.take(5).length,
        ),
      );
    }
  }
}

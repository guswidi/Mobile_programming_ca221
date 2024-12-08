import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/core/utils/bloc_provider.dart';
import 'package:myapp/core/utils/repository_provider.dart';
import 'package:myapp/core/resources/colors.dart';
import 'package:myapp/core/resources/strings.dart';
import 'package:myapp/core/utils/route_provider.dart';
import 'package:myapp/repositories/databases/comment_repository.dart'; // Import repository

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        ...repositoryProviders,
        RepositoryProvider<CommentRepository>(create: (context) => CommentRepositoryImpl()), // Menyediakan CommentRepositoryImpl dengan tipe yang tepat
      ],
      child: MultiBlocProvider(
        providers: blocProviders,
        child: MaterialApp(
          title: appName,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Poppins',
            colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
            useMaterial3: true,
          ),
          initialRoute: '/',
          onGenerateRoute: AppRouter.generateRoute,
        ),
      ),
    );
  }
}

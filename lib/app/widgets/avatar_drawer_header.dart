import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:run_to_claim/auth/models/user.dart';

class AvatarDrawerHeader extends StatelessWidget {
  const AvatarDrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final userProfile = User(id: '1', firstName: 'John', lastName: 'Doe');

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: DrawerHeader(
        decoration: const BoxDecoration(color: Colors.red),
        padding: EdgeInsets.zero,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<dynamic>(
                    builder: (context) => Container(),
                    fullscreenDialog: true,
                  ),
                );
              },
              child: ClipOval(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    if (userProfile.photo?.isEmpty == true)
                      Container(
                        height: 80,
                        width: 80,
                        color: Colors.red,
                        child: const Image(
                          width: 80,
                          height: 80,
                          image: AssetImage('assets/profile.jpeg'),
                        ),
                      )
                    else
                      CachedNetworkImage(
                        fit: BoxFit.cover,
                        width: 80,
                        height: 80,
                        placeholder: (context, url) => const SizedBox(
                          height: 20,
                          width: 20,
                          child: Center(child: CircularProgressIndicator()),
                        ),
                        errorWidget: (context, url, error) => ClipOval(
                          child: Container(
                            height: 80,
                            width: 80,
                            color: Colors.red,
                            child: const Image(
                              width: 80,
                              height: 80,
                              image: AssetImage('assets/profile.jpeg'),
                            ),
                          ),
                        ),
                        imageUrl: userProfile.photo ?? '',
                      ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        width: 80,
                        color: Colors.red,
                        child: const Icon(
                          Icons.edit,
                          size: 20,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Text(
              '${userProfile.firstName} ${userProfile.lastName}',
              style: const TextStyle(color: Colors.white),
            ),
            const Text(
              'MEMBER',
              style: TextStyle(color: Colors.white, fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }
}

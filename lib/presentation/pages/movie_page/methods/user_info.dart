import 'package:flix_id_app/presentation/extensions/int_extension.dart';
import 'package:flix_id_app/presentation/misc/methods.dart';
import 'package:flix_id_app/presentation/providers/user_data/user_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Widget userInfo(WidgetRef ref) => Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1,
              ),
              shape: BoxShape.circle,
              image: DecorationImage(
                image: ref.watch(userDataProvider).valueOrNull?.photoUrl != null
                    ? NetworkImage(
                            ref.watch(userDataProvider).valueOrNull!.photoUrl!)
                        as ImageProvider
                    : const AssetImage('lib/assets/pp-placeholder.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          horizontalSpaces(16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${getGreeting()}, ${ref.watch(userDataProvider).when(
                      data: (user) => user?.name.split(' ').first ?? '',
                      error: (error, stackTrace) => '',
                      loading: () => 'Loading...',
                    )}!',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const Text(
                "Let's book your favorite movie!",
                style: TextStyle(fontSize: 12),
              ),
              verticalSpaces(5),
              GestureDetector(
                onTap: () {
                  // Go to wallet page
                },
                child: Row(
                  children: [
                    SizedBox(
                      width: 18,
                      height: 18,
                      child: Image.asset('lib/assets/wallet.png'),
                    ),
                    horizontalSpaces(10),
                    Text(
                      ref.watch(userDataProvider).when(
                            data: (user) =>
                                (user?.balance ?? 0).toIDRCurrecyFormat(),
                            error: (error, stackTrace) => 'IDR 0',
                            loading: () => 'Loading...',
                          ),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );

String getGreeting() {
  var hour = DateTime.now().hour;
  if (hour < 12) {
    return 'Good Morning';
  } else if (hour < 18) {
    return 'Good Afternoon';
  } else {
    return 'Good Evening';
  }
}
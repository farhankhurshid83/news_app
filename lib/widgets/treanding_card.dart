import 'package:flutter/material.dart';
class TreandingCard extends StatelessWidget {
  final String imagurl;
  final String tag;
  final String time;
  final String title;
  final String auther;
  final VoidCallback onTap;
  const TreandingCard({super.key, required this.imagurl, required this.tag, required this.time, required this.title, required this.auther, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(right: 10),
        padding: const EdgeInsets.all(10),
        height: 270,
        width: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).colorScheme.background,
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(imagurl, fit: BoxFit.fill,)),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("$tag",
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                Text("$time",
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                    child: Text("$title",
                      maxLines: 3,
                      style: Theme.of(context).textTheme.labelLarge,)),
              ],
            ),
            SizedBox(height: 5,),
            Row(
              children: [
                CircleAvatar(
                  radius: 15,
                  backgroundColor:  Theme.of(context).colorScheme.primary,),
                SizedBox(width: 5,),
                Expanded(child: Text("$auther"))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

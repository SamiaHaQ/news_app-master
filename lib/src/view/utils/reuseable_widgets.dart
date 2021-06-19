import 'package:flutter/material.dart';

import 'constants.dart';

class InputTextField extends StatelessWidget {
  final String hint;
  final bool obscureText, forgotOption;
  final TextEditingController textEditingController;
  final IconData iconData;
  final TextInputType textInputType;
  final Function forgotFunction;

  InputTextField({@required this.forgotOption,@required this.forgotFunction, @required this.textInputType, @required this.hint, @required this.obscureText, @required this.textEditingController, @required this.iconData});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: textInputType,
      decoration: InputDecoration(
        hintText: '$hint',
        fillColor: kTextFieldBgColor,
        prefixIcon: Icon(iconData),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        labelText: '$hint',
        suffix: obscureText == true && forgotOption == true? InkWell(
          onTap: forgotFunction,
          child: Text(
            'Forgot?',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: kDarkBlueColor
            ),
          ),
        ) : null,
      ),
      obscureText: obscureText,
      controller: textEditingController,
    );
  }
}

class RoundedButton extends StatelessWidget {
  RoundedButton({@required this.buttonText, @required this.onPressed, @required this.inProgress, @required this.disable});

  final bool inProgress, disable;
  final String buttonText;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: RaisedButton(
        color: kDarkGreenColor,
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            child: inProgress ? CircularProgressIndicator() : Text('$buttonText', style: TextStyle(color: kWhiteColor, fontSize: 20),)
        ),
        onPressed: disable ? (){} : onPressed,
      ),
    );
  }
}

class NewsCard extends StatelessWidget {
  NewsCard({@required this.title, @required this.imageUrl, @required this.description, @required this.publishedAt, @required this.onTap});
  final String title, description, publishedAt, imageUrl;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 2,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 150,
              height: 150,
              child: FadeInImage(
                image: NetworkImage('$imageUrl'),
                fit: BoxFit.cover,
                placeholder: AssetImage('assets/images/news.png'),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8.0),
                  width: MediaQuery.of(context).size.width - 200,
                  child: Text(
                    '$title',
                    style: TextStyle(
                        color: kSoftBlackColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Chip(
                        label: Text('${publishedAt.split("T")[1]+"  "+publishedAt.split("T")[0]}', style: TextStyle(color: kWhiteColor, fontSize: 12, fontWeight: FontWeight.w500),),
                        backgroundColor: kDarkBlueColor,
                      ),
                    ],
                  ),
                )
              ],
            )

          ],
        ),
      ),
    );
  }
}

class ChartRowWithLabel extends StatelessWidget {
  ChartRowWithLabel({@required this.text, @required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: <Widget>[
          Container(
            color: color,
            height: 16,
            width: 16,
            child: null,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
              '$text'
          ),
        ],
      ),
    );
  }
}

class RichTextLabel extends StatelessWidget {

  RichTextLabel({@required this.name, @required this.value});

  final String name;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            '$name',
            style: TextStyle(
                fontSize: 16
            ),
          ),
          Text(
            '$value',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600
            ),
          )
        ],
      ),
    );
  }
}
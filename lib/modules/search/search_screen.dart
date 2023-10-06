import 'package:flutter/material.dart';
import 'package:To_Know_Me/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        actions: [
          Icon(
            Icons.content_paste_search_outlined,
            size: 24.0,
          ),
          SizedBox(
            width: 20.0,
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              defaultTextFormField(
                controller: searchController,
                keyboardType: TextInputType.text,
                action: TextInputAction.search,
                validation: (value) {
                  if (value.isEmpty) return 'Search For Any Friend';
                },
                onSubmit: (String text) {},
                labelText: "Search for friends",
                prefixIcon: Icons.manage_search_outlined,
              ),
              SizedBox(
                height: 10.0,
              ),
              // if (state is SearchLodingState) LinearProgressIndicator(),
              SizedBox(
                height: 20.0,
              ),
              // if (state is! SearchSuccessState)
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.blue, width: 1),
                      ),
                      child: Icon(
                        Icons.find_in_page_outlined,
                        size: 60.0,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Search For What You Want',
                      style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.blue,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              SizedBox(
                height: 20,
              ),
              // if (state is SearchSuccessState)
                Expanded(
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) => Text("Test",textAlign: TextAlign.center,),
                    separatorBuilder: (context, index) => Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                    ),
                    itemCount: 10,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

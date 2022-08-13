import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rentready/data/dataverse.dart';

import 'data/globals.dart';
import 'data/service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dataverse',
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromARGB(255, 219, 219, 219),
        primaryColor: Colors.black,
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int viewoption = 0;

  void buildFilterParams() {
    filter = ''; // resetting previous filter
    if (filter1value != '') {
      filter = '&\$filter=address1_stateorprovince eq \'$filter1value\'';
    }
    if (filter2value != '') {
      filter = '&\$filter=statecode eq $filter2value';
    }
    if (filter1value != '' && filter2value != '') {
      filter =
          '&\$filter=(address1_stateorprovince eq \'$filter1value\' and  statecode eq $filter2value)';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 4, // 40%
                      child: TextField(
                        onChanged: (value) {},
                        onSubmitted: (value) {
                          setState(() {
                            searchtext = value;
                          });
                        },
                        textInputAction: TextInputAction.search,
                        decoration: const InputDecoration(
                          prefixIconColor: Colors.black,
                          hintText: "Search",
                          prefixIcon: Icon(Icons.search),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3, // 30%
                      child: ElevatedButton.icon(
                        onPressed: () {
                          showModalBottomSheet<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return StatefulBuilder(builder:
                                    (BuildContext context,
                                        StateSetter mystate) {
                                  return Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.35,
                                      color: Colors.white,
                                      child: Center(
                                          child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Text('State or Province'),
                                            DropdownButton(
                                              // Initial Value
                                              value: filter1value,
                                              // Down Arrow Icon
                                              icon: const Icon(
                                                  Icons.keyboard_arrow_down),
                                              // Array list of items
                                              items: filter1items
                                                  .map((String items) {
                                                return DropdownMenuItem(
                                                  value: items,
                                                  child: Text(items),
                                                );
                                              }).toList(),
                                              // After selecting the desired option,it will
                                              // change button value to selected value
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  filter1value = newValue!;
                                                  buildFilterParams();
                                                  Navigator.pop(context);
                                                });
                                              },
                                            ),
                                            Text('State Code'),
                                            DropdownButton(
                                              // Initial Value
                                              value: filter2value,
                                              // Down Arrow Icon
                                              icon: const Icon(
                                                  Icons.keyboard_arrow_down),
                                              // Array list of items
                                              items: filter2items
                                                  .map((String items) {
                                                return DropdownMenuItem(
                                                  value: items,
                                                  child: Text(items),
                                                );
                                              }).toList(),
                                              // After selecting the desired option,it will
                                              // change button value to selected value
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  filter2value = newValue!;
                                                  buildFilterParams();
                                                  Navigator.pop(context);
                                                });
                                              },
                                            ),
                                            Padding(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          onPrimary:
                                                              Colors.white,
                                                          elevation: 1,
                                                          primary:
                                                              Color.fromARGB(
                                                                  0,
                                                                  255,
                                                                  255,
                                                                  255),
                                                          side:
                                                              const BorderSide(
                                                            width: 0,
                                                            color: Colors
                                                                .transparent,
                                                          ),
                                                        ), //
                                                        child: const Text(
                                                            'Clear Filters',
                                                            style: TextStyle(
                                                                fontSize: 20)),
                                                        onPressed: () {
                                                          filter = '';
                                                          filter1value = '';
                                                          filter2value = '';
                                                          Navigator.pop(
                                                              context);
                                                          setState(() {});
                                                        }),
                                                    // ElevatedButton(
                                                    //     child: const Text(
                                                    //         'Apply',
                                                    //         style: TextStyle(
                                                    //             fontSize: 20)),
                                                    //     onPressed: () {
                                                    //       Navigator.pop(
                                                    //           context);
                                                    //       setState(() {});
                                                    //     })
                                                  ],
                                                ))
                                          ],
                                        ),
                                      )));
                                });
                              }).whenComplete(() {
                            if (kDebugMode) {
                              print('filter popup closed');
                            }
                            setState(() {});
                            //Navigator.pop(context);
                          });
                        },
                        icon: const Icon(
                          Icons.filter_alt,
                          size: 24.0,
                        ),
                        label: const Text('Filter'),
                        style: ElevatedButton.styleFrom(
                          onPrimary: Colors.black,
                          elevation: 1,
                          primary: Color.fromARGB(0, 0, 0, 0),
                          shadowColor: Colors.transparent.withOpacity(0),
                          side: const BorderSide(
                            width: 0,
                            color: Colors.transparent,
                          ),
                        ), // <-- Text
                      ),
                    ),
                    Expanded(
                      flex: 3, // 30%
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.view_list,
                            ),
                            iconSize: 20,
                            color: Colors.black,
                            onPressed: () {
                              setState(() {
                                viewoption = 0;
                              });
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.view_comfy_alt,
                            ),
                            iconSize: 20,
                            color: Colors.black,
                            onPressed: () {
                              setState(() {
                                viewoption = 1;
                              });
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                )),
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: FutureBuilder<AccountData>(
                      future: fetchData(),
                      builder: (context, future) {
                        if (future.connectionState == ConnectionState.waiting) {
                          return const SizedBox(
                              height: 80.0,
                              child:
                                  Center(child: CircularProgressIndicator()));
                        } else {
                          if (future.hasData) {
                            AccountData? list = future.data;

                            if ((list?.value?.length)! > 0) {
                              return (viewoption == 0)
                                  ? ListView.builder(
                                      itemCount: list?.value?.length,
                                      itemBuilder: (context, index) {
                                        return Card(
                                          color: Colors.white,
                                          child: Row(
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Image.network(
                                                    (list!.value![index]
                                                                .entityimage ==
                                                            null)
                                                        ? 'https://via.placeholder.com/150'
                                                        : list!.value![index]
                                                            .entityimage
                                                            .toString(),
                                                    fit: BoxFit.fitWidth),
                                              ),
                                              Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        child: Text(
                                                            list!.value![index]
                                                                .name
                                                                .toString(),
                                                            style: const TextStyle(
                                                                fontSize: 18.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold))),
                                                    Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                                list!
                                                                    .value![
                                                                        index]
                                                                    .accountnumber
                                                                    .toString(),
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        18.0)),
                                                            Text(' '),
                                                            Text(
                                                                list!
                                                                    .value![
                                                                        index]
                                                                    .address1Stateorprovince
                                                                    .toString(),
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        18.0))
                                                          ],
                                                        )),
                                                  ])
                                            ],
                                          ),
                                        );
                                      })
                                  : GridView.builder(
                                      itemCount: list?.value?.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio:
                                            MediaQuery.of(context).size.width /
                                                (MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    1.4),
                                      ),
                                      itemBuilder: (context, index) {
                                        return Card(
                                            color: Colors.white,
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: Image.network(
                                                        (list!.value![index]
                                                                    .entityimage ==
                                                                null)
                                                            ? 'https://via.placeholder.com/150'
                                                            : list!
                                                                .value![index]
                                                                .entityimage
                                                                .toString(),
                                                        fit: BoxFit.fitWidth),
                                                  ),
                                                  Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      child: Text(
                                                          list!.value![index]
                                                              .name
                                                              .toString(),
                                                          style: const TextStyle(
                                                              fontSize: 18.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))),
                                                  Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      child: Text(
                                                          list!.value![index]
                                                              .accountnumber
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                                  fontSize:
                                                                      18.0))),
                                                ]));
                                      });
                            } // Display message if the list is empty
                            else {
                              return const Padding(
                                padding: EdgeInsets.all(40),
                                child: Text("No record found."),
                              );
                            }
                            ;
                          } // Display message if the list is empty
                          else
                            return Padding(
                              padding: EdgeInsets.all(40),
                              child: Text("No record found."),
                            );
                        }
                      })),
            ),
          ],
        ),
      ),
    );
  }
}

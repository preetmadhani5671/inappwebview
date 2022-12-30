import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:inappwebview/screen/homeScreen/provider/webProvider.dart';
import 'package:provider/provider.dart';

class inappWebview extends StatefulWidget {
  const inappWebview({Key? key}) : super(key: key);

  @override
  State<inappWebview> createState() => _inappWebviewState();
}

class _inappWebviewState extends State<inappWebview> {

  TextEditingController txtSearch = TextEditingController();
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
          useShouldOverrideUrlLoading: true,
          mediaPlaybackRequiresUserGesture: false),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));
  InAppWebViewController? inAppWebViewController;

  webProvider? webProvideFalse;
  webProvider? webProvideTrue;

  @override
  Widget build(BuildContext context) {
    webProvideFalse = Provider.of<webProvider>(context,listen: false);
    webProvideTrue = Provider.of<webProvider>(context,listen: true);


    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: txtSearch,
                      decoration: InputDecoration(hintText: "Search",border: OutlineInputBorder()),
                    ),
                  ),
                  IconButton(onPressed: (){}, icon: Icon(Icons.search)),
                ],
              ),
            ),
            SizedBox(height: 5),
            LinearProgressIndicator(
              color: Colors.indigo,
              value: webProvideTrue!.progressWeb.toDouble(),
              backgroundColor: Colors.indigo.shade200,
            ),
            Expanded(
              child: InAppWebView(
                 initialUrlRequest: URLRequest(
                   url: Uri.parse(webProvideTrue!.url)
                 ),
                onLoadStart: (controller,uri){
                   inAppWebViewController = controller;
                   webProvideFalse!.changeNewUrl(uri.toString());
                },
                onLoadStop: (controller,uri){
                  inAppWebViewController = controller;
                  webProvideFalse!.changeNewUrl(uri.toString());
                },
                onLoadError: (controller,uri,code,messge){
                  inAppWebViewController = controller;
                },
                onProgressChanged: (controller,progress){
                   webProvideFalse!.newprogress(progress);
                },
                androidOnPermissionRequest: (controller,_,resources)async{
                   return PermissionRequestResponse(
                     resources: resources,
                     action: PermissionRequestResponseAction.GRANT,
                   );
                },
                initialOptions: options,


              ),
            ),
          ],
        ),
      ),
    );
  }
}

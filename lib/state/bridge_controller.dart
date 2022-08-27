
/// provides a default set of methods bridge class constructors should have

abstract class BridgeController {
  //This method is run whenever a bridgeBuilder widget is dismounted from the widget tree
  void dispose();
  //THis method is run whenever a bridgeBuilder widget is mounted to the widget tree
  void initialise();
}

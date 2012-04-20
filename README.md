This is a fork of [TwUI](http://github.com/twitter/twui) that adds integration with the [Velvet](http://github.com/bitswift/Velvet) UI bridging framework.

# Changes

This fork includes the `TUIVelvetView` and `VELTUIView` classes, which implement bridging between TwUI and Velvet view hierachies. When used in conjunction with the AppKit bridging capabilities of Velvet, it becomes possible to embed TwUI views within AppKit hierarchies, and vice-versa.

Additionally, Velvet protocols (like `<VELBridgedView>`) have been implemented on the appropriate `TUIView` classes.

# License

This fork is licensed under the same terms as mainline TwUI. See the LICENSE file for more information.

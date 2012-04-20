This is a fork of [TwUI](http://github.com/twitter/twui) that adds integration with the [Velvet](http://github.com/bitswift/Velvet) UI bridging framework.

# Changes

This fork includes the `TUIVelvetView` and `VELTUIView` classes, which implement bridging between TwUI and Velvet view hierachies. When used in conjunction with the AppKit bridging capabilities of Velvet, it becomes possible to embed TwUI views within AppKit hierarchies, and vice-versa.

Additionally, Velvet protocols (like `<VELBridgedView>`) have been implemented on the appropriate `TUIView` classes.

# Dependencies

Naturally, this fork is dependent upon [Velvet](http://github.com/bitswift/Velvet). The required files can be retrieved by running `git submodule update --init --recursive` from the top level of the repository.

# License

This fork is licensed under the same terms as mainline TwUI. See the LICENSE file for more information.

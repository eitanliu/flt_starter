#ifndef FLUTTER_PLUGIN_FLT_STARTER_PLUGIN_H_
#define FLUTTER_PLUGIN_FLT_STARTER_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace flt_starter {

class FltStarterPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  FltStarterPlugin();

  virtual ~FltStarterPlugin();

  // Disallow copy and assign.
  FltStarterPlugin(const FltStarterPlugin&) = delete;
  FltStarterPlugin& operator=(const FltStarterPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace flt_starter

#endif  // FLUTTER_PLUGIN_FLT_STARTER_PLUGIN_H_
